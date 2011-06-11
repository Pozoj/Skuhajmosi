pdf = Pdf.style(pdf)

for resource in collection
  
  pdf = Pdf.h1 pdf, resource.to_s
  
  pdf = Pdf.authors_image_with_name(pdf, resource.author)
  pdf.move_down Pdf::VERTICAL_SPACER * 3

  pdf = Pdf.h2 pdf, "Info"
  
  if resource.num_people.present?
    pdf.text "Število oseb: #{resource.num_people}"
  end

  if resource.ingredients.any?
    pdf.text "Sestavine: #{ingredients_text_list(resource)}"
  end

  if resource.time_to_prepare.present?
    pdf.text "Čas priprave: #{distance_of_time_in_words(resource.time_to_prepare.minutes)}"
  end

  if resource.time_to_cook.present?
    pdf.text "Čas kuhanja: #{distance_of_time_in_words(resource.time_to_cook.minutes)}"
  end

  if resource.recipe_kinds.any?
    #pdf.text "Vrste receptov: #{pdf_links_to_recipe_kinds(resource)}", :inline_format => true
    pdf.text "Vrsta kuhinje: #{resource.recipe_kinds.join(', ')}"
  end

  pdf.move_down Pdf::VERTICAL_SPACER
  
  if resource.summary.present?
    pdf = Pdf.h3 pdf, "Povzetek"
    pdf.text resource.summary
  end

  pdf.move_down Pdf::VERTICAL_SPACER

  if resource.preparation.present?
    pdf = Pdf.h3 pdf, "Priprava"
    pdf.text resource.preparation
  end

  pdf.move_down Pdf::VERTICAL_SPACER

  if resource.suggestion.present?
    pdf = Pdf.h3 pdf, "Sugestije"
    pdf.text resource.suggestion
  end
  
  pdf = Pdf.image(pdf, resource, :big, :center, :center)
  
  pdf.start_new_page if resource != collection.last
end

pdf = Pdf.add_page_numbers(pdf)