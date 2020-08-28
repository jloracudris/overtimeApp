class ApplicationController < ActionController::Base
    include Pundit
    before_action :authenticate_user!

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private
    
    def user_not_authorized 
        flash['alert'] = "User not authorized"
        redirect_to(root_path)
    end
end
