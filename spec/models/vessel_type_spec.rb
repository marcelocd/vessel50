require 'rails_helper'

describe VesselType do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_length_of(:name).is_at_least(VesselType::MIN_NAME_LENGTH) }
    it { should validate_length_of(:name).is_at_most(VesselType::MAX_NAME_LENGTH) }
  end
end
