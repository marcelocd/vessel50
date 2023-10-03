class VesselsController < ApplicationController
  def scrape_vessels
    VesselScrapingJob.perform_async('IT WORKED')
    flash[:notice] = 'The vessels are being scraped'
    redirect_to :root
  end
end
