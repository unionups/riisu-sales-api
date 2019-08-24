class ApplicationController < ActionController::API
  include Authentication::HelperMethods

  rescue_from CanCan::AccessDenied do 
  	render status: 403, json: Services::ErrorsHandling.payload(10004)
  end

end
