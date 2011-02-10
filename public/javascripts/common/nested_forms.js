function remove_fields(link) {
  if ( confirm(I18n.t("crud.are_you_sure")) )
  {
    $(link).parent().parent().find(".hidden input").val("1");
    $(link).parent().parent().animate({opacity: 'hide'}, 'slow');
  }
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().parent().append(content.replace(regexp, new_id));
  hook = "#company_"+ association +"_attributes_new_"+ association +"__destroy_input"; // Setup this hook, because regexps are evaluated before interpolation.
  $(hook.replace(regexp, new_id)).parent().parent().effect("highlight", {}, 1250)
}