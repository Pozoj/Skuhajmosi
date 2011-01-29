Factory.define :recipe do |f|
  f.name "Piscanec v kozji omaki"
  f.association :user
end

Factory.define :ingredient do |f|
  f.name "Korencek"
end

Factory.define :recipe_ingredient do |f|
  f.association :recipe
  f.association :ingredient
  f.association :quantity_unit, :factory => :unit
  f.quantity 40
end

Factory.define :unit do |f|
  f.name "gram"
  f.short_name "g"
  f.denominator 1
end

Factory.define :user do |f|
  f.first_name "Lojze"
  f.last_name "Slak"
  f.sequence(:email) { |n| "lojze.slak#{n}@skuhajmo.si" }
end