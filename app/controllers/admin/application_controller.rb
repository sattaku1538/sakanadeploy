class Admin::ApplicationController < ApplicationController
    # before_action :authenticate_admin!
    before_action :authenticate_admin!,except: [:new_admin_session_path]
    
end
