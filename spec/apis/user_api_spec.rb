require 'rails_helper'
RSpec.describe 'User API', type: :api do
  describe "UNAUTHENTICATED USER" do
    let(:user){create(:user)}
    
    it "PATCH api/v1/users/:id -> users#update must be ACCESS DINED" do
      patch api_v1_user_path(user)
      expect(last_response.status).to eq 401
    end
  end

  describe "AUTHENTICATED USER" do
    let(:user) {create(:user)}

    it "must be PATCH api/v1/users/:id -> users#update" do
      patch api_v1_user_path(user), {user: attributes_for(:user, first_name: 'Jack')}, { "token" => user.auth_token }
      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body)['first_name']).to eq 'Jack'
    end
  end
end

