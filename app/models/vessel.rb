class Vessel < ApplicationRecord
  MIN_NAME_LENGTH     = 2
  MAX_NAME_LENGTH     = 50
  IMO_LENGTH          = 7
  MMSI_LENGTH         = 9
  MAX_CALLSIGN_LENGTH = 10

  belongs_to :vessel_type

  validates :name, presence:   true,
                   uniqueness: { case_sensitive: false },
                   length:     { minimum: MIN_NAME_LENGTH, maximum: MAX_NAME_LENGTH }
  validates :imo, presence:   true,
                  uniqueness: true,
                  length:     { is: IMO_LENGTH, message: "must be exactly #{IMO_LENGTH} digits" }
  validates :mmsi, presence:   true,
                   uniqueness: true,
                   length:     { is: MMSI_LENGTH, message: "must be exactly #{MMSI_LENGTH} digits" }
  validates :callsign, length: { maximum: MAX_CALLSIGN_LENGTH }, allow_nil: true
  validates :length_meters, numericality: { greater_than: 0 }, allow_nil: true
  validates :width_meters,  numericality: { greater_than: 0 }, allow_nil: true
end
