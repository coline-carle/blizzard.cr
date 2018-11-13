require "../wow/**"

module Blizzard
  class Client
    # define method related to World of Warcraft Community API
    #
    # see : https://develop.battle.net/documentation/api-reference/world-of-warcraft-community-api
    module WoW
      def wow_guild(realm : String, guild_name : String, fields : Array(String) = [] of String, locale : String? = nil)
        params = build_wow_param(locale, fields)
        body = get("/wow/guild/#{realm}/#{guild_name}", params)
        Blizzard::WoW::Guild.from_json(body)
      end


      private def build_wow_param(locale : String?, fields : Array(String))
        Hash(String, String).new.tap do |obj|
          obj["locale"] = locale.as(String) if locale.is_a? String
          obj["fields"] = fields.as(Array(String)).join(",") unless fields.empty?
        end
      end
    end
  end
end
