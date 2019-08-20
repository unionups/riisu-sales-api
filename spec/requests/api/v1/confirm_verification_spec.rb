require 'rails_helper'

RSpec.describe 'Verification', type: :request do
	describe 'POST /api/v1/confirm_verification' do
		fixtures :users

		before do
			VCR.insert_cassette 'twilio_verification_confirm'
		end

		after do
			VCR.eject_cassette
		end

		it "successfull verification" do
			# expect {
			post '/api/v1/confirm_verification', params: { phone_number: users(:verified).phone_number , verification_code: '8334'}
			# }.to change(User, :count).by(1)	
			expect(response.status).to eq 200
			expect(JSON.parse(response.body)['user']['token']).to be_present
		end
	end
end    