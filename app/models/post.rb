class Post < ActiveRecord::Base
  belongs_to :group, counter_cache: :posts_count
  belongs_to :user
  validates :content, presence: true
  default_scope -> { order(updated_at: :desc) }
end
