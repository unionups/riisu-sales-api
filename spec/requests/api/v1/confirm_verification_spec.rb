require 'rails_helper'

RSpec.describe 'Verification', type: :request do
  describe 'POST /api/v1/confirm_verification' do

    before do
      VCR.insert_cassette 'twilio_verification_confirm'
    end

    after do
      VCR.eject_cassette
    end

    it "successfull verification" do

      post '/api/v1/confirm_verification', params: attributes_for(:verified_user)

      expect(response.status).to eq 200
      expect(JSON.parse(response.body)['token']).to be_present
    end
  end
end    