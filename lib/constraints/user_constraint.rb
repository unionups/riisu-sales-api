module Constraints
	class UserConstraint
	  def self.matches?(request)
	    warden(request).authenticated? && warden(request).user.has_role?(:user)
	  end

	  private

	  def warden(request)
	    request.env['warden']
	  end
	end
end