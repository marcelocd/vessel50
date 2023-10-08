class VesselsController < ApplicationController
  before_action :load_css

  def index
    @total = vessels.count
    @pagy, @vessels = pagy(vessels, page: params[:page])
  end

  private

  def vessels
    @search       ||= Vessel.all.ransack(search_params[:q])
    @search.sorts   = ['name'] if @search.sorts.blank?
    @vessels      ||= @search.result

    if @vessels.empty?
      flash.now[:warning] = t('default.no_results')
      @vessels = Tracking.all.order('last_seen desc')
    end

    @vessels.includes(:trackings, :vessel_type)
  end

  def search_params
    params.permit(:commit, q: [:s,
                               :name_cont,
                               :imo_cont,
                               :mmsi_cont,
                               :callsign_cont]).to_h
  end

  def load_css
    if action_name == 'index'
      @css_files << 'vessels_index'
    end
  end
end
