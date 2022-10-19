# class Feature
class Feature < ApplicationRecord
  belongs_to :plan
  validates :name, :code, :unit_price, :max_limit, presence: true
  validates :name, length: { maximum: 18 }
  validates :code, length: { maximum: 12 }
  validates :unit_price, length: { maximum: 4 }
  validates :max_limit, length: { maximum: 2 }
end
