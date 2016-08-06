require "spec_helper"

describe Mediumite::Client do
  describe "instantiation" do
    it "masks token on inspect" do
      client = Mediumite::Client.new(token: "abcdefghijklmnopqrstuvwxyz")
      inspected = client.inspect
      expect(inspected).not_to include("abcdefghijklmnopqrstuvwxyz")
    end
  end

  describe "#token" do
    it "returns given token" do
      client = Mediumite::Client.new(token: "token")
      expect(client.token).to eq "token"
    end
  end
end
