class VesselScrapingJob
  include Sidekiq::Job

  def perform(arg)
    # This is the code that will be executed in the background
    puts "Performing job with argument: #{arg}"
  end
end
