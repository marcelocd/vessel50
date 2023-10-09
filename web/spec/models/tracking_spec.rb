require 'rails_helper'

describe Tracking do
  describe 'associations' do
    it { should belong_to(:vessel) }
  end

  describe 'validations' do
    it { should validate_presence_of(:area) }
    it { should validate_length_of(:area).is_at_least(described_class::MIN_AREA_LENGTH) }
    it { should validate_length_of(:area).is_at_most(described_class::MAX_AREA_LENGTH) }
    it { should validate_uniqueness_of(:area).case_insensitive.scoped_to(%i[vessel_id last_seen]) }
    it { should validate_presence_of(:last_seen) }
    it { should validate_length_of(:last_seen).is_at_most(described_class::MAX_LAST_SEEN_LENGTH) }
  end

  describe 'scopes' do
    describe 'vessel_ids_in' do
      let!(:vessel_1) { create(:vessel) }
      let!(:vessel_2) { create(:vessel) }
      let!(:vessel_3) { create(:vessel) }

      let!(:tracking_1) { create(:tracking, vessel: vessel_1) }
      let!(:tracking_2) { create(:tracking, vessel: vessel_2) }
      let!(:tracking_3) { create(:tracking) }

      let(:vessel_ids)   { [vessel_1.id, vessel_2.id].sort }
      let(:tracking_ids) { [tracking_1.id, tracking_2.id].sort }

      subject { described_class.vessel_ids_in(vessel_ids).pluck(:id).sort }

      it 'should return trackings 1 and 2' do
        expect(subject).to eq(tracking_ids)
      end
    end
  end
end
