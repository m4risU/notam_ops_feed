require 'rails_helper'

RSpec.describe HoursInterpreter, type: :model do

  describe '#new/#initialize' do
    context 'example no. 1' do
      let(:data) { 'MON-WED 0500-1830 THU 0500-2130 FRI 0730-2100 SAT 0630-0730, 1900-2100 SUN CLOSED' }
      subject { HoursInterpreter.new(data).as_params }

      it { expect(subject.keys.size).to eq(7) }
      it { expect(subject[:mon]).to eq('0500-1830') }
      it { expect(subject[:tue]).to eq('0500-1830') }
      it { expect(subject[:wed]).to eq('0500-1830') }
      it { expect(subject[:thu]).to eq('0500-2130') }
      it { expect(subject[:sat]).to eq('0630-0730, 1900-2100') }
      it { expect(subject[:sun]).to eq('CLOSED') }
    end
  end

  describe '#days_extracted' do
    it { expect(HoursInterpreter.new('').days_extracted('MON')).to match ['MON'] }
    it { expect(HoursInterpreter.new('').days_extracted('MON-TUE')).to match ['MON', 'TUE'] }
    it { expect(HoursInterpreter.new('').days_extracted('WED-FRI')).to match ['WED', 'THU', 'FRI'] }
  end
end
