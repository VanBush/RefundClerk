class CategoryPolicy < ApplicationPolicy
  def index?
    @user.present? && @user.admin?
  end

  def edit?
    index?
  end

  def update?
    index?
  end

  def new?
    index?
  end

  def create?
    index?
  end

  def destroy?
    index?
  end

end
