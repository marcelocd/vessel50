class VesselType < ApplicationRecord
  MIN_NAME_LENGTH = 2
  MAX_NAME_LENGTH = 50

  has_many :vessels

  validates :name, presence:   true,
                   uniqueness: { case_sensitive: false },
                   length:     { minimum: MIN_NAME_LENGTH, maximum: MAX_NAME_LENGTH }
end
