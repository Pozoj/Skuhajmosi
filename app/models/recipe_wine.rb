class RecipeWine < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :wine
end
