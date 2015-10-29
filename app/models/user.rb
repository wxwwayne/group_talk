class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  has_many :groups, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :group_users, foreign_key: "user_id", dependent: :destroy
  has_many :participated_groups, through: :group_users, source: :group

  def is_member_of?(group)
    participated_groups.include?(group)
  end

  def join_in(group)
    group_users.create(group_id: group.id)
  end

  def quit_from(group)
    group_users.find_by(group_id: group.id).destroy
  end
end
