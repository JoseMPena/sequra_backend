class CreateDisbursements < ActiveRecord::Migration[5.1]
  def change
    create_table :disbursements do |t|
      t.references :order
      t.float :amount

      t.timestamps
    end
  end
end
