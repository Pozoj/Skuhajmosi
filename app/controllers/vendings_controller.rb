class VendingsController < ApplicationController
  def index
    authorize!(:manage, Parsing)
  end
  
  def create
    if parsing = Parsing.create( params[:process_xml_vending] )
      xml_file = Rails.root.join("public/system/parsings/#{parsing.id}/#{parsing.xml.original_filename}")
      if Parsah.workit(xml_file)
        redirect_to(vendings_path, :notice => "Poslali ste veljavno xml datoteko in uspešno je bila sprejeta")
      else
        redirect_to(vendings_path, :alert => "Poslali ste neveljavno xml datoteko. Podatki niso bili posredovani")
      end  
    end
    authorize!( :manage, Parsing)
  end
end
