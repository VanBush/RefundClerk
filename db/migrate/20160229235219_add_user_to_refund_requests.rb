class AddUserToRefundRequests < ActiveRecord::Migration
  def change
    add_reference :refund_requests, :user, index: true, foreign_key: true
  end
end
