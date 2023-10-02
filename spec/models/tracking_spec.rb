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
end
