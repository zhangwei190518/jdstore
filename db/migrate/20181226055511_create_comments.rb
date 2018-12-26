class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :product_id
      t.references :user, foreign_key: true
      t.text :body

      t.timestamps
    end

    add_index :comments, :product_id
  end
end
