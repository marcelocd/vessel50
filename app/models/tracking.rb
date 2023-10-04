class Tracking < ApplicationRecord
  MIN_AREA_LENGTH      = 2
  MAX_AREA_LENGTH      = 50
  MAX_LAST_SEEN_LENGTH = 75

  belongs_to :vessel

  validates :area, presence:   true,
                   uniqueness: { case_sensitive: false, scope: %i[vessel_id last_seen] },
                   length:     { minimum: MIN_AREA_LENGTH, maximum: MAX_AREA_LENGTH }
  validates :last_seen, presence: true, length: { maximum: MAX_LAST_SEEN_LENGTH }

  accepts_nested_attributes_for :vessel
end
