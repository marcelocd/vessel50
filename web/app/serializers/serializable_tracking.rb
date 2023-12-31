class SerializableTracking < JSONAPI::Serializable::Resource
  type 'trackings'

  attributes :area,
             :last_seen,
             :created_at,
             :updated_at

  belongs_to :vessel do
    linkage always: true
  end

  attribute :vessel_name do
    @object.vessel.name
  end

  attribute :vessel_image_url do
    @object.vessel.large_image_url
  end
end
