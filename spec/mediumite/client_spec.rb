require "spec_helper"

describe Mediumite::Client do
  describe "#token" do
    let(:instance) do
      Mediumite::Client.new(token: "token")
    end

    it "returns given token" do
      expect(instance.token).to eq "token"
    end
  end
end
