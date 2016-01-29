class AddApprovingComments < ActiveRecord::Migration
  def change
  	add_column :blogposts, :comment_type, :integer, default: 0
  	add_column :comments, :approved, :boolean, default: false
  end
end
