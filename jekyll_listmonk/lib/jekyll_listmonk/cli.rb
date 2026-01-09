require "optparse"

module JekyllListmonk
  class CLI
    def self.run(argv)
      new(argv).run
    rescue Interrupt
      warn "Interrupted."
      130
    rescue StandardError => e
      warn "Error: #{e.message}"
      1
    end

    def initialize(argv)
      @argv = argv.dup
      @source = Dir.pwd
    end

    def run
      global = OptionParser.new do |o|
        o.banner = "Usage: jekyll-listmonk [--source PATH] <command> <post-id>\n\nCommands: preview, campaign"
        o.on("--source PATH", "Jekyll site path (default: current directory)") { |v| @source = v }
        o.on("-h", "--help", "Show help") { puts o; return 0 }
      end
      global.order!(@argv)

      cmd = @argv.shift
      post = @argv.shift
      raise "Missing command (preview|campaign)" if cmd.nil? || cmd.empty?
      raise "Missing post identifier" if post.nil? || post.empty?

      renderer = JekyllPostRenderer.new(source_dir: @source)
      rendered = renderer.render_post_fragment!(post)
      html = rendered[:html].to_s

      case cmd
      when "preview"
        puts html
        0
      when "campaign"
        if ENV["DRY_RUN"].to_s == "1"
          puts html
          warn "DRY_RUN=1 set, not calling Listmonk."
          return 0
        end

        client = ListmonkClient.from_env

        name = ENV["LISTMONK_CAMPAIGN_NAME"].to_s
        name = rendered[:title].to_s if name.empty?

        subject = ENV["LISTMONK_SUBJECT"].to_s
        subject = rendered[:title].to_s if subject.empty?

        list_ids = ENV.fetch("LISTMONK_LIST_IDS").split(",").map(&:strip).reject(&:empty?).map(&:to_i)
        raise "LISTMONK_LIST_IDS must contain at least one list id" if list_ids.empty?

        type = ENV.fetch("LISTMONK_CAMPAIGN_TYPE", "regular")

        template_id = ENV["LISTMONK_TEMPLATE_ID"]&.to_s&.strip
        template_id = template_id.to_i if template_id && !template_id.empty?

        from_email = ENV["LISTMONK_FROM_EMAIL"]
        from_name = ENV["LISTMONK_FROM_NAME"]
        tags = ENV["LISTMONK_TAGS"]&.split(",")&.map(&:strip)&.reject(&:empty?)

        res = client.create_campaign!(
          name: name,
          subject: subject,
          lists: list_ids,
          html_body: html,
          type: type,
          template_id: template_id,
          from_email: from_email,
          from_name: from_name,
          tags: tags
        )

        id = res.dig("data", "id") || res["id"]
        warn "Created Listmonk campaign id=#{id || "(unknown)"}"
        0
      else
        raise "Unknown command: #{cmd.inspect} (expected preview|campaign)"
      end
    end
  end
end

