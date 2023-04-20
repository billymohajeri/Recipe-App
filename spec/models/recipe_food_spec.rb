require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  subject do
    @user = User.create(name: 'Billy')
    @food = Food.create(name: 'Milk', measurement_unit: 'liter', price: 2, quantity: 5, user_id: @user.id)
    @recipe = Recipe.create(name: 'Pasta', preparation_time: 3, cooking_time: 1, description: 'You know how',
                            public: true, user_id: @user.id)
    @recipe_food = RecipeFood.create(quantity: 3, food_id: @food.id, recipe_id: @recipe.id)
  end

  before { subject.save }

  it 'Quantity should be present' do
    subject.quantity = nil
    expect(subject).to_not be_valid
  end

  it 'Quantity should have valid value' do
    expect(subject.quantity).to eql 3
  end

  it 'Quantity should be a integer' do
    expect(subject.quantity).to be_a(Integer)
  end
end
