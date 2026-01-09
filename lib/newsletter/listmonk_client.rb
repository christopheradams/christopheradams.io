require "json"
require "net/http"
require "uri"

module Newsletter
  class ListmonkClient
    class Error < StandardError; end

    def initialize(base_url:, username: nil, password: nil, token: nil, timeout: 30)
      @base_uri = URI(base_url)
      @username = username
      @password = password
      @token = token
      @timeout = timeout
    end

    def create_campaign!(
      name:,
      subject:,
      lists:,
      html_body:,
      type: "regular",
      from_email: nil,
      from_name: nil,
      tags: nil
    )
      payload = {
        name: name,
        subject: subject,
        lists: lists,
        type: type,
        content_type: "html",
        body: html_body
      }

      payload[:from_email] = from_email if from_email && !from_email.empty?
      payload[:from_name] = from_name if from_name && !from_name.empty?
      payload[:tags] = tags if tags && !tags.empty?

      post_json!("/api/campaigns", payload)
    end

    private

    def post_json!(path, payload)
      uri = @base_uri.dup
      uri.path = File.join(uri.path, path)

      req = Net::HTTP::Post.new(uri)
      req["Accept"] = "application/json"
      req["Content-Type"] = "application/json"
      req.body = JSON.dump(payload)

      if @token && !@token.empty?
        req["Authorization"] = "Bearer #{@token}"
      elsif @username && @password
        req.basic_auth(@username, @password)
      end

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == "https")
      http.open_timeout = @timeout
      http.read_timeout = @timeout

      res = http.request(req)
      body = res.body.to_s

      unless res.is_a?(Net::HTTPSuccess)
        raise Error, "Listmonk API error (HTTP #{res.code}): #{body}"
      end

      JSON.parse(body)
    rescue JSON::ParserError
      raise Error, "Listmonk API returned non-JSON response (HTTP #{res&.code}): #{body}"
    end
  end
end
