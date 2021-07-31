module Admin
  class AdminController < ::ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_user_role!

    private

    def render_index
      raise 'None block given!' unless block_given?
      @records, @opts = yield
      render 'admin/templates/index'
    end

    def render_edit
      raise 'None block given!' unless block_given?
      @record, @opts = yield
      render 'admin/templates/edit'
    end

    def authenticate_user_role!
      redirect_to '/' unless current_user.admin?
    end

    def redirect_to_back
      redirect_back(fallback_location: admin_root_path)
    end
  end
end