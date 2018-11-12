require "json"
module Blizzard
	module Warcraft
    class Log
      JSON.mapping({
        type: String,
        character: String,
        timestamp: Int64,
        item_id: { key: "itemId", type: Int32 },
        context: String,
        bonus_lists: { key: "bonusLists", type: Array(Int32) }
      })
    end
  end
end
