require "json"

module Blizzard
	module WoW
    class Achievement
      JSON.mapping({
        achievements_completed: { key: "achievementsCompleted", type: Array(Int32) },
        achievements_completed_timestamp: { key: "achievementsCompletedTimestamp", type: Array(Int64) },
        criteria: Array(Int32),
        criteria_quantity: { key: "criteriaQuantity", type: Array(Int32 | Int64) },
        criteria_timestamp: { key: "criteriaTimestamp", type: Array(Int64) },
        criteria_created: { key: "criteriaCreated", type: Array(Int64) }
      })
    end
  end
end
