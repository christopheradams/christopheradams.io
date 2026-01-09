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
      doc.data["layout"] = nil

      renderer = Jekyll::Renderer.new(site, doc)
      html = renderer.run.to_s

      doc.data["layout"] = original_layout

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

