class Group < ActiveRecord::Base
  validates :title, presence: true
  has_many :posts
  belongs_to :user

  def owned_by?(user)
    user && user == self.user
  end
end
