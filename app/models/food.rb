class Food < ApplicationRecord
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  has_many :recipe_foods
  belongs_to :user
end
