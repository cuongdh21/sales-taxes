class CreateReceipts < ActiveRecord::Migration[5.2]
  def change
    create_table :receipts do |t|
      t.json :details, null: false
      t.timestamps
    end
  end
end
