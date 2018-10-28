require "./spec/spec_helper"

describe Request do

  describe ".get" do
    subject { Request.get(upstream) }
    
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
          response = subject
          expect(response.status).to eq(404)
          expect(response.content.error).to eq("Can't find that tree")
        end
      end

      context "and data exists", :vcr do
        let(:upstream) { "input" }

        context "when API is up" do
          it "should return 200 status and items" do
            response = subject
            expect(response.status).to eq(200)
            expect(response.content.count).to eq(12)
          end
        end

        context "and API raises an internal error", :vcr do
          it "should retry GET" do
            response = subject
            expect(response.status).to eq(200)
            expect(response.content.count).to eq(12)
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