require 'rails_helper'

RSpec.describe 'Verification', type: :request do
	describe 'POST /api/v1/start_verification' do
		fixtures :users

		before do
			VCR.insert_cassette 'twilio_verification_start'
		end

		after do
			VCR.eject_cassette
		end

		it "returns ok when start verification" do
			post '/api/v1/start_verification', params: { phone_number: users(:verified).phone_number }
			expect(response.status).to eq 200
		end
	end
end    
