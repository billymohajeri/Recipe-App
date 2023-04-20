class RecipesController < ApplicationController
  before_action :set_user, expect: [:update]
  # def index
  #   @users = User.includes(recipes: %i[recipe_foods foods]).includes(:foods)
  #   @food_counts = @users.map { |user| [user.name, user.foods.count] }
  #   @food_prices = @users.map { |user| [user.name, user.foods.sum(:price)] }
  #   @recipes = Recipe.includes(:recipe_foods, :foods).where(public: true).order('created_at DESC')
  # end
  def index
    @recipes = @user.recipes
  end

  # def show
  #   @recipe = Recipe.find(params[:id])
  #   @recipe_foods = @recipe.recipe_foods
  # end

  def new
    @recipe = Recipe.new
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods
  end

  def public_allocation
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: params[:recipe][:public])
    redirect_to @recipe
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = @user

    if @recipe.save
      flash[:notice] = 'Recipe created successfully!'
      redirect_to recipe_path(id: @recipe.id)
    else
      flash.now[:alert] = @recipe.errors.full_messages.first if @recipe.errors.any?
      render :new, status: unprocessable_entity
    end
  end

  # def destroy_from_form
  #   @food = Food.find(params[:food_id])
  #   @food.destroy
  #   redirect_to foods_path(current_user)
  # end
  def destroy
    @recipe = Recipe.find(params[:id])

    if @recipe.destroy
      flash[:notice] = 'Recipe deleted successfully!'
      redirect_to recipes_path
    else
      flash.now[:alert] = @recipe.errors.full_messages.first if @recipe.errors.any?
      render :index, status: 400
    end
  end

  def toggle
    @recipe = Recipe.find(params[:id])
    @recipe.public = !@recipe.public
    text = @recipe.public? ? 'public' : 'private'

    if @recipe.save
      flash[:notice] = "#{@recipe.name} is now #{text}!"
    elsif @recipe.errors.any?
      flash[:alert] = @recipe.errors.full_messages.first
    end
    redirect_to recipe_path(id: @recipe.id)
  end

  private

  def set_user
    @user = current_user
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
