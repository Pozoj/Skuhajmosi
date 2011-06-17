class AccessRight < ActiveRecord::Base
  belongs_to :user_kind
  validates_presence_of :user_kind_id, :name, :right
  validate :validate_selected_right
      
  RIGHTS = {
    :manage => "Lahko upravlja",
    :create => "Lahko ustvarja",
    #:read => "Lahko bere",
    :update => "Lahko ureja",
    :destroy => "Lahko briše"
  }
  
  MODELS = {
    Ingredient => "sestavine", 
    IngredientGroup => "skupine sestavin", 
    Photo => "fotografije",
    Product => "izdelke",
    ProductFirm => "proizvajalce produktov", 
    Recipe => "recepte", 
    RecipeKind => "vrste receptov", 
    Unit => "enote",
    Vendor => "ponudnike",
    ExternalContent => "zunanje vsebine"
  }
  
  USELESS_RIGHTS = [ 
    {:value => [:update,  Photo], :title => "Lahko ureja fotografije" },
    {:value => [:create,  ExternalContent], :title => "Lahko ustvarja zunanje vsebine"},
    {:value => [:manage,  ExternalContent], :title => "Lahko upravlja zunanje vsebine"},
    {:value => [:destroy, ExternalContent], :title => "Lahko briše zunanje vsebine"} 
  ]
  
  #Returns an array of hashes representing every needed premeision on accessible classes
  # Returned hash looks like this:
  #   [ {:title => "Title", :value => { :right => right_key, :name => model_key} }, ..]
  #
  def self.all_rights 
    all_rights = Array.new
    MODELS.each do |mk, mv|
      RIGHTS.each do |rk, rv|
        all_rights << { :title => rv + ' ' + mv, :value => [rk, mk] } 
      end
    end
    (all_rights - USELESS_RIGHTS).sort_by {|hash| hash[:title] }
  end
  
  def user_kind_right
    { :title => to_s, :value => [ rights_sym, models_class_name ] }
  end
  
  def user_kind_right=(_user_kind_right)
    right_name, model_name = "", ""    
    selected_right_array = rights_arr.reject {|r| _user_kind_right.index(r) != 0 }
    
    if selected_right_array.any?
      right_name = selected_right_array.first
      model_name = _user_kind_right.gsub(right_name, "")
    end
    
    if model_name.present?
      if models_arr.include? model_name
        self.right = right_name.to_s
        self.name = model_name.to_s
      end
    end
  end
  
  def to_s
    RIGHTS[rights_sym] + ' ' + MODELS[models_class_name] if (right and name)
  end
  
  def models_class_name
    name.classify.constantize if name
  end
  
  def rights_sym
    right.to_sym if right
  end

  private
      
  def rights_arr
    @rights_arr ||= RIGHTS.keys.collect {|k| k.to_s }
  end
  
  def models_arr
    @models_arr ||= MODELS.keys.collect {|k| k.to_s }
  end
  
  def validate_selected_right
    if self.name.nil? or self.right.nil?
      errors[:user_kind_right] = "Potrebno je izbrati pravico"
    else
      errors[:user_kind_right] = "Vrsti uporabnika ste že dodali izbrano pravico" if new_record? and AccessRight.find_by_user_kind_id_and_name_and_right(user_kind_id, name, right)
    end
  end  
end
