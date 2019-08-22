module Constraints
  class UserConstraint
    class << self
      def matches?(request)
        warden(request).authenticate! && warden(request).user.has_role?(:user)
      end

      private

      def warden(request)
        request.env['warden']
      end
    end
  end
end