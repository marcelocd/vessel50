class SerializableVessel < JSONAPI::Serializable::Resource
  type 'vessels'

  attributes :name,
             :imo,
             :mmsi,
             :callsign,
             :length_meters,
             :width_meters,
             :created_at,
             :updated_at

  belongs_to :vessel_type do
    linkage always: true
  end

  has_many :trackings do
    linkage always: true
  end

  attribute :vessel_type do
    @object.vessel_type.name
  end

  attribute :thumb_image_url do
    @object.image_url
  end

  attribute :medium_image_url do
    @object.medium_image_url
  end

  attribute :large_image_url do
    @object.large_image_url
  end
end
