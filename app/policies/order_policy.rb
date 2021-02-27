class OrderPolicy < ApplicationPolicy
  def index?
    return true if user.present? && user_ownership(order) || user.admin?
  end

  def show?
    return true if user.present? && user == order.user || user.admin?
  end

  def create?
    user.present?
  end

  private

  def order
    record
  end

  def user_ownership(orders)
    orders.pluck(:user_id).include? user.id
  end
end
