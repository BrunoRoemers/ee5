class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  # check_authorization unless: :devise_controller?
end
