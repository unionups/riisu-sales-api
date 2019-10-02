module Authentication
  class SetResponseToken
    def initialize app
      @app = app
    end

    def call env
      res = @app.call(env)
      if res[0] < 300 && !skip_request(env)
        res[1]["Auth-Token"] = env['warden'].user.auth_token
      end
      res
    end

    private

    def skip_request(env)
      (env['REQUEST_URI'] =~ /\/api\/v1\/start_verification$/) || (env['REQUEST_URI'] =~ /\/api\/v1\/confirm_verification$/)
    end
  end
end