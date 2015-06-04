class HomeController < ApplicationController
  before_action :logged_in_redirect

  private
  def logged_in_redirect
    if logged_in?
      redirect_to user_path(current_user)
    end
  end
end

