class SerializableVesselType < JSONAPI::Serializable::Resource
  type 'vessel_types'

  attributes :name,
             :created_at,
             :updated_at

  has_many :vessels do
    linkage always: true
  end

  attribute :sample_image_url do
    @object.vessels.sample.large_image_url
  end
end
