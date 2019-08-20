require 'warden'

module Authentication
  class TokenStrategy < Warden::Strategies::Base
    def valid?
      access_token.present?
    end

    def authenticate!
      user = User.find_by_token(access_token)

      if user.nil?
        fail!('Unauthenticate User')
      else
        user.regenerate_token
        success!(user)
      end
    end

    private

    def access_token
      @access_token ||= request.get_header('token')
    end
  end
end