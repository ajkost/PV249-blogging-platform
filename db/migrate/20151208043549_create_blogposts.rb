class CreateBlogposts < ActiveRecord::Migration
  def change
    create_table :blogposts do |t|
      t.string :author
      t.text :body
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
