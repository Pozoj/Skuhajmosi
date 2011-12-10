class Helpster < ActiveRecord::Base
  validates_presence_of :help, :container, :user_kind
  
  validate :container_already_set, :on => :create
  
  def container
    Container.find(container_id)
  end
  
  def user_kind
    UserKind.find_among_all(user_kind_id)
  end
  
  def container=(co)
    self.container_id = Container.find(co).id if Container.find(co)
  end
  
  def user_kind=(uk)
    self.user_kind_id = UserKind.find_among_all(uk).id if UserKind.find_among_all(uk)
  end
  
  def to_s
    container.title
  end
  
  private
  
  def container_already_set
    errors.add :user_kind, "Vrsti uporabnika ste že podali pomočnika za izbran vsebnik" if Helpster.find_by_user_kind_id_and_container_id(user_kind_id, container_id).present?
  end
end
