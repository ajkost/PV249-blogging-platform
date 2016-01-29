class UsersController < ApplicationController
  def index
  	@users = User.all
  	authorize! :show, @user
  end
end
