class ApplicationController < ActionController::Base
    # before_action :authenticate_customer!,except: [:index]

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:profile_image_id,:email,:introduction, :is_deleted])
  end


end
