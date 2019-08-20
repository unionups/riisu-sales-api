require 'rails_helper'

describe UserVerificationConfirm do
	subject(:context) { described_class.call(phone_number, verification_code) }

	describe '.call' do
		context 'when verification confirm successful' do
			fixtures :users

			before do
				VCR.insert_cassette 'twilio_verification_confirm'
			end

			after do
				VCR.eject_cassette
			end

			let(:phone_number) {users(:verified).phone_number}
			let(:verification_code) {'8334'}
			
			it 'succeeds' do
				expect(context).to be_success
			end
		end

		
		# context 'when the context is not successful' do
		#   let(:phone_number) {'+380682035831'}
		#   let(:verification_code) {'0945'}

		#   it 'fails' do
		#     expect(context).to be_failure
		#   end
		# end

	end
end