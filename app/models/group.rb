class Group < ActiveRecord::Base
  validates :title, presence: true
  has_many :posts, dependent: :destroy
  belongs_to :user
  has_many :group_users, dependent: :destroy
  has_many :members, through: :group_users, source: :user, dependent: :destroy

end
