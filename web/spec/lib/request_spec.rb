require "./spec/spec_helper"

describe Request do

  describe ".fetch_json" do
    subject { Request.fetch_json(upstream) }
    
    context "when upstream is nil" do
      let(:upstream) { nil }

      it "should raise ArgumentError" do
        expect { subject }.to raise_error(ArgumentError, "Upstream is required.")
      end
    end

    context "when upstream is NOT nil" do
      context "and data exists", :vcr do
        let(:upstream) { "non-existent" }

        it "should return 404 status" do
          status = subject[1]
          expect(status).to eq(404)
        end

        it "should return error description" do
          body = subject[0]
          expect(body).to eq({ "error" => "Can't find that tree" })
        end
      end

      context "and data exists", :vcr do
        let(:upstream) { "input" }

        it "should return 200 status" do
          status = subject[1]
          expect(status).to eq(200)
        end

        it "should return the json" do
          body = subject[0]
          expect(body).to_not be_empty
        end
      end
    end
  end

  describe ".api" do
    subject { Request.api }

    it "should return the Faraday instance" do
      expect(subject).to be_a_kind_of(Faraday::Connection)
    end
  end
end