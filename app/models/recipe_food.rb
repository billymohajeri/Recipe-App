class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food, dependent: :destroy
end
