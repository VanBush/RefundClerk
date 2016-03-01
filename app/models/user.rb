class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :refund_requests

  validates :full_name, presence: true,
                        length: { minimum: 2, tokenizer: ->(str) { str.scan(/\w+/) } }

  def total_refunds(year, month)
    month_start = Date.new(year, month)
    month_end = month_start.end_of_month
    accepted_requests = refund_requests.accepted.where(created_at: month_start..month_end)
    accepted_requests.collect { |r| r.refunded_amount }.sum
  end

end
