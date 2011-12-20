require 'spec_helper'

describe AccessRight do
  subject { Factory :access_right }
  
  it { should be_valid }  
  
  it "should return these proper rights" do
    AccessRight.all_rights.sort_by {|hash| hash[:title] }.should == [
      {:value=>[:create,  About], :title=>"O nas - Ustvarjanje"},
      {:value=>[:update,  About], :title=>"O nas - Urejanje"},
      {:value=>[:manage,  About], :title=>"O nas - Upravljanje"},

      {:value=>[:read,  Comment], :title=>"Komentar - Branje"},

      {:value=>[:create,  Condition], :title=>"Pogoji uporabe - Ustvarjanje"},
      {:value=>[:update,  Condition], :title=>"Pogoji uporabe - Urejanje"},
      {:value=>[:manage,  Condition], :title=>"Pogoji uporabe - Upravljanje"},

      {:value=>[:create,  Contact], :title=>"Kontakt - Ustvarjanje"},
      {:value=>[:update,  Contact], :title=>"Kontakt - Urejanje"},
      {:value=>[:manage,  Contact], :title=>"Kontakt - Upravljanje"},

      {:value=>[:destroy, CookingSchool], :title=>"Šola kuhanja - Brisanje"},
      {:value=>[:create,  CookingSchool], :title=>"Šola kuhanja - Ustvarjanje"},
      {:value=>[:update,  CookingSchool], :title=>"Šola kuhanja - Urejanje"},
      {:value=>[:manage,  CookingSchool], :title=>"Šola kuhanja - Upravljanje"},

      {:value=>[:destroy, Cook], :title=>"Kuharji - Brisanje"},
      {:value=>[:create,  Cook], :title=>"Kuharji - Ustvarjanje"},
      {:value=>[:update,  Cook], :title=>"Kuharji - Urejanje"},
      {:value=>[:manage,  Cook], :title=>"Kuharji - Upravljanje"},

      {:value=>[:destroy, Eko], :title=>"Eko - Brisanje"},
      {:value=>[:create,  Eko], :title=>"Eko - Ustvarjanje"},
      {:value=>[:update,  Eko], :title=>"Eko - Urejanje"},
      {:value=>[:manage,  Eko], :title=>"Eko - Upravljanje"},

      {:value=>[:destroy, Event], :title=>"Dogodki - Brisanje"},
      {:value=>[:create,  Event], :title=>"Dogodki - Ustvarjanje"},
      {:value=>[:update,  Event], :title=>"Dogodki - Urejanje"},
      {:value=>[:manage,  Event], :title=>"Dogodki - Upravljanje"},

      {:value=>[:destroy, ExternalContentKind], :title=>"Vrste zunanjih vsebin - Brisanje"},
      {:value=>[:create,  ExternalContentKind], :title=>"Vrste zunanjih vsebin - Ustvarjanje"},
      {:value=>[:update,  ExternalContentKind], :title=>"Vrste zunanjih vsebin - Urejanje"},
      {:value=>[:manage,  ExternalContentKind], :title=>"Vrste zunanjih vsebin - Upravljanje"},

      {:value=>[:update,  ExternalContent], :title=>"Zunanje vsebine - Urejanje"},

      {:value=>[:destroy, Healthy], :title=>"Zdravo - Brisanje"},
      {:value=>[:create,  Healthy], :title=>"Zdravo - Ustvarjanje"},
      {:value=>[:update,  Healthy], :title=>"Zdravo - Urejanje"},
      {:value=>[:manage,  Healthy], :title=>"Zdravo - Upravljanje"},

      {:value=>[:destroy, IngredientGroup], :title=>"Skupine sestavin - Brisanje"},
      {:value=>[:create,  IngredientGroup], :title=>"Skupine sestavin - Ustvarjanje"},
      {:value=>[:update,  IngredientGroup], :title=>"Skupine sestavin - Urejanje"},
      {:value=>[:manage,  IngredientGroup], :title=>"Skupine sestavin - Upravljanje"},

      {:value=>[:destroy, Ingredient], :title=>"Sestavine - Brisanje"},
      {:value=>[:create,  Ingredient], :title=>"Sestavine - Ustvarjanje"},
      {:value=>[:update,  Ingredient], :title=>"Sestavine - Urejanje"},
      {:value=>[:manage,  Ingredient], :title=>"Sestavine - Upravljanje"},

      {:value=>[:destroy, KnowIt], :title=>"Dobro je vedeti - Brisanje"},
      {:value=>[:create,  KnowIt], :title=>"Dobro je vedeti - Ustvarjanje"},
      {:value=>[:update,  KnowIt], :title=>"Dobro je vedeti - Urejanje"},
      {:value=>[:manage,  KnowIt], :title=>"Dobro je vedeti - Upravljanje"},

      {:value=>[:destroy, Origin], :title=>"Vir recepta - Brisanje"},
      {:value=>[:create,  Origin], :title=>"Vir recepta - Ustvarjanje"},
      {:value=>[:update,  Origin], :title=>"Vir recepta - Urejanje"},
      {:value=>[:manage,  Origin], :title=>"Vir recepta - Upravljanje"},

      {:value=>[:destroy, Nostalgic], :title=>"Nostalgija - Brisanje"},
      {:value=>[:create,  Nostalgic], :title=>"Nostalgija - Ustvarjanje"},
      {:value=>[:update,  Nostalgic], :title=>"Nostalgija - Urejanje"},
      {:value=>[:manage,  Nostalgic], :title=>"Nostalgija - Upravljanje"},

      {:value=>[:manage,  Parsing], :title=>"Nalaganje XML datoteke - Upravljanje"},
      
      {:value=>[:destroy, Photo], :title=>"Fotografije - Brisanje"},
      {:value=>[:create,  Photo], :title=>"Fotografije - Ustvarjanje"},
      {:value=>[:manage,  Photo], :title=>"Fotografije - Upravljanje"},

      {:value=>[:destroy, ProductFirm], :title=>"Proizvajalci izdelkov - Brisanje"},
      {:value=>[:create,  ProductFirm], :title=>"Proizvajalci izdelkov - "},
      {:value=>[:update,  ProductFirm], :title=>"Proizvajalci izdelkov - Urejanje"},
      {:value=>[:manage,  ProductFirm], :title=>"Proizvajalci izdelkov - Upravljanje"},

      {:value=>[:destroy, Product], :title=>"Izdelki - Brisanje"},
      {:value=>[:create,  Product], :title=>"Izdelki - Ustvarjanje"},
      {:value=>[:update,  Product], :title=>"Izdelki - Urejanje"},
      {:value=>[:manage,  Product], :title=>"Izdelki - Upravljanje"},

      {:value=>[:destroy, RecipeAuthor], :title=>"Avtor recepta - Brisanje"},
      {:value=>[:create,  RecipeAuthor], :title=>"Avtor recepta - Ustvarjanje"},
      {:value=>[:update,  RecipeAuthor], :title=>"Avtor recepta - Urejanje"},
      {:value=>[:manage,  RecipeAuthor], :title=>"Avtor recepta - Upravljanje"},

      {:value=>[:destroy, RecipeIngredient], :title=>"Sestavina recepta - Brisanje"},
      {:value=>[:create,  RecipeIngredient], :title=>"Sestavina recepta - Ustvarjanje"},
      {:value=>[:update,  RecipeIngredient], :title=>"Sestavina recepta - Urejanje"},
      {:value=>[:manage,  RecipeIngredient], :title=>"Sestavina recepta - Upravljanje"},

      {:value=>[:destroy, RecipeKind], :title=>"Vrste receptov - Brisanje"},
      {:value=>[:create,  RecipeKind], :title=>"Vrste receptov - Ustvarjanje"},
      {:value=>[:update,  RecipeKind], :title=>"Vrste receptov - Urejanje"},
      {:value=>[:manage,  RecipeKind], :title=>"Vrste receptov - Upravljanje"},

      {:value=>[:destroy, RecipeSourceKind], :title=>"Vrste virov receptov - Brisanje"},
      {:value=>[:create,  RecipeSourceKind], :title=>"Vrste virov receptov - Ustvarjanje"},
      {:value=>[:update,  RecipeSourceKind], :title=>"Vrste virov receptov - Urejanje"},
      {:value=>[:manage,  RecipeSourceKind], :title=>"Vrste virov receptov - Upravljanje"},

      {:value=>[:destroy, RecipeSource], :title=>"Vir - Brisanje"},
      {:value=>[:create,  RecipeSource], :title=>"Vir - Ustvarjanje"},
      {:value=>[:update,  RecipeSource], :title=>"Vir - Urejanje"},
      {:value=>[:manage,  RecipeSource], :title=>"Vir - Upravljanje"},    

      {:value=>[:destroy, RecipeWine], :title=>"Vino recepta - Brisanje"},
      {:value=>[:create,  RecipeWine], :title=>"Vino recepta - Ustvarjanje"},
      {:value=>[:update,  RecipeWine], :title=>"Vino recepta - Urejanje"},
      {:value=>[:manage,  RecipeWine], :title=>"Vino recepta - Upravljanje"},

      {:value=>[:destroy, Recipe], :title=>"Recepti - Brisanje"},
      {:value=>[:create,  Recipe], :title=>"Recepti - Ustvarjanje"},
      {:value=>[:update,  Recipe], :title=>"Recepti - Urejanje"},
      {:value=>[:manage,  Recipe], :title=>"Recepti - Upravljanje"},

      {:value=>[:destroy, TableCover], :title=>"Pogrinjki - Brisanje"},
      {:value=>[:create,  TableCover], :title=>"Pogrinjki - Ustvarjanje"},
      {:value=>[:update,  TableCover], :title=>"Pogrinjki - Urejanje"},
      {:value=>[:manage,  TableCover], :title=>"Pogrinjki - Upravljanje"},

      {:value=>[:destroy, Tool], :title=>"Pripomočki - Brisanje"},
      {:value=>[:create,  Tool], :title=>"Pripomočki - Ustvarjanje"},
      {:value=>[:update,  Tool], :title=>"Pripomočki - Urejanje"},
      {:value=>[:manage,  Tool], :title=>"Pripomočki - Upravljanje"},

      {:value=>[:destroy, Unit], :title=>"Enote - Brisanje"},
      {:value=>[:create,  Unit], :title=>"Enote - Ustvarjanje"},
      {:value=>[:update,  Unit], :title=>"Enote - Urejanje"}   ,
      {:value=>[:manage,  Unit], :title=>"Enote - Upravljanje"},

      {:value=>[:destroy, Vendor], :title=>"Ponudniki - Brisanje"},
      {:value=>[:create,  Vendor], :title=>"Ponudniki - Ustvarjanje"},
      {:value=>[:update,  Vendor], :title=>"Ponudniki - Urejanje"},
      {:value=>[:manage,  Vendor], :title=>"Ponudniki - Upravljanje"},

      {:value=>[:destroy, VendorsProduct], :title=>"Ponudnikovi produkti - Brisanje"},
      {:value=>[:create,  VendorsProduct], :title=>"Ponudnikovi produkti - Ustvarjanje"},
      {:value=>[:update,  VendorsProduct], :title=>"Ponudnikovi produkti - Urejanje"},
      {:value=>[:manage,  VendorsProduct], :title=>"Ponudnikovi produkti - Upravljanje"},

      {:value=>[:destroy, WineColor], :title=>"Barva vina - Brisanje"},
      {:value=>[:create,  WineColor], :title=>"Barva vina - Ustvarjanje"},
      {:value=>[:update,  WineColor], :title=>"Barva vina - Urejanje"},
      {:value=>[:manage,  WineColor], :title=>"Barva vina - Upravljanje"},

      {:value=>[:destroy, WineGroup], :title=>"Skupina vina - Brisanje"},
      {:value=>[:create,  WineGroup], :title=>"Skupina vina - Ustvarjanje"},
      {:value=>[:update,  WineGroup], :title=>"Skupina vina - Urejanje"},
      {:value=>[:manage,  WineGroup], :title=>"Skupina vina - Upravljanje"},

      {:value=>[:destroy, WineKind], :title=>"Vrsta vina - Brisanje"},
      {:value=>[:create,  WineKind], :title=>"Vrsta vina - Ustvarjanje"},
      {:value=>[:update,  WineKind], :title=>"Vrsta vina - Urejanje"},
      {:value=>[:manage,  WineKind], :title=>"Vrsta vina - Upravljanje"},

      {:value=>[:destroy, Wine], :title=>"Vino - Brisanje"},
      {:value=>[:create,  Wine], :title=>"Vino - Ustvarjanje"},
      {:value=>[:update,  Wine], :title=>"Vino - Urejanje"},
      {:value=>[:manage,  Wine], :title=>"Vino - Upravljanje"}
    ].sort_by {|hash| hash[:title] }
  end
  
  it "should reject value properties, that are not in the preset rights array" do
    access_right = AccessRight.new
    access_right.user_kind_right = { :title => "Krneki", :value => [:abalbala, Recipe] }
    access_right.save
    access_right.should_not be_valid 
  end
  
  it "should reject value properties, that are not in the preset rights array" do
    access_right = AccessRight.new
    access_right.user_kind_right = { :title => "Krneki", :value => [:manage, User] }
    access_right.save
    access_right.should_not be_valid 
  end
  
  it "should return a user_kind_right hash" do
    subject.user_kind_right.should == { :title=>"Recepti - Upravljanje", :value => [:manage,  Recipe]  }
  end
  
end
