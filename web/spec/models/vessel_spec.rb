require 'rails_helper'

describe Vessel do
  describe 'associations' do
    it { should belong_to(:vessel_type) }
    it { should have_many(:trackings) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(described_class::MIN_NAME_LENGTH) }
    it { should validate_length_of(:name).is_at_most(described_class::MAX_NAME_LENGTH) }
    it { should validate_presence_of(:imo) }
    it { should validate_uniqueness_of(:imo).case_insensitive }
    it { should validate_length_of(:imo).is_equal_to(described_class::IMO_LENGTH)
      .with_message("must be exactly #{described_class::IMO_LENGTH} digits") }
    it { should validate_presence_of(:mmsi) }
    it { should validate_uniqueness_of(:mmsi).case_insensitive }
    it { should validate_length_of(:mmsi).is_equal_to(described_class::MMSI_LENGTH)
      .with_message("must be exactly #{described_class::MMSI_LENGTH} digits") }
    it { should validate_length_of(:callsign).is_at_most(described_class::MAX_CALLSIGN_LENGTH).allow_nil }
    it { should validate_numericality_of(:length_meters).is_greater_than(0).allow_nil }
    it { should validate_numericality_of(:width_meters).is_greater_than(0).allow_nil }
  end

  describe '#dimensions' do
    let(:vessel) { create(:vessel, length_meters: 10.5, width_meters: 55.3) }
    let(:formatted_dimensions) { '10.5 x 55.3 (m)' }

    subject { vessel.dimensions }

    it 'should return the formatted dimensions' do
      expect(subject).to eq(formatted_dimensions)
    end
  end
end
