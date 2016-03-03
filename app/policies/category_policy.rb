class CategoryPolicy < ApplicationPolicy
  def index?
    @user.present?
  end

  def edit?
    index? && @user.admin?
  end

  def update?
    edit?
  end

  def new?
    edit?
  end

  def create?
    edit?
  end

  def destroy?
    edit?
  end

end
