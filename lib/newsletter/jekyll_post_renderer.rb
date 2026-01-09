module Newsletter
  class JekyllPostRenderer
    class Error < StandardError; end

    def initialize(source_dir: Dir.pwd, jekyll_env: ENV.fetch("JEKYLL_ENV", "production"))
      @source_dir = source_dir
      @jekyll_env = jekyll_env
    end

    # identifier can be:
    # - a slug like "instructions-beyond-code"
    # - a post filename stem like "2024-03-07-instructions-beyond-code"
    # - a path like "_posts/2024-03-07-instructions-beyond-code.md"
    def render_post_fragment!(identifier)
      require "jekyll"

      ENV["JEKYLL_ENV"] = @jekyll_env

      site = Jekyll::Site.new(Jekyll.configuration({ "source" => @source_dir, "quiet" => true }))
      site.reset
      site.read

      doc = resolve_post!(site, identifier)

      # Render without wrapping in the site's HTML layout (emails want fragments).
      original_layout = doc.data["layout"]
      original_content = doc.content

      doc.data["layout"] = nil
      doc.content = rewrite_picture_tags_for_newsletter(
        inject_frontmatter_image_picture_tag(original_content, doc.data["image"])
      )

      renderer = Jekyll::Renderer.new(site, doc)
      html = renderer.run.to_s
      html = strip_responsive_img_attributes(html)

      doc.data["layout"] = original_layout
      doc.content = original_content

      {
        title: doc.data["title"].to_s,
        description: doc.data["description"].to_s,
        url: absolute_url_for(site, doc),
        html: html
      }
    rescue LoadError => e
      raise Error, "Jekyll not available: #{e.message}. Run with Bundler (e.g. bundle exec rake ...)."
    end

    private

    # Converts "{% picture /path --img class="..." %}" into "{% picture newsletter /path %}"
    # and strips any "--img class=..." option since email doesn't need your site CSS classes.
    #
    # Assumptions from this repo:
    # - picture tags begin at the start of a line
    # - each tag is its own block, but it may span multiple lines until "%}"
    def rewrite_picture_tags_for_newsletter(markdown)
      out = +""
      lines = markdown.to_s.lines

      i = 0
      while i < lines.length
        line = lines[i]

        if line.lstrip.start_with?("{% picture")
          tag = +""
          loop do
            tag << lines[i]
            i += 1
            break if tag.include?("%}") || i >= lines.length
          end

          out << transform_picture_tag_for_newsletter(tag)
          next
        end

        out << line
        i += 1
      end

      out
    end

    def transform_picture_tag_for_newsletter(tag)
      m = tag.match(/\A(\s*)\{\%\s*picture\s+([\s\S]*?)\s*\%\}(\s*)\z/)
      return tag unless m

      leading_ws = m[1]
      inner = m[2]
      trailing_ws = m[3]

      inner_lstripped = inner.lstrip
      if inner_lstripped.start_with?("/") || inner_lstripped.start_with?("./") || inner_lstripped.start_with?("../")
        inner = "newsletter " + inner_lstripped
      else
        inner = inner_lstripped
      end

      # Remove `--img class="..."` (and single-quote variant).
      inner = inner.gsub(/\s+--img\s+class=(\"[^\"]*\"|'[^']*')/, "")

      "#{leading_ws}{% picture #{inner.rstrip} %}#{trailing_ws}"
    end

    # If the post front matter includes an `image` field, inject a `{% picture ... %}`
    # tag at the very beginning of the post content.
    #
    # Supported front matter formats:
    # - image: assets/images/foo.jpg
    # - image:
    #     path: /assets/images/foo.jpg
    #     title: Some Title
    #
    # Injection is skipped only if the first `{% picture ... %}` block already references
    # the same image path (to avoid duplicates). If the post begins with a different
    # picture tag, we still inject the front matter image above it.
    def inject_frontmatter_image_picture_tag(markdown, image_field)
      content = markdown.to_s

      image_path, image_alt = extract_frontmatter_image(image_field)
      return content if image_path.nil? || image_path.to_s.strip.empty?

      image_path = normalize_image_path(image_path)

      tag = +"{% picture #{image_path}"
      if image_alt && !image_alt.to_s.strip.empty?
        tag << %( --alt "#{escape_liquid_double_quotes(one_line(image_alt))}")
      end
      tag << " %}\n"

      # Avoid double-inserting if the post already starts with this image.
      first_picture = first_picture_block(content)
      if first_picture && first_picture.include?(image_path)
        return content
      end

      tag + "\n" + content
    end

    def first_picture_block(markdown)
      lines = markdown.to_s.lines
      i = 0
      while i < lines.length
        line = lines[i]
        if line.strip.empty?
          i += 1
          next
        end

        return nil unless line.lstrip.start_with?("{% picture")

        block = +""
        loop do
          block << lines[i]
          i += 1
          break if block.include?("%}") || i >= lines.length
        end
        return block
      end
      nil
    end

    def extract_frontmatter_image(image_field)
      case image_field
      when String
        [image_field, nil]
      when Hash
        path = image_field["path"] || image_field[:path]
        title = image_field["title"] || image_field[:title]
        [path, title]
      else
        [nil, nil]
      end
    end

    def normalize_image_path(path)
      p = path.to_s.strip
      return p if p.empty?

      # Normalize to an absolute path for consistency with existing tags in this repo.
      p = "/#{p}" unless p.start_with?("/", "./", "../")
      p
    end

    def one_line(s)
      s.to_s.gsub(/\s+/, " ").strip
    end

    def escape_liquid_double_quotes(s)
      s.to_s.gsub("\\", "\\\\").gsub('"', '\"')
    end

    # Many email clients don't need (or want) responsive image attributes.
    # If a picture tag renders to a single 640w image, jekyll_picture_tag still
    # emits srcset="... 640w". For newsletters, strip srcset/sizes.
    def strip_responsive_img_attributes(html)
      html.to_s
        .gsub(/\s+srcset=(\"[^\"]*\"|'[^']*')/, "")
        .gsub(/\s+sizes=(\"[^\"]*\"|'[^']*')/, "")
    end

    def resolve_post!(site, identifier)
      id = identifier.to_s.strip
      raise Error, "Missing post identifier" if id.empty?

      candidates = site.posts.docs

      # If it looks like a path, match by relative path.
      if id.include?("/") || id.end_with?(".md", ".markdown")
        normalized = id.sub(%r{\A\./}, "")
        match = candidates.find { |d| d.relative_path == normalized || d.path.end_with?(normalized) }
        return match if match
        raise Error, "No post matched path #{identifier.inspect}"
      end

      # Otherwise allow slug or filename-stem matching.
      matches = candidates.select do |d|
        stem = File.basename(d.path, ".*")
        slug = stem.sub(/^\d{4}-\d{2}-\d{2}-/, "")
        dslug = d.data["slug"].to_s

        id == stem || id == slug || (!dslug.empty? && id == dslug) || stem.include?(id)
      end

      return matches.first if matches.size == 1

      if matches.empty?
        raise Error, "No post matched #{identifier.inspect}"
      end

      raise Error, "Ambiguous identifier #{identifier.inspect}. Matches: #{matches.map { |d| d.relative_path }.join(', ')}"
    end

    def absolute_url_for(site, doc)
      base = site.config["url"].to_s
      baseurl = site.config["baseurl"].to_s
      path = doc.url.to_s

      return path if base.empty?

      base = base.sub(%r{/\z}, "")
      baseurl = baseurl.sub(%r{\A/}, "").sub(%r{/\z}, "")
      path = path.sub(%r{\A/}, "")

      pieces = [base]
      pieces << baseurl unless baseurl.empty?
      pieces << path unless path.empty?
      pieces.join("/")
    end
  end
end

