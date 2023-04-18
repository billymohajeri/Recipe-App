json.extract! recipe, :id, :name, :preparation_time, :cooking_time, :description, :public, :updated_at
json.url recipe_url(recipe, format: :json)
