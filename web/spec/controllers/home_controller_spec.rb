require './spec/spec_helper'

describe HomeController do
  context 'GET /' do
    subject { get '/', {} }

    context 'when I access the root page' do
      it { expect(subject.status).to eql(200) }
      it { expect(subject.body).to be_empty }
    end
  end
end
