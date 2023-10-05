class Tracking < ApplicationRecord
  MIN_AREA_LENGTH      = 2
  MAX_AREA_LENGTH      = 50
  MAX_LAST_SEEN_LENGTH = 75

  scope :vessel_ids_in, -> (*ids) { where(vessel_id: ids.flatten.uniq.reject{ |id| id.blank? || id == 'all' }) }

  belongs_to :vessel

  validates :area, presence:   true,
                   uniqueness: { case_sensitive: false, scope: %i[vessel_id last_seen] },
                   length:     { minimum: MIN_AREA_LENGTH, maximum: MAX_AREA_LENGTH }
  validates :last_seen, presence: true, length: { maximum: MAX_LAST_SEEN_LENGTH }

  accepts_nested_attributes_for :vessel

  def self.ransackable_attributes(auth_object = nil)
    %w[vessel_id area last_seen]
  end

  def self.ransackable_associations(auth_object = nil)
    ['vessel']
  end

  def self.ransackable_scopes auth_object = nil
    %i[vessel_ids_in area_cont last_seen_cont]
  end
end
