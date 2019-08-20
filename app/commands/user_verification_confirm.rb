require 'twilio-ruby'
require_relative '../services/errors_handling.rb'

class UserVerificationConfirm
	prepend SimpleCommand

	def initialize(phone_number, verification_code)
		@phone_number = phone_number
		@verification_code = verification_code
	end

	def call
		if Phonelib.valid?(@phone_number) && @verification_code.match(/^[0-9]{4}$/).present?
			begin
				Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']).verify
					.services(ENV['TWILIO_VERIFICATION_SERVICE'])
					.verification_checks
					.create(to: @phone_number, code: @verification_code)
					.status == 'approved'
			rescue ArgumentError => e
				Rails.logger.error e.message
				nil
			rescue => twilio_error
				errors.add(:user_verification, Services::ErrorsHandling.payload(twilio_error.code))
				nil
			end
		else
			errors.add(:user_verification, { error_code: 10001, error_title: I18n.t('errors.users.invalid_input')})
			nil
		end
	end
end