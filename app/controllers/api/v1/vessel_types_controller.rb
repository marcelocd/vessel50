class Api::V1::VesselTypesController < ApiController
  before_action :find_vessel_type, only: :show

  def index
    pagy, records = pagy(vessel_types, page: params[:page], items: (params[:per_page] || 10))
    render jsonapi: records, meta: { pagy: pagy_metadata(pagy) }
  end

  def show
    render_vessel_type
  end

  private

  def vessel_types
    @vessel_types ||= VesselType.includes(:vessels).order('name')
  end

  def find_vessel_type
    @vessel_type ||= VesselType.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    error_message = t('activerecord.errors.not_found', model_name: 'Vessel Type')
    render json: { errors: [error_message] }, status: 404
  end

  def render_vessel_type
    render jsonapi: @vessel_type
  end
end
