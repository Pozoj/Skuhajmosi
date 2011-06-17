Factory.define :access_right do |f|
  f.association :user_kind
  f.user_kind_right "manageRecipe"
end

Factory.define :external_content do |f|
  f.name "Delo"
  f.title "Na danasnji dan ga trgamo."
end

Factory.define :external_content_kind do |f|
  f.name "Revija"
end

Factory.define :ingredient do |f|
  f.name "Korencek"
end

Factory.define :ingredient_group do |f|
  f.name "Ribe"
end

Factory.define :photo do |f|
  f.association :holder, :factory => :recipe
  f.photo_file_name "fajl.jpg"
end

Factory.define :product do |f|
  f.name "Keks z nasmehom"
  f.quantity BigDecimal('56')
  f.association :ingredient
  f.association :product_firm
  f.association :unit
end

Factory.define :product_firm do |f|
  f.name "Krash"
end

Factory.define :recipe do |f|
  f.name "Piscanec v kozji omaki"
  f.association :author, :factory => :user
end

Factory.define :recipe_author do |f|
  f.first_name "Slavko"
  f.last_name "Adamlje"
  f.association :recipe_source
end

Factory.define :recipe_ingredient do |f|
  f.association :recipe
  f.association :ingredient
  f.association :unit
  f.quantity 40
end

Factory.define :recipe_kind do |f|
  f.name "Vegi"
end

Factory.define :recipe_source do |f|
  f.association :recipe
  f.title "Velika kuharska knjiga"
end

Factory.define :recipe_wine do |f|
  f.association :recipe
  f.association :wine
end

Factory.define :unit do |f|
  f.name "gram"
  f.short_name "g"
  f.denominator 1000
end

Factory.define :user do |f|
  f.first_name "Lojze"
  f.last_name "Slak"
  f.sequence(:email) { |n| "lojze.slak#{n}@skuhajmo.si" }
  f.password "SimonTalek"
  f.password_confirmation "SimonTalek"
  f.association :user_kind
end

Factory.define :user_kind do |f|
  f.sequence(:name) { |n| "adminstrator_#{n}" }
end

Factory.define :vendor do |f|
  f.name "Merkatorij"
end

Factory.define :vendors_product do |f|
  f.price BigDecimal('56')
  f.association :vendor
  f.association :product
end

Factory.define :wine do |f|
  f.association :author, :factory => :user
  f.association :wine_group
  f.association :wine_color
  f.association :wine_kind 
  f.description "Labala labala ful dobro vino."
end

Factory.define :wine_kind do |f|
  f.name "Suho"
  f.description "Na kislo vlece"
end

Factory.define :wine_group do |f|
  f.name "Refosk"
  f.description "Mmm, refosk"
end

Factory.define :wine_color do |f|
  f.name "Rosso"
  f.description "Roso boso"
end
