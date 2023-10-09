class Api::V1::TrackingsController < ApiController
  before_action :find_tracking, only: :show

  def index
    pagy, records = pagy(trackings, page: params[:page], items: (params[:per_page] || 10))
    render jsonapi: records, meta: { pagy: pagy_metadata(pagy) }
  end

  def show
    render_tracking
  end

  private

  def trackings
    @trackings ||= Tracking.includes(:vessel).order('last_seen desc')
  end

  def find_tracking
    @tracking ||= Tracking.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    error_message = t('activerecord.errors.not_found', model_name: 'Tracking')
    render json: { errors: [error_message] }, status: 404
  end

  def render_tracking
    render jsonapi: @tracking
  end
end
