class CategoryDecorator < Draper::Decorator
  delegate_all

  def title
    h.link_to object.title, h.refund_requests_url(category: object)
  end

  def refund_percentage
    "#{object.refund_percentage}%"
  end

  def edit_link
    h.link_to 'Edit', h.edit_category_path(object)
  end

  def delete_link
    h.link_to 'Delete', object, :method => :delete, :data => { :confirm => 'Are you sure?' }
  end

end
