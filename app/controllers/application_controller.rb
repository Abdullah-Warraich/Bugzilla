class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
 #     rescue_from CanCan::AccessDenied do |exception|
 #   redirect_to root_url, :alert => exception.message
 # end

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :usertype, :password)}

            devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
        end

#app/controllers/application_controller.rb
   def index
   end
end