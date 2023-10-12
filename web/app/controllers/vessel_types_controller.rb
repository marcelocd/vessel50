class VesselTypesController < ApplicationController
  before_action :load_css

  def index
    @total = vessel_types.count
    @pagy, @vessel_types = pagy(vessel_types, page: params[:page], items: (params[:per_page] || 15))
  end

  private

  def vessel_types
    @search       ||= VesselType.all.ransack(search_params[:q])
    @vessel_types ||= @search.result

    if @vessel_types.empty?
      flash.now[:warning] = t('default.no_results')
      @vessel_types = VesselType.all
    end

    @vessel_types.includes(:vessels).order('name asc')
  end

  def search_params
    params.permit(:commit, q: [:s, :name_cont]).to_h
  end

  def load_css
    @css_files << 'vessel_types_index'
  end
end
