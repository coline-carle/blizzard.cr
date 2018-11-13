require "json"
require "./achievement"
require "./character"
require "./log"

module Blizzard
	module WoW
		class Guild
      JSON.mapping({
        last_modified: { key: "lastModified", type: Int64 },
        name: String,
        realm: String,
        battlegroup: String,
        level: Int32,
        side: Int32,
        achievement_points: { key: "achievementPoints", type: Int32 },
        achievements: Array(Achievement)?,
        members: Array(Member)?,
        emblem: Emblem,
        news: Array(Log)?,
        challenge: Array(Log)?,
      })

      class Emblem
        JSON.mapping({
          icon: Int32,
          icon_color: { key: "iconColor", type: String },
          icon_color_id: { key: "iconColorId", type: Int32 },
          border: Int32,
          border_color: { key: "borderColor", type: String },
          border_color_id: { key: "borderColorId", type: Int32 },
          background_color: { key: "backgroundColor", type: String },
          background_color_id: { key: "backgroundColorId", type: Int32 }
        })
      end


      class Member
        JSON.mapping({
          character: Character,
          rank: Int32
        })
      end
    end

	end
end
