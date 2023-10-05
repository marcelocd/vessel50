FactoryBot.define do
  factory :tracking do
    area      { Faker::Lorem.words(number: Tracking::MIN_AREA_LENGTH).join(' ').first(Tracking::MAX_AREA_LENGTH).strip }
    last_seen { (('0'..'9').to_a + ('A'..'Z').to_a).sample((3..Tracking::MAX_LAST_SEEN_LENGTH).to_a.sample).join }
    vessel    { create(:vessel) }
  end
end
