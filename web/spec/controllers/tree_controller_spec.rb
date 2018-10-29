require './spec/spec_helper'

describe TreeController do
  describe 'GET /tree' do
    subject { get "/tree/#{upstream}#{query_string}", {} }

    context "when upstream is not sent" do
      let(:upstream)     { nil }
      let(:query_string) { nil }

      it "should return 404 status" do
        expect(subject.status).to eql(404)
      end

      it "should return not found body description" do
        expect(subject.body).to eq("{\"status\":404,\"message\":\"Invalid upstream.\"}")
      end
    end

    context "when upstream is sent" do
      context "when upstream not exists", :vcr do
        let(:upstream) { "non-existent-upstream" }
        let(:query_string) { nil }

        it "should return 404 status" do
          expect(subject.status).to eql(404)
        end
  
        it "should return not found body description" do
          expect(subject.body).to eq("{\"status\":404,\"message\":\"Can't find that tree\"}")
        end
      end

      context "when upstream exists" do
        let(:upstream) { "input" }

        context "when indicator_ids is not sent", :vcr do
          let(:query_string) { nil }

          it "should return 200 status" do
            expect(subject.status).to eql(200)
          end
    
          it "should return all results from upstream" do
            body = subject.body
            expect(JSON.parse(body).count).to eq(12)
          end
        end

        context "when indicator_ids is sent" do
          context "and it exists", :vcr do
            let(:query_string) { "?indicator_ids[]=31&indicator_ids[]=32&indicator_ids[]=1" }

            it "should return 200 status" do
              expect(subject.status).to eql(200)
            end
      
            it "should return all results from upstream" do
              body = subject.body
              expect(JSON.parse(body).count).to eq(2)
            end
          end

          context "and it doesn't exists", :vcr do
            let(:query_string) { "?indicator_ids[]=999999" }

            it "should return 200 status" do
              expect(subject.status).to eql(200)
            end
      
            it "should return all results from upstream" do
              body = subject.body
              expect(JSON.parse(body).count).to eq(0)
            end
          end
        end
      end
    end
  end
end
