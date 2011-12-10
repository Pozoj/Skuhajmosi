class UserKind 
  attr_accessor :id, :title
    
  USER_KINDS = {
    :external     => "Zunanji",
    :worker       => "Delavec",
    :vendor       => "Veletrgovec",
    :master_cook  => "Mojster",
    :lector       => "Lektor",
    :firm         => "Podjetje",
    :special      => "Posebnež",
    :other        => "Dodatna vrsta"
  }
  
  ALL_USER_KINDS = USER_KINDS.merge({ :admin => "Administrator" })
  
  def initialize(options = {})
    self.id = options[:id].to_sym if options[:id]
    self.title = options[:title].to_s if options[:title]
    return unless @id.present? and @title.present?
  end
  
  class << self
    def find(id)
      return unless id and USER_KINDS.include?(id.to_sym)
      id = id.to_sym
      self.new :id => id, :title => USER_KINDS[id]
    end
    
    def find_among_all(id)
      return unless id and ALL_USER_KINDS.include?(id.to_sym)
      id = id.to_sym
      self.new :id => id, :title => ALL_USER_KINDS[id]
    end
    
    def all
      USER_KINDS.map { |array| self.new :id => array[0], :title => array[1] }
    end
    
    def all_with_admin
      ALL_USER_KINDS.map { |array| self.new :id => array[0], :title => array[1] }
    end

    def to_hash
      USER_KINDS
    end
    
    def external
      "external"
    end

    def worker
      "worker"
    end

    def master_cook
      "master_cook"
    end

    def lector
      "lector"
    end
    
    def special
      "special"
    end
    
    def vendor
      "vendor"
    end
    
    def firm
      "firm"
    end

    def other
      "other"
    end
  end
  
  def vendor?
    id == :vendor
  end
  
  def external?
    id == :external
  end
  
  def worker?
    id == :worker
  end
  
  def master_cook?
    id == :master_cook
  end
  
  def lector?
    id == :lector
  end
  
  def firm?
    id == :firm
  end
  
  def other?
    id == :other
  end
  
  def to_s
    title
  end

end
