class AddUserIdToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :user_id, :integer, foreign_key: true, index: true
  end
end