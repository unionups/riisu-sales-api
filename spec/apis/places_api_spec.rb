require 'rails_helper'

RSpec.describe 'Places API', type: :api do
    let(:user) {create(:user)}
    let(:user_lvl_2) {create(:user, access_level: 2, phone_number: "+380682035833")}
    let(:admin){create(:admin)}

    it "ADMIN must create place POST '/api/v1/places' -> admin/places#create" do
      post api_v1_places_path, {place: attributes_for(:place)}, { "HTTP_TOKEN" => admin.auth_token }
      expect(last_response.status).to eq 200
    end

    it "USER must get places by access level GET '/api/v1/places' -> places#index " do
      create_list(:place, 5)
      create_list(:place, 2, access_level: 2)
      get api_v1_places_path, nil, { "HTTP_TOKEN" => user.auth_token }
      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body).count).to eq 5
      get api_v1_places_path, nil, { "HTTP_TOKEN" => user_lvl_2.auth_token }
      expect(JSON.parse(last_response.body).count).to eq 7
    end
end
