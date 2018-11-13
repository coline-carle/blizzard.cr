require "oauth2"
require "./blizzard/**"

module Blizzard
  VERSION = "0.1.0"

   # Alias for Blizzard::Client.new
  def self.client(region : String, token : ::OAuth2::AccessToken) : Client
    Client.new(region, token)
  end
end
