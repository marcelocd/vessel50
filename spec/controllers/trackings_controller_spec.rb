require 'rails_helper'

describe TrackingsController do
  describe 'GET #scrape' do
    subject { get :scrape }

    it 'should trigger the scraping job' do
      expect(TrackingScrapingJob).to receive(:perform_async)
      subject
    end

    it 'should redirect to root' do
      expect(subject).to redirect_to(root_path)
    end

    it 'should add a flash message' do
      message = 'The trackings are being scraped'

      subject
      expect(controller.flash[:notice]).to eq(message)
    end
  end
end
