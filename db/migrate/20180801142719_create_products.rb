class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :type, null: false
      t.float :unit_price
      t.boolean :tax_exempted
      t.timestamps
    end
  end
end
