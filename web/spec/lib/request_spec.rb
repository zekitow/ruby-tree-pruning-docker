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

        it "should return 404 status and error description" do
          expect(subject).to eq([{ "error" => "Can't find that tree" }, 404])
        end
      end

      context "and data exists", :vcr do
        let(:upstream) { "input" }

        context "when API is up" do
          it "should return 200 status and items" do
            response = subject
            body   = response[0]
            status = response[1]
            expect(status).to eq(200)
            expect(body.count).to eq(12)
          end
        end

        context "and API raises an internal error", :vcr do
          it "should retry GET" do
            response = subject
            body     = response[0]
            status   = response[1]
            expect(status).to eq(200)
            expect(body.count).to eq(12)
          end
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