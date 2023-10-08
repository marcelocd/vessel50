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

  def find_vessel
    @vessel ||= Vessel.find_by_id(params[:id])
    unless @vessel.present?
      flash[:warning] = t('activerecord.errors.not_found', model_name: 'Vessel')
      redirect_to :root
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
