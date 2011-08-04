class ExternalsController < InheritedResources::Base
  load_and_authorize_resource
  defaults :resource_class => ExternalContent
  
  def update
    if admin?
      update!
    else
      external_content = ExternalContent.find params[:id]
      if proper_params?
        update!
      else
        flash[:error] = "Za urejanje vsebine nimate ustrezne avtorizacije."
        render "edit"
      end
    end
  end
  
  def destroy_photo
    @holder = ExternalContent.find_by_id(params[:id])
    @holder.photo.destroy
    if @holder.save
      flash.now[:notice] = "Uspešno ste izbrisali fotografijo."
      render "edit"
    else
      render "edit"
    end
  end
  
  private
  
  def proper_params?
    external_content = ExternalContent.find params[:id]
    author_id = params[:external_content][:author_id].to_i if params[:external_content][:author_id].present?
    content_kind_id = params[:external_content][:external_content_kind_id].to_i if params[:external_content][:external_content_kind_id].present?
    name_change_pressure = params[:external_content][:name].present?
    
    if external_content and author_id and content_kind_id and !name_change_pressure
      if external_content.author.id == author_id and external_content.external_content_kind.id == content_kind_id
        return true
      else
        return false
      end
    else
      return false
    end
  end
  
end