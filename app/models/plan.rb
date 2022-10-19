# class Plan
class Plan < ApplicationRecord
  belongs_to :user

  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions

  has_many :features, dependent: :destroy
  validates :name, :monthly_fee, presence: true
  validates :name, length: { maximum: 18 }
  validates :monthly_fee, length: { maximum: 4 }
end
