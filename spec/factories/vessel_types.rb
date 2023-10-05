FactoryBot.define do
  factory :vessel_type do
    name { Faker::Lorem.words(number: VesselType::MIN_NAME_LENGTH).join(' ').first(VesselType::MAX_NAME_LENGTH).strip }
  end
end
