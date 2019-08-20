module Authentication
  class SetResponseToken
    def initialize app
      @app = app
    end

    def call env
      res = @app.call(env)
      if res[0] < 300 && !skipp_request(env)
        res[1]["Access-Token"] = env['warden'].user.auth_token
      end
      res
    end

    private

    def skipp_request(env)
      (env['REQUEST_URI'] =~ /\/api\/v1\/start_verification$/) || (env['REQUEST_URI'] =~ /\/api\/v1\/confirm_verification$/)
    end
  end
end