class TrackingsController < ApplicationController
  def index ; end

  def scrape
    TrackingScrapingJob.perform_async
    flash[:notice] = 'The trackings are being scraped'
    redirect_to :root
  end
end
