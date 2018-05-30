class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.integer :category_id
      t.text :desc1
      t.text :desc2

      t.timestamps
    end
  end
end
