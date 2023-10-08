require 'rails_helper'

describe VesselsController do
  describe 'GET #index' do
    let!(:vessel_1) { create(:vessel, name: 'name_a') }
    let!(:vessel_2) { create(:vessel, name: 'name_b') }
    let!(:vessel_3) { create(:vessel, name: 'name_c') }

    subject { get :index }

    it 'should render the index template' do
      expect(subject).to render_template(:index)
    end

    it 'should render vessels 1, 2 and 3' do
      subject
      expect(response.body).to match(vessel_1.name)
      expect(response.body).to match(vessel_2.name)
      expect(response.body).to match(vessel_3.name)
    end
  end
end
