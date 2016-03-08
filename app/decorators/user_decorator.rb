class UserDecorator < ApplicationDecorator
  delegate_all

  def full_name
    h.link_to object.full_name, h.refund_requests_path(user: object)
  end

  def request_count(status)
    object.refund_requests.send(status).count
  end

  def total_refunds
    h.number_to_currency(object.refund_requests.accepted.joins(:category)
                               .sum('amount * refund_percentage / 100'))
  end

end
