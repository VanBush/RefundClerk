class RefundRequest < ActiveRecord::Base
  extend Filterable

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

  validate :edit_only_if_pending, on: :update

  def refunded_amount
    amount * category.refund_percentage / 100
  end

  def self.monthly_summary(month, year)
    month_start = Date.new(year, month)
    month_end = month_start.end_of_month
    RefundRequest
      .accepted
      .joins('JOIN users ON refund_requests.user_id = users.id')
      .joins('JOIN categories ON refund_requests.category_id = categories.id')
      .select(:user_id, :full_name, 'sum(cast((amount * refund_percentage / 100) as decimal(5,2))) total_refunds')
      .where(created_at: month_start..month_end)
      .group(:user_id, :full_name)
  end

  private

    def self.allowed_filters
      [:user, :category, :status]
    end

    def edit_only_if_pending
      if changes.except(:status, :rejection_reason).present? && !pending?
        errors.add(:base, 'cannot be edited if already accepted or rejected')
      end
    end

end
