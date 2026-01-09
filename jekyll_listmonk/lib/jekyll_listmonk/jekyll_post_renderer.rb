module JekyllListmonk
  class JekyllPostRenderer
    class Error < StandardError; end

    def initialize(source_dir: Dir.pwd, jekyll_env: ENV.fetch("JEKYLL_ENV", "production"))
      @source_dir = source_dir
      @jekyll_env = jekyll_env
      @rewriter = PictureTagRewriter.new
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

      original_layout = doc.data["layout"]
      original_content = doc.content

      doc.data["layout"] = nil
      doc.content = @rewriter.rewrite(original_content, frontmatter_image: doc.data["image"])

      renderer = Jekyll::Renderer.new(site, doc)
      html = renderer.run.to_s
      html = @rewriter.strip_responsive_img_attributes(html)

      doc.data["layout"] = original_layout
      doc.content = original_content

      { title: doc.data["title"].to_s, html: html }
    rescue LoadError => e
      raise Error, "Jekyll not available: #{e.message}. Run inside a Jekyll repo with Bundler (bundle exec ...)."
    end

    private

    def resolve_post!(site, identifier)
      id = identifier.to_s.strip
      raise Error, "Missing post identifier" if id.empty?

      candidates = site.posts.docs

      if id.include?("/") || id.end_with?(".md", ".markdown")
        normalized = id.sub(%r{\A\./}, "")
        match = candidates.find { |d| d.relative_path == normalized || d.path.end_with?(normalized) }
        return match if match
        raise Error, "No post matched path #{identifier.inspect}"
      end

      matches = candidates.select do |d|
        stem = File.basename(d.path, ".*")
        slug = stem.sub(/^\d{4}-\d{2}-\d{2}-/, "")
        dslug = d.data["slug"].to_s

        id == stem || id == slug || (!dslug.empty? && id == dslug) || stem.include?(id)
      end

      return matches.first if matches.size == 1
      raise Error, "No post matched #{identifier.inspect}" if matches.empty?

      raise Error,
            "Ambiguous identifier #{identifier.inspect}. Matches: #{matches.map { |d| d.relative_path }.join(', ')}"
    end
  end
end

