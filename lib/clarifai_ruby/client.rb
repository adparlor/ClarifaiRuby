require 'faraday_middleware'

module ClarifaiRuby
  class RequestError < StandardError; end

  class Client
    attr_reader :api_key, :conn

    def initialize
      @api_key = ClarifaiRuby.configuration.api_key
    end

    def conn
      @conn ||= Faraday.new(url: ClarifaiRuby.configuration.base_url) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter  Faraday.default_adapter
      end
    end

    def get(url, opts = {})
      conn.get("#{ClarifaiRuby.configuration.version_path}/#{url}", opts)
      # TODO: handle raising any errors here
    end

    def post(url, body = {})
      conn.post do |request|
        request.url "#{ClarifaiRuby.configuration.version_path}/#{url}"
        request.headers['Content-Type'] = 'application/json'
        request.headers['Authorization'] = "Key #{api_key}"
        request.body = body.to_json
      end
      # TODO: handle raising any errors here
    end
  end
end
