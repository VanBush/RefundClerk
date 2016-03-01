class AddRejectionReasonToRefundRequest < ActiveRecord::Migration
  def change
    add_column :refund_requests, :rejection_reason, :string
  end
end
