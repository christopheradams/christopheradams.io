require "json"
require "net/http"
require "uri"

module Newsletter
  class ListmonkClient
    class Error < StandardError; end

    # Auth modes supported by listmonk:
    # - Basic auth: username=api_user, token=api_token (sent as user:token)
    # - Authorization header: "token api_user:api_token"
    #
    # This client supports both. By default, if username+token are provided, it uses Basic auth.
    #
    # For legacy/backcompat, username+password is also supported.
    def initialize(
      base_url:,
      username: nil,
      password: nil,
      token: nil,
      use_token_header: false,
      timeout: 30
    )
      @base_uri = URI(base_url)
      @username = username
      @password = password
      @token = token
      @use_token_header = use_token_header
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

      apply_auth!(req)

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

    def apply_auth!(req)
      if present?(@username) && present?(@token)
        if @use_token_header
          req["Authorization"] = "token #{@username}:#{@token}"
        else
          req.basic_auth(@username, @token)
        end
        return
      end

      if present?(@username) && present?(@password)
        req.basic_auth(@username, @password)
        return
      end
    end

    def present?(s)
      s && !s.to_s.empty?
    end
  end
end
