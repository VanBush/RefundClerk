class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :refund_requests

  validates :full_name, presence: true,
                        length: { minimum: 2, tokenizer: ->(str) { str.scan(/\w+/) } }
end
