class TrackingsController < ApplicationController
  before_action :load_css

  def index
    @total = trackings.count
    @pagy, @trackings = pagy(trackings, page: params[:page])
  end

  def scrape
    TrackingScrapingJob.perform_async
    flash[:notice] = 'The trackings are being scraped!'
    redirect_to :root
  end

  private

  def trackings
    @search    ||= Tracking.all.ransack(search_params[:q])
    @trackings ||= @search.result.includes(vessel: :vessel_type)

    if @trackings.empty?
      flash.now[:warning] = t('default.no_results')
      @trackings = Tracking.all.order('last_seen desc')
    end

    sort_search
    @trackings
  end

  def search_params
    params.permit(:commit, q: [:vessel_ids_in,
                               :area_cont,
                               :last_seen_cont]).to_h
  end

  def load_css
    if action_name == 'index'
      @css_files << 'trackings_index'
    end
  end

  def sort_search
    if params[:sort].present?
      sort      = params[:sort]
      direction = params[:direction]
      case sort
      when 'vessel_name'
        @trackings = @trackings.joins(:vessel).order("vessels.name #{direction}")
      when 'vessel_imo'
        @trackings = @trackings.joins(:vessel).order("vessels.imo #{direction}")
      when 'vessel_mmsi'
        @trackings = @trackings.joins(:vessel).order("vessels.mmsi #{direction}")
      when 'vessel_callsign'
        @trackings = @trackings.joins(:vessel).order("vessels.callsign #{direction}")
      when 'vessel_type'
        @trackings = @trackings.joins(vessel: :vessel_type).order("vessel_types.name #{direction}")
      when 'area'
        @trackings = @trackings.order("trackings.area #{direction}")
      when 'last_seen'
        @trackings = @trackings.order("trackings.last_seen #{direction}")
      end
    else
      @trackings = @trackings.order("trackings.last_seen DESC")
    end
  end
end
