class Blogpost < ActiveRecord::Base
	DISABLED = 1
	ALL_ALLOWED = 0
	MODERATED = 2

	acts_as_taggable
	acts_as_commentable
	acts_as_votable
	resourcify
	belongs_to :user
  validates :body, :presence => true
  validates :author, :presence => true
  validates :tag_list, :presence => true
end
