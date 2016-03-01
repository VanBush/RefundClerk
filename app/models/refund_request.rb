class RefundRequest < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  validates :user, presence: true
  validates :category, presence: true

  validates :description, presence: true
  validates :title, presence: true, length: { maximum: 50 }

  validates :amount, numericality: { greater_than: 0 }
end
