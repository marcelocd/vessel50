class Api::V1::VesselsController < ApiController
  before_action :find_vessel, only: :show

  def index
    pagy, records = pagy(vessels, page: params[:page], items: (params[:per_page] || 10))
    render jsonapi: records, meta: { pagy: pagy_metadata(pagy) }
  end

  def show
    render_vessel
  end

  private

  def vessels
    @vessels ||= Vessel.includes(:vessel_type).order_by_last_tracking_last_seen
  end

  def find_vessel
    @vessel ||= Vessel.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    error_message = t('activerecord.errors.not_found', model_name: 'Vessel')
    render json: { errors: [error_message] }, status: 404
  end

  def render_vessel
    render jsonapi: @vessel
  end
end
