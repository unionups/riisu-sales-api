module Services
		class ErrorsHandling
			CUSTOM_ERRORS = {
				10001 => I18n.t('errors.application.not_admin'),
				10002 => I18n.t('errors.application.page_not_specified'),
				10003 => I18n.t('errors.application.user_not_exist'),
				10004 => I18n.t('errors.application.access_dined'),
				10101 => I18n.t('errors.charging_stations.unable_assign_place'),
				10102 => I18n.t('errors.charging_stations.unable_create'),
				10103 => I18n.t('errors.charging_stations.unable_start_lease'),
				10104 => I18n.t('errors.charging_stations.unable_finish_lease'),
				10105 => I18n.t('errors.charging_stations.no_powerbanks_available'),
				10106 => I18n.t('errors.charging_stations.unable_update_state'),
				10107 => I18n.t('errors.charging_stations.unable_assign_to_same_place'),
				10108 => I18n.t('errors.charging_stations.invalid_index_params'),
				10109 => I18n.t('errors.charging_stations.powerbank_not_specified'),
				10110 => I18n.t('errors.charging_stations.invalid_radius'),
				10201 => I18n.t('errors.places.unable_create'),
				10202 => I18n.t('errors.places.invalid_admin_params'),
				10203 => I18n.t('errors.places.invalid_user_params'),
				10204 => I18n.t('errors.places.not_in_polygon'),
				10205 => I18n.t('errors.places.invalid_radius'),
				10301 => I18n.t('errors.users.verification_not_approved'),
				10302 => I18n.t('errors.users.not_found'),
				10303 => I18n.t('errors.users.verification_not_pending'),
				10304 => I18n.t('errors.users.unable_update'),
				10305 => I18n.t('errors.users.invalid_phone'),
				10401 => I18n.t('errors.leases.wrong_user'),
				10501 => I18n.t('errors.powerbanks.invalid_params'),
				10601 => I18n.t('errors.restaurants.unable_create'),
				10602 => I18n.t('errors.restaurants.unable_update'),
				10701 => I18n.t('errors.categories.unable_create'),
				10702 => I18n.t('errors.categories.unable_update'),
				10801 => I18n.t('errors.claims.place_already_claimed'),
				60200 => I18n.t('errors.twilio.invalid_params'),
				60201 => I18n.t('errors.twilio.invalid_verification_code'),
				60205 => 'SMS is not supported by landline phone number'
			}

			def self.payload(code, type = nil)
				message = type == :twilio ? (CUSTOM_ERRORS[code].presence || I18n.t('errors.twilio.common')) : CUSTOM_ERRORS[code]

				{
					error_code: code,
					error_message: message
				}
			end
		end
end