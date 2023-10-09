class VesselsController < ApplicationController
  before_action :load_css
  before_action :find_vessel, only: :show

  def index
    @total = vessels.count
    @pagy, @vessels = pagy(vessels, page: params[:page])
  end

  def show ; end

  private

  def vessels
    @search  ||= Vessel.all.ransack(search_params[:q])
    @vessels ||= @search.result

    if @vessels.empty?
      flash.now[:warning] = t('default.no_results')
      @vessels = Vessel.all.order('last_seen desc')
    end

    sort_search
    @vessels
  end

  def search_params
    params.permit(:commit, q: [:name_cont,
                               :imo_cont,
                               :mmsi_cont,
                               :callsign_cont]).to_h
  end

  def find_vessel
    @vessel ||= Vessel.find_by_id(params[:id])
    unless @vessel.present?
      flash[:warning] = t('activerecord.errors.not_found', model_name: 'Vessel')
      redirect_to :root
    end
  end

  def sort_search
    if params[:sort].present?
      direction = params[:direction] == 'asc' ? 'asc' : 'desc'
      sort      = params[:sort]
      case sort
      when 'name'
        @vessels = @vessels.order("vessels.name #{direction}")
      when 'imo'
        @vessels = @vessels.order("vessels.imo #{direction}")
      when 'mmsi'
        @vessels = @vessels.order("vessels.mmsi #{direction}")
      when 'callsign'
        @vessels = @vessels.order("vessels.callsign #{direction}")
      when 'type'
        @vessels = @vessels.joins(:vessel_type).order("vessel_types.name #{direction}")
      when 'tracking_area'
        @vessels = @vessels.order_by_last_tracking_area(direction)
      when 'tracking_last_seen'
        @vessels = @vessels.order_by_last_tracking_last_seen(direction)
      end
    else
      @vessels = @vessels.order('vessels.name')
    end
  end

  def load_css
    case action_name
    when 'index'
      @css_files << 'vessels_index'
    when 'show'
      @css_files << 'vessels_show'
    end
  end
end
