Factory.define :about do |f|
  f.content "Mora bit"
end

Factory.define :access_right do |f|
  f.user_kind_right "manageRecipe"
  f.user_kind_id "worker"
end

Factory.define :comment do |f|
  f.name "Branko Copic"
  f.content "Men je sajt ful kul"
end

Factory.define :condition do |f|
  f.content "Mora bit"
end

Factory.define :contact do |f|
  f.name "Pozoj d.o.o." 
  f.address "Uzad dijaskega" 
  f.tax_nr "102031"
  f.telephone "0321031202031" 
  f.fax "032103201032012" 
  f.mobile "123-12123-123"
  f.email "info@pozoj.si"
  f.website "www.pozoj.si"
  f.notes "tu smo in ga trgamo"
end

Factory.define :cook do |f|
  f.first_name "Brane"
  f.last_name "Oblak"
  f.description "Tudi on kuha"
end

Factory.define :cooking_school do |f|
  f.title "Nemaveze"
  f.content "Neki more met not, sicer ni neech"
end

Factory.define :external_content do |f|
  f.name "Delo"
  f.title "Na danasnji dan ga trgamo."
end

Factory.define :eko do |f|
  f.title "Nemaveze"
  f.content "Neki more met not, sicer ni neech"
end

Factory.define :event do |f|
  f.title "Piknik stari moj"
  f.content "Piknik bo, kdor ne pride je supakfejs"
  f.location "Uzad grada, kjer se masti"
  f.starting_at DateTime.now
end

Factory.define :external_content_kind do |f|
  f.name "Revija"
end

Factory.define :healthy do |f|
  f.title "Nemaveze"
  f.content "Neki more met not, sicer ni neech"
end

Factory.define :ingredient do |f|
  f.name "Korencek"
  f.price_for_weight_in_grams BigDecimal("1")
  f.weight_in_grams BigDecimal("2")
end

Factory.define :ingredient_group do |f|
  f.name "Ribe"
end

Factory.define :know_it do |f|
  f.title "Nemaveze"
  f.content "Neki more met not, sicer ni neech"  
end

Factory.define :nostalgic do |f|
  f.title "Nemaveze"
  f.content "Neki more met not, sicer ni neech"
end

Factory.define :origin do |f|
  f.association :recipe
  f.association :recipe_source
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
  f.short_name "Pisce"
  f.num_people 4  
  f.summary "Tole bo kratek opis madafaka."
  f.preparation "Tkle se recept pripravi mofo"
  f.suggestion "Priporoceno je, da tk naredis mofo"
  f.time_to_prepare 10
  f.time_to_cook 65
  f.status_id "master_treated"
end

Factory.define :original_recipe do |f|
  f.authors_name "Zdravko Čolić"
  f.authors_email "cola_do_bola@gmail.com"
  f.name "Prazen testis s krompirjem"
  f.num_people 4
  f.preparation "Treba je poprazit testis, spect mal krompirja in to je to."
  f.ingredients "Testis 100g, Ena zlicka olja"
end

Factory.define :recipe_author do |f|
  f.first_name "Slavko"
  f.last_name "Adamlje"
end

Factory.define :recipe_ingredient do |f|
  f.association :recipe
  f.association :ingredient
  f.association :unit
  f.quantity 40
  f.weight_in_grams 0 
end

Factory.define :recipe_kind do |f|
  f.name "Vegi"
end

Factory.define :recipe_source do |f|
  f.association :recipe_author
  f.association :recipe_source_kind
end

Factory.define :recipe_source_kind do |f|
  f.title "Uporabniski recepti"
  f.description "Stga je pa uporabnik vneso"
end

Factory.define :recipe_wine do |f|
  f.association :recipe
  f.association :wine
end

Factory.define :table_cover do |f|
  f.title "Nemaveze"
  f.content "Neki more met not, sicer ni neech"
end

Factory.define :tool do |f|
  f.title "Nemaveze"
  f.content "Neki more met not, sicer ni neech"
end


Factory.define :unit do |f|
  f.name "gram"
  f.short_name "g"
  f.denominator 1000
  f.convertable true
end

Factory.define :user do |f|
  f.first_name "Lojze"
  f.last_name "Slak"
  f.sequence(:email) { |n| "lojze.slak#{n}@skuhajmo.si" }
  f.password "SimonTalek"
  f.password_confirmation "SimonTalek"
  f.user_kind_id "worker"
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
