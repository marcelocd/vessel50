require 'rails_helper'

describe Vessel do
  describe 'associations' do
    it { should belong_to(:vessel_type) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_length_of(:name).is_at_least(Vessel::MIN_NAME_LENGTH) }
    it { should validate_length_of(:name).is_at_most(Vessel::MAX_NAME_LENGTH) }
    it { should validate_presence_of(:imo) }
    it { should validate_uniqueness_of(:imo) }
    it { should validate_length_of(:imo).is_equal_to(described_class::IMO_LENGTH)
      .with_message("must be exactly #{described_class::IMO_LENGTH} digits") }
    it { should validate_presence_of(:mmsi) }
    it { should validate_uniqueness_of(:mmsi) }
    it { should validate_length_of(:mmsi).is_equal_to(described_class::MMSI_LENGTH)
      .with_message("must be exactly #{described_class::MMSI_LENGTH} digits") }
    it { should validate_length_of(:callsign).is_at_most(described_class::MAX_CALLSIGN_LENGTH).allow_nil }
    it { should validate_numericality_of(:length_meters).is_greater_than(0).allow_nil }
    it { should validate_numericality_of(:width_meters).is_greater_than(0).allow_nil }
  end
end
