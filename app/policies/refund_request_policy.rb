class RefundRequestPolicy < ApplicationPolicy

  def create?
    @user.present?
  end

  def update?
    @user.present? && (@user.admin? || @user == @record.user)
  end

  def destroy?
    update?
  end

  def index?
    create?
  end

  def show?
    update?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end

  def permitted_attributes
    if @user.admin?
      [:title, :description, :amount, :category_id, :status, :rejection_reason]
    else
      [:title, :description, :amount, :category_id]
    end
  end

end
