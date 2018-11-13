module Blizzard
  class OAuth2
    AuthorizeURI = "/oauth/token"
    TokenURI = "/oauth/token"
    Defaultegion = "us"

    @host : String
    @client_id : String
    @client_secret : String
    @redirect_uri : String?


    def initialize(region : String, @client_id, @client_secret, @redirect_uri = nil)
      @host = host(region)
      @client = ::OAuth2::Client.new(
        host(region),
        @client_id,
        @client_secret,
        redirect_uri: @redirect_uri,
        authorize_uri: AuthorizeURI,
        token_uri: TokenURI
      )
    end

    def get_authorize_uri(scope = nil, state = nil)
      @client.get_authorize_uri(scope, state)
    end

    def get_access_token_using_authorization_code(authorization_code : String)
      @client.get_access_token_using_authorization_code(authorization_code)
    end

    def get_access_token_using_client_credentials
      @client.get_access_token_using_client_credentials
    end

    private def host(region : String)
      case region
      when "cn"
         "www.battlenet.com.cn"
      else
        "#{region}.battle.net"
      end
    end
  end
end
