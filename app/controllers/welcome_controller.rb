class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      @users = User.where.not(id: current_user.id)
    end
  end
end
