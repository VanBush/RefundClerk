class CreateRefundRequests < ActiveRecord::Migration
  def change
    create_table :refund_requests do |t|
      t.references :category, index: true, foreign_key: true
      t.boolean :approved
      t.string :title
      t.string :description
      t.decimal :amount, precision: 5, scale: 2

      t.timestamps null: false
    end
  end
end
