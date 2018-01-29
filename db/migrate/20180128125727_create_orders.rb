class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :merchant
      t.references :shopper
      t.float :amount
      t.datetime :completed_at

      t.timestamps
    end
  end
end
