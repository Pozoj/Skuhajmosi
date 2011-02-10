function LivePreview(type_buffer) {
  if ( type_buffer )
    this.type_buffer = type_buffer
  else
    this.type_buffer = 50
  this.timeout = 0
  this.old_value = ""
  this.original_input = ""
  this.counter_id = ""
}

function integrate_image(id) {
  input_name = document.getElementById('recall_answer') ? "recall[graphic_id]" : "campaign[recalls_attributes][0][graphic_id]"
  $("#design").append($('<input type="hidden" name="'+ input_name +'" value="'+ id +'">'))
}

LivePreview.prototype.handleTyping = function(source, callback) {
  if ( this.old_value != source.val() )
  {
    this.old_value = $.trim(source.val());
    value_empty = $.trim(source.val()) == ""

    if ( this.timeout ) {
      clearTimeout(this.timeout)
      this.timeout = null
    }
  
    this.timeout = setTimeout(function() { callback(source, value_empty) }, this.type_buffer)        
  }
}

// Initialize letter counters and update them.
LivePreview.prototype.letterCounter = function(source, limit) {
  if ( !source ) return
  this.counter_id = source.attr("id") + "_counter"

  // Hide counter if length 0.
  if ( $.trim(source.val()).length == 0 )
  {
    $("#" + this.counter_id).hide()
    return
  }

  if ( !document.getElementById(this.counter_id) )
  {
    // Create counter status element, if doesnt exist.
    source.before($("<div id='"+ this.counter_id +"' class='counter'>" + I18n.t("recalls.characters_left") + " <span></span> " + I18n.t("recalls.characters") + ".</div>"))
    source.attr("maxlength", limit)
    
    // Set focus/blur events to hide/show counter.
    source.focus(function() { 
      source.parent().find(".counter").show()
      // Recalc limit on focus.
      source.parent().find(".counter span").text(limit - source.val().length)
    })
    source.blur(function() { source.parent().find(".counter").hide() })
  }

  // Always show the counter if we get this far.
  source.parent().find(".counter").show()
  // Calc the limit.
  source.parent().find(".counter span").text(limit - source.val().length)
}

LivePreview.prototype.updateAnswer = function(source, empty) {
  var original_input = source.parent().prev().find("textarea").val()
  val = source.val()
  
  // Return to default if answer empty.
  if ( empty )
  {
    $("#dr_field").val(I18n.t("recalls.words_type_in"))
    return
  }
  
  val_split = val.split(" ")
  $("#dr_field").val(val)
  
  // Skip if question is empty.
  if ( $.trim(original_input) == "" )
    return

  msg = $("#dr_message")
  
  var modified_input = original_input
  $.each(val_split, function(idx, el) {
    if ( $.trim(el) == "" ) return
    re = new RegExp("\\b("+el.debalkanize()+")\\b", "i")

    modified_input = modified_input.debalkanize().replace(re, "<strong>\$1</strong>")
    msg.html(modified_input.rebalkanize())
  })
}

$(function() {
  //
  // IMAGE UPLOAD
  //
  $('#new_graphic').load(function() { // This is an iframe, we do this on it's load.
    var frame = this.contentDocument
    var graphic_form = $("form", frame)
    
    // Activate remove image link.
    $("#graphic_remove").click(function() {
      // If we're not sure, let's rather not continue.
      if ( !confirm(I18n.t("crud.are_you_sure")) ) return false
      
      // Reload the original form, and when done, show it, remove photo, etc...
      $("#new_graphic").attr("src", "/graphics/new_iframe").load(function(event) { 
        $("#dr_logo").attr("src", "/images/preview/graphic-placeholder.png").attr("class", "no_image")
        // Hide second label.
        $('#new_graphic_label').hide()
        // Show frame.
        $(this).show()
        // Unbind this load event, we're using just this time.
        $(this).unbind(event)
      })
      $(this).hide()
    })
    
    graphic_form.uploadProgress({
      start: function() { 
        $('#new_graphic_label').show()
        $('#percents').html('0%')
        $('#progress').show()
        $('#new_graphic').hide()
      },
      uploading: function(upload) { 
        $('#percents').html(upload.percents+'%'); 
      },
      success: function(upload) { 
        $('#percents').html(I18n.t("graphics.upload.finished") + "!");
        $('#progress').hide()
        $('#graphic_remove').show()
        eval(window.frames['new_graphic'].document.body.firstChild.firstChild.nodeValue)
      },
      complete: function(upload) { 
        $('#percents').html(I18n.t("graphics.upload.processing") + "..."); 
      },
      interval: 1000
    });
    $("#graphic_image", frame).change(function() {
      graphic_form.submit()
    })
  })
  
  
})
