class UsersController < ApplicationController
  def index
    authorize User
    @users = User.all
    @users = paginate(@users).decorate
  end
end
