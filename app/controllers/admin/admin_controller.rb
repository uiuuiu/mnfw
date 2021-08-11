module Admin
  class AdminController < ::ApplicationController
    before_action :authenticate_user!

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

    def render_new
      raise 'None block given!' unless block_given?
      @record, @opts = yield
      render 'admin/templates/new'
    end

    def redirect_to_back
      redirect_back(fallback_location: dashboard_index_path)
    end
  end
end