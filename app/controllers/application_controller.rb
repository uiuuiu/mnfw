class ApplicationController < ActionController::Base

  private

  def page
    params[:page] || 1
  end

  def limit
    params[:limit] || 20
  end
end
