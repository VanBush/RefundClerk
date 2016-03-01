class Category < ActiveRecord::Base
  has_many :refund_requests
end
