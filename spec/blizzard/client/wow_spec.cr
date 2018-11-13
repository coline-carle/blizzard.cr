require "../../spec_helper"

describe Blizzard::Client::WoW do
 describe ".guild" do
   stub_get("/wow/guild/tarren-mill/method", "guild")
   guild = client.wow_guild("tarren-mill", "method")
   guild.should be_a Blizzard::WoW::Guild
   guild.name.should eq "Method"
 end
end
