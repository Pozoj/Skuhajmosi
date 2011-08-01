class RecipeStatus
  attr_accessor :id, :title
  
  LOW_LEVEL_STATUS = {
    :treated        => "Obdelan"
  }
  
  STATUSES = {
    :rejected       => "Zavrnjen",
    :master_treated => "Mojstrsko obdelan",
    :lectored       => "Lektoriran",
    :approved       => "Odobren za prikaz"
  }
  
  def initialize(options = {})
    self.id = options[:id].to_sym if options[:id]
    self.title = options[:title].to_s if options[:title]
    return unless @id.present? and @title.present?
  end
  
  class << self
    def find(id)
      return unless id and STATUSES.include?(id.to_sym)
      id = id.to_sym
      self.new :id => id, :title => STATUSES[id]
    end

    def all
      STATUSES.map { |array| self.new :id => array[0], :title => array[1] }
    end

    def to_hash
      STATUSES
    end
    
    def keys
      ["treated", "rejected", "master_treated", "lectored", "approved" ]
    end
  end
  
  # def untreated?
  #   id == :untreated
  # end
  
  def treated?
    id == :treated
  end
  
  def master_treated?
    id == :master_treated
  end
  
  def lectored?
    id == :lectored
  end
  
  def rejected?
    id == :rejected
  end
  
  def approved?
    id == :approved
  end
  
  def to_s
    title
  end
  
end