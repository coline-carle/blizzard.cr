require "../spec_helper"

describe Blizzard::Client do
  describe ".initialize" do
      it "should be a Blizzard::Client" do
        Blizzard::Client.new(BLIZZARD_REGION, token).should be_a Blizzard::Client
      end

      it "should set western endpoints properly" do
        client = Blizzard::Client.new("us", token)
        client.endpoint.should eq "https://us.api.blizzard.com"
      end

      it "should set china region properly" do
        client = Blizzard::Client.new("cn", token)
        client.endpoint.should eq "https://gateway.battlenet.com.cn"
      end
  end
end
