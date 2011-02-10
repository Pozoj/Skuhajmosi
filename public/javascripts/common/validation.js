function ValidationResult(status, message) {
  this.status = status
  this.message = message
}

Validation.prototype.validate = function(type_of_validation) {
  if ( type_of_validation == 'required' )
  {
    // Validate that field not empty.
    if ( this.field.is("textarea") || (this.field.is("input") && (this.field.attr("type") == "text" || this.field.attr("type") == "url")) )
      if ( this.field.val().is_empty() )
        return this.displayError(new ValidationResult(false, I18n.t("errors.messages.empty")))
  }
  
  return true
}

function hideError(parent) {
  parent.removeClass("error")
  parent.children(".inline-errors").remove()
}

Validation.prototype.displayError = function(result) {
  var parent = this.field.parent()
  
  // Always try to hide before displaying again.
  hideError(parent)
  
  // Display.
  parent.addClass("error")
  parent.append($("<p class='inline-errors'>" + result.message + "</p>"))
  
  this.field.focus(function(event) {
    hideError(parent)
    // Unbind this focus event, we're using it just this time.
    $(this).unbind(event)
  })
  this.field.keyup(function(event) {
    hideError(parent)
    // Unbind this keyup event, we're using it just this time.
    $(this).unbind(event)
  })
  
  
  return result.status
}

function Validation(field_selector) {
  // Initialize.
  this.field = $(field_selector)
  // If the field doesn't exist, exit.
  if ( !this.field || this.field.val.constructor != Function || this.field.val() == 'undefined' ) return false
}

// On page load.
$(function() {
  // This will remove error notification on fields that were marked invalid server-side.
  $(".error input").focus(function(event) {
    hideError($(event.target).parent())
    // Unbind this focus event, we're using it just this time.
    $(this).unbind(event)
  })
})