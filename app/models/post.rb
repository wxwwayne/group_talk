class Post < ActiveRecord::Base
  belongs_to :group, counter_cache: :posts_count
  belongs_to :user
  validates :content, presence: true
  validates :group_id, presence: true
  validates :user_id, presence: true
  default_scope -> { order(updated_at: :desc) }
end
