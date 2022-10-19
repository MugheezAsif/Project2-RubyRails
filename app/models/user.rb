# class user
class User < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :plans, through: :subscriptions
  has_one_attached :avatar
  has_many :plans, dependent: :destroy
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :avatar,
            file_size:
    {
      less_than_or_equal_to: 25.megabytes
    },
            file_content_type:
    {
      allow: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']
    }
  validates :name, length: { maximum: 18 }
  validates :email, length: { maximum: 24 }
end
