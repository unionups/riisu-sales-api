require 'rails_helper'

describe UserVerificationStart do
	subject(:context) { described_class.call(phone_number) }

	describe '.call' do
		context 'when verification start successful' do
				fixtures :users
				
				before do
					VCR.insert_cassette 'twilio_verification_start'
				end

				after do
					VCR.eject_cassette
				end

				let(:phone_number) {users(:verified).phone_number}
				
				it 'succeeds' do
					expect(context).to be_success
				end
		end


		# context 'when the context is not successful' do
		#   let(:phone_number) {'+380682035831'}
		
		#   it 'fails' do
		#     expect(context).to be_failure
		#   end
		# end
	end
end



