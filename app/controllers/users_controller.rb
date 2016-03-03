class UsersController < ApplicationController
  def index
    authorize User
    @users = User.all.decorate
  end
end
