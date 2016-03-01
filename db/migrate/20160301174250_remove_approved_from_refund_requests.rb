class RemoveApprovedFromRefundRequests < ActiveRecord::Migration
  def change
    remove_column :refund_requests, :approved, :boolean
  end
end
