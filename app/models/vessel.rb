class Vessel < ApplicationRecord
  MIN_NAME_LENGTH     = 2
  MAX_NAME_LENGTH     = 50
  IMO_LENGTH          = 7
  MMSI_LENGTH         = 9
  MAX_CALLSIGN_LENGTH = 10

  belongs_to :vessel_type

  has_many :trackings

  validates :name, presence: true, length: { minimum: MIN_NAME_LENGTH, maximum: MAX_NAME_LENGTH }
  validates :imo, presence:   true,
                  uniqueness: { case_sensitive: false },
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

  def last_tracking
    trackings.order('last_seen desc').first
  end

  def large_image_url
    return unless image_url.present?
    image_url.gsub(/\/thumb\//, '/hires/')
  end

  def medium_image_url
    return unless image_url.present?
    image_url.gsub(/\/thumb\//, '/midres/')
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[name imo mmsi callsign]
  end

  def self.ransackable_associations(auth_object = nil)
    ['trackings']
  end

  def self.ransackable_scopes auth_object = nil
    %i[name_cont imo_cont mmsi_cont callsign_cont]
  end
end
