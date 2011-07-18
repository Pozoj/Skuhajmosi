require 'spec_helper'

describe AccessRight do
  subject { Factory :access_right }
  
  it { should be_valid }  
  
  it "should return these proper rights" do
    AccessRight.all_rights.sort_by {|hash| hash[:title] }.should == [
      {:value=>[:destroy, ProductFirm], :title=>"Lahko briše proizvajalce produktov"},
      {:value=>[:create,  ProductFirm], :title=>"Lahko ustvarja proizvajalce produktov"},
      {:value=>[:update,  ProductFirm], :title=>"Lahko ureja proizvajalce produktov"},
      {:value=>[:manage,  ProductFirm], :title=>"Lahko upravlja proizvajalce produktov"},
      {:value=>[:destroy, Unit], :title=>"Lahko briše enote"},
      {:value=>[:create,  Unit], :title=>"Lahko ustvarja enote"},
      {:value=>[:update,  Unit], :title=>"Lahko ureja enote"}   ,
      {:value=>[:manage,  Unit], :title=>"Lahko upravlja enote"},
      {:value=>[:destroy, IngredientGroup], :title=>"Lahko briše skupine sestavin"},
      {:value=>[:create,  IngredientGroup], :title=>"Lahko ustvarja skupine sestavin"},
      {:value=>[:update,  IngredientGroup], :title=>"Lahko ureja skupine sestavin"},
      {:value=>[:manage,  IngredientGroup], :title=>"Lahko upravlja skupine sestavin"},
      {:value=>[:destroy, Product], :title=>"Lahko briše izdelke"},
      {:value=>[:create,  Product], :title=>"Lahko ustvarja izdelke"},
      {:value=>[:update,  Product], :title=>"Lahko ureja izdelke"},
      {:value=>[:manage,  Product], :title=>"Lahko upravlja izdelke"},
      {:value=>[:destroy, Ingredient], :title=>"Lahko briše sestavine"},
      {:value=>[:create,  Ingredient], :title=>"Lahko ustvarja sestavine"},
      {:value=>[:update,  Ingredient], :title=>"Lahko ureja sestavine"},
      {:value=>[:manage,  Ingredient], :title=>"Lahko upravlja sestavine"},
      {:value=>[:destroy, Vendor], :title=>"Lahko briše ponudnike"},
      {:value=>[:create,  Vendor], :title=>"Lahko ustvarja ponudnike"},
      {:value=>[:update,  Vendor], :title=>"Lahko ureja ponudnike"},
      {:value=>[:manage,  Vendor], :title=>"Lahko upravlja ponudnike"},
      {:value=>[:destroy, Recipe], :title=>"Lahko briše recepte"},
      {:value=>[:create,  Recipe], :title=>"Lahko ustvarja recepte"},
      {:value=>[:update,  Recipe], :title=>"Lahko ureja recepte"},
      {:value=>[:manage,  Recipe], :title=>"Lahko upravlja recepte"},
      {:value=>[:destroy, RecipeKind], :title=>"Lahko briše vrste receptov"},
      {:value=>[:create,  RecipeKind], :title=>"Lahko ustvarja vrste receptov"},
      {:value=>[:update,  RecipeKind], :title=>"Lahko ureja vrste receptov"},
      {:value=>[:manage,  RecipeKind], :title=>"Lahko upravlja vrste receptov"},
      {:value=>[:destroy, Photo], :title=>"Lahko briše fotografije"},
      {:value=>[:create,  Photo], :title=>"Lahko ustvarja fotografije"},
      {:value=>[:manage,  Photo], :title=>"Lahko upravlja fotografije"},
      {:value=>[:update,  ExternalContent], :title=>"Lahko ureja zunanje vsebine"}
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
    subject.user_kind_right.should == { :title=>"Lahko upravlja recepte", :value => [:manage,  Recipe]  }
  end
  
end
