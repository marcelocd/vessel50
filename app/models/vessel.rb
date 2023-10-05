class Vessel < ApplicationRecord
  MIN_NAME_LENGTH     = 2
  MAX_NAME_LENGTH     = 50
  IMO_LENGTH          = 7
  MMSI_LENGTH         = 9
  MAX_CALLSIGN_LENGTH = 10

  belongs_to :vessel_type

  has_many :trackings

  validates :name, presence: true, length: { minimum: MIN_NAME_LENGTH, maximum: MAX_NAME_LENGTH }
  validates :imo, presence:   { case_sensitive: false },
                  uniqueness: true,
                  length:     { is: IMO_LENGTH, message: "must be exactly #{IMO_LENGTH} digits" }
  validates :mmsi, presence:   true,
                   uniqueness: { case_sensitive: false },
                   length:     { is: MMSI_LENGTH, message: "must be exactly #{MMSI_LENGTH} digits" }
  validates :callsign, length: { maximum: MAX_CALLSIGN_LENGTH }, allow_nil: true
  validates :length_meters, numericality: { greater_than: 0 }, allow_nil: true
  validates :width_meters,  numericality: { greater_than: 0 }, allow_nil: true

  accepts_nested_attributes_for :vessel_type

  def dimensions
    "#{length_meters.round(1)} x #{width_meters.round(1)} (m)"
  end
end
