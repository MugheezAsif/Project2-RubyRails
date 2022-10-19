class Subscription < ApplicationRecord
  belongs_to :plan
  belongs_to :user
  has_many :sub_features, dependent: :destroy
end
