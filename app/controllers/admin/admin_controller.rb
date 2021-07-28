module Admin
    class AdminController < ::ApplicationController
        before_action :authenticate_user!
        before_action :authenticate_user_role!

        private

        def authenticate_user_role!
            redirect_to '/' unless current_user.admin?
        end
    end
end