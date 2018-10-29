require "./spec/spec_helper"

describe TreeService do
  describe "#perform" do
    subject do 
      TreeService.new(name: upstream, indicator_ids: indicators).perform
    end
    
    context 'when indicator_ids is NOT sent' do
      let(:indicators) { nil }
      let(:upstream)   { "input" }
  
      it "should return all data from API", :vcr do
        expect(subject.content.count).to eq(12)
        expect(subject.status).to eq(200)
      end
    end
    
    context 'when indicator_ids is sent' do
      let(:indicators) { [361, 1, 299] }
      let(:upstream)   { 'input' }
  
      it "should filter data from API according to indicators", :vcr do
        expect(subject.content.count).to eq(3)
        expect(subject.status).to eq(200)
      end
    end
  end

  describe "#filter_response_by_indicator_ids!" do
    subject do 
      TreeService.new(indicator_ids: indicators)
    end

    let(:indicators) { [1, 2, 299] }
    let(:content)    { load_object_from_json("sample","fake_response") }

    it "should return only the matched nodes" do
      subject.filter_response_by_indicator_ids!(content)
      expect(content.collect(&:name)).to eq(["Urban Extent", "Demographics"])
    end

    it "should return only the matched sub themes" do
      subject.filter_response_by_indicator_ids!(content)
      sub_themes = content.flat_map(&:sub_themes)
                          .flat_map(&:name)

      expect(sub_themes).to eq(["Administrative","Births and Deaths"])
    end

    it "should return only the matched categories" do
      subject.filter_response_by_indicator_ids!(content)
      categories = content.flat_map(&:sub_themes)
                          .flat_map(&:categories)
                          .flat_map(&:id)

      expect(categories.sort).to eq([1, 11])
    end

    it "should return only the matched indicators" do
      subject.filter_response_by_indicator_ids!(content)
      indicators = content.flat_map(&:sub_themes)
                          .flat_map(&:categories)
                          .flat_map(&:indicators)
                          .flat_map(&:id)

      expect(indicators.sort).to eq([1, 2, 299])
    end
  end
end