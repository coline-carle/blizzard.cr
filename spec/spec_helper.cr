require "spec"
require "webmock"
require "oauth2"
require "../src/blizzard"

BLIZZARD_TOKEN = "token"
BLIZZARD_REGION = "us"

def token
  OAuth2::AccessToken::Bearer.new(BLIZZARD_TOKEN, 86_400)
end

def client
  Blizzard.client(BLIZZARD_REGION, token)
end

def load_fixture(name : String?)
  return "" unless name
  File.read_lines(File.dirname(__FILE__) + "/fixtures/#{name}.json").join("\n")
end

def stub_get(path, fixture, params = nil, response_headers = {} of String => String)
  query = "?#{HTTP::Params.escape(params)}" if params

  response_headers.merge!({"Content-Type" => "application/json"})
  WebMock.stub(:get, "#{client.endpoint}#{path}#{query}")
         .to_return(body: load_fixture(fixture), headers: response_headers)
end

