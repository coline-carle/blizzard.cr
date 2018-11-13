require "oauth2"
require "http/client"
require "json"

require "./client/**"

module Blizzard
  class Client
    @host : String
    @client : HTTP::Client
    @locale : String?
    @token : ::OAuth2::AccessToken

    def initialize(region : String, @token, @locale = nil)
      @host = get_host(region)
      @client = HTTP::Client.new(@host, tls: true)
      @token.authenticate(@client)
    end


    def endpoint
      "https://#{@host}"
    end

    def get(uri : String, params : Hash(String, String)? = nil)
      params = params ? default_params.merge(params) : default_params
      encoded_params = HTTP::Params.encode(params)

      uri = "#{uri}?#{encoded_params}" if !encoded_params.empty?

			full_uri = "#{endpoint}#{uri}"
      response = @client.get(uri)
			validate(full_uri, response)
      response.body
    end

    private def validate(uri : String, response : HTTP::Client::Response)
			case response.status_code
				when 200 then return
				when 400 then raise Error::BadRequest.new(uri, response)
				when 401 then raise Error::Unauthorized.new(uri, response)
				when 403 then raise Error::Forbidden.new(uri, response)
				when 404 then raise Error::NotFound.new(uri, response)
				when 405 then raise Error::MethodNotAllowed.new(uri, response)
				when 422 then raise Error::Unprocessable.new(uri, response)
				when 500 then raise Error::InternalServerError.new(uri, response)
				when 502 then raise Error::BadGateway.new(uri, response)
				when 503 then raise Error::ServiceUnavailable.new(uri, response)
				else Error::APIError.new(uri, response)
			end
    end

    private def get_host(region : String)
      case region
      when "cn"
         "gateway.battlenet.com.cn"
      else
        "#{region}.api.blizzard.com"
      end
    end

    private def default_params
      Hash(String, String).new.tap do |obj|
        if @locale.is_a? String
          obj["locale"] = @locale.as(String)
        end
      end
    end

    include WoW
  end
end
