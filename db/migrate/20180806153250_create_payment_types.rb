class CreatePaymentTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_types do |t|
      t.string :name, null: false
      t.string :payment_method, null: false

      t.timestamps
    end
  end
end
