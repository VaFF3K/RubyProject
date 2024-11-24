class AddDetailsToOrders < ActiveRecord::Migration[8.0]
  def change
    add_column :orders, :first_name, :string
    add_column :orders, :last_name, :string
    add_column :orders, :phone, :string
    add_column :orders, :email, :string
    # add_column :orders, :address, :string # Закоментуйте цей рядок
    add_column :orders, :city, :string
    add_column :orders, :region, :string
    add_column :orders, :delivery_method, :string
    add_column :orders, :payment_method, :string
  end
end
