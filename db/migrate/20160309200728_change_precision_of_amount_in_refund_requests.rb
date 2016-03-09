class ChangePrecisionOfAmountInRefundRequests < ActiveRecord::Migration
  def self.up
    change_column :refund_requests, :amount, :decimal, { :scale => 2, :precision => 12 }
  end

  def self.down
    change_column :refund_requests, :amount, :decimal, { :scale => 2, :precision => 5 }
  end
end
