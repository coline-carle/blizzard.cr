require "../warcraft/**"

module Blizzard
  class Client
    # define method related to World of Warcraft Community API
    #
    # see : https://develop.battle.net/documentation/api-reference/world-of-warcraft-community-api
    module Warcraft
      def wow_guild(realm : String, guild_name : String, fields : Arrray(String)? = nil, locale : String? = nil)
        params = build_wow_param(locale, fields)
        body = get("/wow/guild/#{realm}/#{guild_name}", params)
        Blizzard::Warcraft::Guild.from_json(body)
      end


      private def build_wow_param(locale : String?, fields : Array(String)? = nil)
        Hash(String, String).new.tap do |obj|
          obj["locale"] = locale.as(String) if locale.is_a? String
          obj["fields"] = fields.as(Array(String)).join(",") if fields.is_a? Array(String)
        end
      end
    end
  end
end
