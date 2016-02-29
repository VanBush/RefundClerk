class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.integer :refund_percentage

      t.timestamps null: false
    end
  end
end
