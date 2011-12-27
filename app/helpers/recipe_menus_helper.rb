module RecipeMenusHelper
  def quantity_fixer(quantity_in_grams)
    if quantity_in_grams >= BigDecimal("1000")
      return "#{n(quantity_in_grams/1000)} kg"
    elsif quantity_in_grams >= BigDecimal("100")
      return "#{n(quantity_in_grams/100)} dag"
    else
      return "#{n(quantity_in_grams)} g"  
    end
  end  
end