# frozen_string_literal: true

require './spec/spec_helper'

describe TreeRequest do
  describe 'validations' do
    subject { TreeRequest.new(params) }

    context 'when params is invalid' do
      let(:params) { { 'name': nil } }

      it 'should raise NotFoundError' do
        expect { subject.validate_upstream! }.to raise_error(NotFoundError, 'Invalid upstream.')
      end
    end

    context 'when params is valid' do
      let(:params) { { 'name': 'upstream', indicator_ids: ['1', '2'] } }

      it 'should not raise error' do
        expect { subject.validate_upstream! }.to_not raise_error
      end

      it 'should extract params' do
        expect(subject.to_hash).to eq(name: 'upstream', indicator_ids: [1, 2])
      end
    end
  end
end
