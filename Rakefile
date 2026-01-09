require "rake"

require_relative "lib/newsletter/jekyll_post_renderer"
require_relative "lib/newsletter/listmonk_client"

namespace :newsletter do
  desc "Preview the rendered email HTML for a post (DRY_RUN=1 is implied)"
  task :preview, [:post] do |_, args|
    post = args[:post].to_s
    abort "Usage: bundle exec rake newsletter:preview[post-slug-or-path]" if post.empty?

    rendered = Newsletter::JekyllPostRenderer.new.render_post_fragment!(post)
    puts NewsletterEmail.compose(rendered)
  end

  desc "Create a Listmonk campaign from a Jekyll post (set LISTMONK_* env vars)"
  task :campaign, [:post] do |_, args|
    post = args[:post].to_s
    abort "Usage: bundle exec rake newsletter:campaign[post-slug-or-path]" if post.empty?

    rendered = Newsletter::JekyllPostRenderer.new.render_post_fragment!(post)
    html_body = NewsletterEmail.compose(rendered)

    if ENV["DRY_RUN"].to_s == "1"
      puts html_body
      warn "DRY_RUN=1 set, not calling Listmonk."
      next
    end

    base_url = ENV.fetch("LISTMONK_URL")
    username = ENV["LISTMONK_USER"]
    password = ENV["LISTMONK_PASSWORD"]
    token = ENV["LISTMONK_TOKEN"]

    list_ids = ENV.fetch("LISTMONK_LIST_IDS").split(",").map(&:strip).reject(&:empty?).map(&:to_i)
    raise "LISTMONK_LIST_IDS must contain at least one list id" if list_ids.empty?

    name = ENV["LISTMONK_CAMPAIGN_NAME"].to_s
    name = "Newsletter: #{rendered[:title]}" if name.empty?

    subject = ENV["LISTMONK_SUBJECT"].to_s
    subject = rendered[:title] if subject.empty?

    type = ENV.fetch("LISTMONK_CAMPAIGN_TYPE", "regular")
    from_email = ENV["LISTMONK_FROM_EMAIL"]
    from_name = ENV["LISTMONK_FROM_NAME"]

    tags = ENV["LISTMONK_TAGS"]&.split(",")&.map(&:strip)&.reject(&:empty?)

    client = Newsletter::ListmonkClient.new(
      base_url: base_url,
      username: username,
      password: password,
      token: token
    )

    res = client.create_campaign!(
      name: name,
      subject: subject,
      lists: list_ids,
      html_body: html_body,
      type: type,
      from_email: from_email,
      from_name: from_name,
      tags: tags
    )

    id = res.dig("data", "id") || res["id"]
    warn "Created Listmonk campaign id=#{id || "(unknown)"}"
  end
end

# Email composition lives here for now; later you can extract into lib/.
module NewsletterEmail
  module_function

  def compose(rendered)
    title = rendered[:title].to_s
    description = rendered[:description].to_s
    url = rendered[:url].to_s
    fragment = rendered[:html].to_s

    fragment = strip_excerpt(fragment)

    header_bits = []
    header_bits << %(<h1 style="margin: 0 0 0.5em 0;">#{escape_html(title)}</h1>) unless title.empty?
    header_bits << %(<p style="margin: 0 0 1em 0; opacity: 0.85;">#{escape_html(description)}</p>) unless description.empty?
    header_bits << %(<p style="margin: 0 0 1.5em 0;"><a href="#{escape_attr(url)}">Read on the web</a></p>) unless url.empty?

    (header_bits.join("\n") + "\n" + fragment).strip + "\n"
  end

  # Your site uses <!--more--> as excerpt_separator.
  # If it survives into the rendered output, remove it for email.
  def strip_excerpt(html)
    html.to_s.gsub("<!--more-->", "")
  end

  def escape_html(s)
    s.to_s
      .gsub("&", "&amp;")
      .gsub("<", "&lt;")
      .gsub(">", "&gt;")
      .gsub('"', "&quot;")
      .gsub("'", "&#39;")
  end

  def escape_attr(s)
    escape_html(s)
  end
end

