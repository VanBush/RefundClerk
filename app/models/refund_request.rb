class RefundRequest < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  validates :user, presence: true
  validates :category, presence: true

  validates :description, presence: true
  validates :title, presence: true, length: { maximum: 50 }

  validates :amount, numericality: { greater_than: 0 }

  enum status: { pending: 0, accepted: 1, rejected: 2 }
  validates :status, presence: true

  validates :rejection_reason, presence: true, if: 'rejected?'

  def refunded_amount
    amount * category.refund_percentage / 100
  end

end
