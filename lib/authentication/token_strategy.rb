require 'warden'

module Authentication
  class TokenStrategy < Warden::Strategies::Base
    def valid?
      access_token.present?
    end

    def authenticate!
      user = User.find_by(auth_token: access_token)

      if user.nil?
        fail!('Unauthenticate User')
      else
        # user.regenerate_auth_token
        success!(user)
      end
    end

    private

    def access_token
      # @access_token ||= request.get_header('token')
      @access_token ||= env['HTTP_TOKEN']

    end
  end
end