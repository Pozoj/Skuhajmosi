class Container
  attr_accessor :id, :title
  
  CONTAINERS = {
    :abouts => "O nas",
    :events => "Dogodki",
    :know_its => "Dobro je vedeti",
    :recipe_kinds => "Vrste receptov",
    :units => "Enote",
    :access_rights => "Dostopne pravice",
    :external_content_kinds => "Vrste zunanjih vsebin",
    :nostalgics => "Nostalgija",
    :recipe_menus => "Uporabnikov meni",
    :user_kinds => "Vrste uporabnikov",
    :external_contents => "Zunanje vsebine",
    :original_recipes => "Uporabniški recepti",
    :recipe_source_kinds => "Vrste virov receptov",
    :users => "Uporabniki",
    :comments => "Komentarji",
    :recipe_sources => "Viri receptov",
    :vendors => "Ponudniki",
    :conditions => "Pogoji uporabe",
    :healthies => "Zdravo",
    :contacts => "Kontakt",
    :helpsters => "Pomoč uporabnikom",
    :product_firms => "Proizvajalci",
    :recipes => "Recepti",
    :cooking_schools => "Šola kuhanja",
    :products => "Produkti",
    :cooks => "Kuharji",
    :ingredient_groups => "Skupine sestavin",
    :recipe_authors => "Avtorji receptov",
    :table_covers => "Pogrinjki",
    :wines => "Vina",
    :ekos => "Eko",
    :ingredients => "Sestavine",
    :tools => "Pripomočki"
  }
  
  
  def initialize(options = {})
    self.id = options[:id].to_sym if options[:id]
    self.title = options[:title].to_s if options[:title]
    return unless @id.present? and @title.present?
  end
  
  class << self
    def find(id)
      return unless id and CONTAINERS.include?(id.to_sym)
      id = id.to_sym
      self.new :id => id, :title => CONTAINERS[id]
    end

    def all
      CONTAINERS.map { |array| self.new :id => array[0], :title => array[1] }
    end

    def to_hash
      CONTAINERS
    end
  end
end
