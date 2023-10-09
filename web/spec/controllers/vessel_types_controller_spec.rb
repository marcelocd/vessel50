require 'rails_helper'

describe VesselTypesController do
  describe 'GET #index' do
    let!(:vessel_type_1) { create(:vessel_type, name: 'name_a') }
    let!(:vessel_type_2) { create(:vessel_type, name: 'name_b') }
    let!(:vessel_type_3) { create(:vessel_type, name: 'name_c') }

    subject { get :index }

    it 'should render the index template' do
      expect(subject).to render_template(:index)
    end

    it 'should render vessel_types 1, 2 and 3' do
      subject
      expect(response.body).to match(vessel_type_1.name)
      expect(response.body).to match(vessel_type_2.name)
      expect(response.body).to match(vessel_type_3.name)
    end
  end
end
