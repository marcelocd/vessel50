class VesselsController < ApplicationController
  def scrape_vessels
    flash[:notice] = 'The vessels are being scraped'
    redirect_to :root
  end
end
