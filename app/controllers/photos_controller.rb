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
      flash[:notice] = "Fotografija je bila uspešno dodana."
      redirect_to @holder
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @photo = Photo.find(params[:id])
    @holder = @photo.holder
    @photo.destroy
    flash[:notice] = "Uspešno ste izbrisali fotografijo."
    
    redirect_to @holder
  end

  # def show
  #   @holder = find_holder
  #   @photo = Photo.find(params[:id])
  # end
  # 
  # def edit
  #   @photo = Photo.find(params[:id])
  # end
  # 
  # def update
  #   @photo = Photo.find(params[:id])
  #   if @photo.update_attributes(params[:photo])
  #     flash[:notice] = "Fotografija je bila uspešno posodobljena."
  #     redirect_to @photo
  #   else
  #     render :action => 'edit'
  #   end
  # end

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