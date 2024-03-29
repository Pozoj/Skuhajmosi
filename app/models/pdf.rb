class Pdf
  VERTICAL_SPACER = 10
  DOUBLE_VERTICAL_SPACER = 20
  H1 = 25
  H2 = 20
  H3 = 15
  NORMAL_FONT_SIZE = 13
  FONT = "#{Prawn::BASEDIR}/data/fonts/DejaVuSans.ttf"
  
  PN_FORMAT = "Stran <page> od <total>"
  PN_OPTIONS = {
    :at => [540 - 150, 0], 
    :width => 150, 
    :align => :right, 
    :page_filter => (1..7), 
    :start_count_at => 1,
    :color => "333300" 
  }
  
  
  
  class << self
    def add_page_numbers(pdf)
      pdf.number_pages "Stran <page> od <total>", [ 500, -20]
      pdf
    end
    
    def style(pdf)
      pdf.font FONT, :size => NORMAL_FONT_SIZE
      pdf
    end
    
    def image(pdf, resource, size = :medium, position = nil, vposition = nil)
      if resource.photos.any?
        if position and vposition
          pdf.image self.image_path(resource, size), :position => position, :vposition => vposition
        
        elsif position
          pdf.image self.image_path(resource, size), :position => position
          
        elsif vposition
          pdf.image self.image_path(resource, size), :vposition => vposition
        
        else
          pdf.image self.image_path(resource, size)
        end
        pdf.move_down VERTICAL_SPACER
      end
      pdf
    end
    
    def authors_image_with_name(pdf, resource, size = :small, position = :right, vposition = :top)
      pdf.text_box "Avtor recepta: #{resource}", :align => position
      if resource.photos.any?
        pdf = self.image(pdf, resource, size, position, 20)
      end
      pdf
    end
    
    def image_path(resource, size)
      File.join Rails.root, "public", resource.photos.first.photo.url(size).split('?').first
    end
    
    def h1(pdf, text) self.style_and_move_down(pdf, text, :h1) end
    def h2(pdf, text) self.style_and_move_down(pdf, text, :h2) end
    def h3(pdf, text) self.style_and_move_down(pdf, text, :h3) end
    
    def style_and_move_down(pdf, text, style)
      case style
      when :h1 then pdf.text text, :size => H1
      when :h2 then pdf.text text, :size => H2
      when :h3 then pdf.text text, :size => H3
      end
      pdf.move_down VERTICAL_SPACER
      pdf
    end
    
  end
end