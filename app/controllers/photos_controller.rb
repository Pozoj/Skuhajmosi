class PhotosController < ApplicationController
  load_and_authorize_resource
  
  def index
    @holder = find_holder
    @photos = @holder.photos
  end

  def new
    @holder = find_holder
    @photo = Photo.new
    @photo.holder = @holder
  end

  def create
    @holder = find_holder
    @photo = @holder.photos.build(params[:photo])
    if @photo.save
      flash.now[:notice] = "Fotografija je bila uspešno dodana."
      redirect_to @holder
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @photo = Photo.find(params[:id])
    @holder = @photo.holder
    @photo.destroy
    flash.now[:notice] = "Uspešno ste izbrisali fotografijo."
    
    redirect_to @holder
  end

  private

  def find_holder
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end