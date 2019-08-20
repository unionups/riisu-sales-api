module Constraints
	class AdminConstraint
	  def self.matches?(request)
	    warden(request).authenticated? && warden(request).user.has_role?(:admin)
	  end

	  private

	  def warden(request)
	    request.env['warden']
	  end
	end
end