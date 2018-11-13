require "json"

module Blizzard
  module Warcraft
    class Character
      JSON.mapping({
        name: String,
        realm: String,
        battlegroup: String,
        class: Int32,
        race: Int32,
        gender: Int32,
        level: Int32,
        achievement_points: { key: "achievementPoints", type: Int32 },
        thumbnail: String,
        spec: Spec?,
        guild: String,
        guild_realm: { key: "guildRealm", type: String },
        last_modified: { key: "lastModified", type: Int32 }
      })
      class Spec
        JSON.mapping({
          name: String,
          role: String,
          background_image: { key: "backgroundImage", type: String },
          icon: String,
          description: String,
          order: Int32
        })

      end
    end
  end
end
