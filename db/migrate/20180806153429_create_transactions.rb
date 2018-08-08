class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.float :total_amount, null: false
      t.string :status, index: true
      t.string :payment_gateway, index: true

      t.timestamps

      t.references :payment_type, foreign_key: true
      t.references :receipt, foreign_key: true
    end
  end
end
