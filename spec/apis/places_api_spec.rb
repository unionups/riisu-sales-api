require 'rails_helper'

RSpec.describe 'Places API', type: :api do

  # describe "USER" do
  #   let(:user) {create(:user)}

  #   it "POST '/api/v1/places' -> admin/places#create must be ACCESS DINED" do
  #     post api_v1_places_path, {place: attributes_for(:place)}, { "token" => user.auth_token }
  #     expect(last_response.status).to eq 401 
  #   end
  # end

  describe "ADMIN" do
    let(:admin){create(:admin)}

    it "must be POST '/api/v1/places' -> admin/places#create" do
      post api_v1_places_path, {place: attributes_for(:place)}, { "token" => admin.auth_token }
      expect(last_response.status).to eq 200
    end
  end

end