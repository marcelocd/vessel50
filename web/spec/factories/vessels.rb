FactoryBot.define do
  factory :vessel do
    vessel_type   { create(:vessel_type) }
    name          { Faker::Lorem.words(number: Vessel::MIN_NAME_LENGTH).join(' ').first(Vessel::MAX_NAME_LENGTH).strip }
    imo           { Faker::Number.number(digits: Vessel::IMO_LENGTH).to_s }
    mmsi          { Faker::Number.number(digits: Vessel::MMSI_LENGTH).to_s }
    callsign      { (('0'..'9').to_a + ('A'..'Z').to_a).sample((3..Vessel::MAX_CALLSIGN_LENGTH).to_a.sample).join }
    length_meters { Faker::Number.between(from: 60.0, to: 200.0) }
    width_meters  { Faker::Number.between(from: 10.0, to: 30.0) }
    image_url     { Faker::Internet.url }
  end
end
