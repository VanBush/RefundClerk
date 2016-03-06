class RefundRequestDecorator < Draper::Decorator
  delegate_all

  def created_at
    h.content_tag :span, class: 'time' do
      object.created_at.strftime("%a %m-%d-%Y")
    end
  end

  def delete_link
    h.link_to 'Delete', object, method: :delete,
              data: { confirm: 'Are you sure?' }
  end

  def details_link
    h.link_to object.title, object
  end

  def status
    h.link_to object.status, h.add_filter_url(status: object.status),
              class: "status-#{object.status}"
  end

  def category
    text = object.category.title
    return h.link_to text,
           h.add_filter_url(category: object.category)
  end

  def amount
    h.number_to_currency(object.amount)
  end

  def refund
    "#{h.number_to_currency(object.refunded_amount)} (#{object.category.refund_percentage}%)"
  end

  def user
    h.link_to object.user.full_name, h.add_filter_url(user: object.user)
  end

end
