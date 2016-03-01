class RemoveRejectionReasonFromRefundRequests < ActiveRecord::Migration
  def change
    remove_column :refund_requests, :rejection_reason, :string
  end
end
