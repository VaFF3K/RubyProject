class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.text :product_list
      t.decimal :product_price
      t.text :address

      t.timestamps
    end
  end
end
