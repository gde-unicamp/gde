class User < ActiveRecord::Base
  has_many :friendships
  has_many :friends, through: :friendships

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar #, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def label
    nickname || name
  end
end
