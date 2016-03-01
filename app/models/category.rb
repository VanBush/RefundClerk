class Category < ActiveRecord::Base
  has_many :refund_requests

  validates :title, presence: true
  validates :refund_percentage, numericality: { greater_than: 0,
                                                less_than_or_equal_to: 100 }
end
