class VesselType < ApplicationRecord
  MIN_NAME_LENGTH = 2
  MAX_NAME_LENGTH = 50

  has_many :vessels

  validates :name, presence:   true,
                   uniqueness: { case_sensitive: false },
                   length:     { minimum: MIN_NAME_LENGTH, maximum: MAX_NAME_LENGTH }

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end

  def self.ransackable_associations(auth_object = nil)
    ['vessels']
  end

  def self.ransackable_scopes auth_object = nil
    %i[name_cont]
  end
end
