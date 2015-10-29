class Post < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  validates :content, presence: true
end
