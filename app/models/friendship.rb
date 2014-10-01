# == Schema Information
#
# Table name: friendships
#
#  accepted   :boolean          default("f")
#  created_at :datetime
#  friend_id  :integer
#  id         :integer          not null, primary key
#  updated_at :datetime
#  user_id    :integer
#
# Indexes
#
#  index_friendships_on_friend_id  (friend_id)
#  index_friendships_on_user_id    (user_id)
#

class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'
end
