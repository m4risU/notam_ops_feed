require 'rails_helper'

RSpec.describe FilterService do

  describe '#new/#initialize' do
    subject { f = FilterService.new; f.data = sample; f.save; f }

    context 'with sample data' do
      let(:sample) { 'test data' }

      it { expect(subject.data).to eq(sample) }
      it { expect(subject.filtered_data.size).to eq(0) }
    end

    context 'with provided data' do
      let(:sample) { IO.read(Rails.root.join('spec', 'factories', 'samples', 'notam_data.txt')) }

      it { expect(subject.data).to eq(sample) }
      it { expect(subject.filtered_data.size).to eq(10) }
    end
  end
end
