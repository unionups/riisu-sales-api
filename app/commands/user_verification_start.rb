require 'twilio-ruby'
require_relative '../services/errors_handling'

class UserVerificationStart
	prepend SimpleCommand

	def initialize(phone_number)
		@phone_number = phone_number
	end

	def call
		if Phonelib.valid? @phone_number
			begin
				Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']).verify
					.services(ENV['TWILIO_VERIFICATION_SERVICE'])
					.verifications
					.create(to: @phone_number, channel: 'sms', locale: I18n.default_locale)
					.status == 'pending'
			rescue ArgumentError => e
				Rails.logger.error e.message
				nil
			rescue => twilio_error
				errors.add(:user_verification, Services::ErrorsHandling.payload(twilio_error.code))
				nil
			end
		else
			errors.add(:user_verification, Services::ErrorsHandling.payload(10305))
			nil
		end
	end
end
