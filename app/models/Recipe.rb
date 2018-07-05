class Recipe

@@all = []

attr_reader :name

def initialize(name)
  @name = name
  @@all << self
end

def self.all
  @@all
end

def self.most_popular
  sorted_recipes = Recipe.all.sort_by {|recipe| recipe.users.length}
  sorted_recipes[-1]
end

def users
  RecipeCard.all.select do |card|
    if card.recipe == self
      card.user
    end
  end
end

def ingredients
  RecipeIngredient.all.select do |ri|
    if ri.recipe == self
      ri.ingredient
    end
  end
end

def allergens
  allergen_ingredients.select do |ingredient|
    self.ingredients.include?(ingredient)
  end
end

def allergen_ingredients
  Allergen.all.map do |allergen|
    allergen.ingredient
  end
end

def add_ingredients(array)
  array.each do |ingredient|
    RecipeIngredient.new(recipe: self, ingredient: ingredient)
  end
end






#Old bad method
# def add_ingredients(array)
#   array.each do |ingredient|
#     self.ingredients << ingredient
#   end
# end





end