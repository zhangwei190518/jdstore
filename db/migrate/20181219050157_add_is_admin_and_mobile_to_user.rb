class AddIsAdminAndMobileToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_admin, :boolean, default: false
    add_column :users, :mobile, :string
  end
end
