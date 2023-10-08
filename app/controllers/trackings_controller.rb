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
    @search       ||= Tracking.all.ransack(search_params[:q])
    @search.sorts   = ['last_seen desc'] if @search.sorts.blank?
    @trackings    ||= @search.result

    if @trackings.empty?
      flash.now[:warning] = t('default.no_results')
      @trackings = Tracking.all.order('last_seen desc')
    end

    @trackings.includes(vessel: :vessel_type)
  end

  def search_params
    params.permit(:commit, q: [:s,
                               :vessel_ids_in,
                               :area_cont,
                               :last_seen_cont]).to_h
  end

  def load_css
    if action_name == 'index'
      @css_files << 'trackings_index'
    end
  end
end
