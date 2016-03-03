class UserPolicy < ApplicationPolicy
  def index?
    @user.present? && @user.admin?
  end
end
