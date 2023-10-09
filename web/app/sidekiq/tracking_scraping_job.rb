class TrackingScrapingJob
  include Sidekiq::Job

  def perform
    TrackingServices::Scraper.call('https://www.vesseltracker.com/en/vessels.html')
    puts "Performing job"
  end
end
