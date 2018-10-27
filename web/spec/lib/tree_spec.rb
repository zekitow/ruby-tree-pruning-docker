require "./spec/spec_helper"

describe Tree do
  describe ".api" do
    subject { Tree.api }

    it "should return Faraday instance" do
      expect(subject).to be_a_kind_of(Faraday::Connection)
    end
  end
end