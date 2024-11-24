class AddProductIdToFeedbacks < ActiveRecord::Migration[8.0]
  def change
    add_column :feedbacks, :product_id, :integer
  end
end
