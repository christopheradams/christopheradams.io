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
    token = ENV["LISTMONK_TOKEN"]

    use_token_header = ENV.fetch("LISTMONK_AUTH_MODE", "").downcase == "header"

    list_ids = ENV.fetch("LISTMONK_LIST_IDS").split(",").map(&:strip).reject(&:empty?).map(&:to_i)
    raise "LISTMONK_LIST_IDS must contain at least one list id" if list_ids.empty?

    name = ENV["LISTMONK_CAMPAIGN_NAME"].to_s
    name = rendered[:title].to_s if name.empty?

    subject = ENV["LISTMONK_SUBJECT"].to_s
    subject = rendered[:title] if subject.empty?

    type = ENV.fetch("LISTMONK_CAMPAIGN_TYPE", "regular")
    template_id = ENV["LISTMONK_TEMPLATE_ID"]&.to_s&.strip
    template_id = template_id.to_i if template_id && !template_id.empty?
    from_email = ENV["LISTMONK_FROM_EMAIL"]
    from_name = ENV["LISTMONK_FROM_NAME"]

    tags = ENV["LISTMONK_TAGS"]&.split(",")&.map(&:strip)&.reject(&:empty?)

    client = Newsletter::ListmonkClient.new(
      base_url: base_url,
      username: username,
      token: token,
      use_token_header: use_token_header
    )

    res = client.create_campaign!(
      name: name,
      subject: subject,
      lists: list_ids,
      html_body: html_body,
      type: type,
      template_id: template_id,
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
    fragment = rendered[:html].to_s

    fragment = strip_excerpt(fragment)
    fragment.strip + "\n"
  end

  # Your site uses <!--more--> as excerpt_separator.
  # If it survives into the rendered output, remove it for email.
  def strip_excerpt(html)
    html.to_s.gsub("<!--more-->", "")
  end

end

