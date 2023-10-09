require 'rails_helper'

describe TrackingsController do
  describe 'GET #index' do
    let!(:tracking_1) { create(:tracking, area: 'area_a') }
    let!(:tracking_2) { create(:tracking, area: 'area_b') }
    let!(:tracking_3) { create(:tracking, area: 'area_c') }

    subject { get :index }

    it 'should render the index template' do
      expect(subject).to render_template(:index)
    end

    it 'should render trackings 1, 2 and 3' do
      subject
      expect(response.body).to match(tracking_1.area)
      expect(response.body).to match(tracking_2.area)
      expect(response.body).to match(tracking_3.area)
    end
  end

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
      message = 'The trackings are being scraped!'

      subject
      expect(controller.flash[:notice]).to eq(message)
    end
  end
end
