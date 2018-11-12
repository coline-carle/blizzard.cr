require "./spec_helper"

describe Blizzard do
  describe ".client" do
    it "should be a Blizzard::Client" do
      Blizzard.client(BLIZZARD_REGION, token).should be_a Blizzard::Client
    end
  end
end
