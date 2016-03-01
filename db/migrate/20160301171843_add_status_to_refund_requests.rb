class AddStatusToRefundRequests < ActiveRecord::Migration
  def change
    add_column :refund_requests, :status, :integer, default: 0
  end
end
