$(function() {
$("li.tag a").live('click', remove_tag)
$("#tag_group_tags_form").submit(function(event) {
  value = $("#tag_group_add_tag").val()
  if ( value )
  {
    $.ajax({
      url: $(event.target).attr("action"),
      data: {'tag': value},
      dataType: 'script',
      type: 'post'
    })
  }
  event.preventDefault()
})
})

function remove_tag(event) {
  href = $(event.target).attr("href")
  $this = $(this)
  
  if ( href )
  {
    $.ajax({
      url: href,
      dataType: 'json',
      type: 'delete',
      success: function(data)
      {
        if ( data && data.success )
        {
          id = $this.parent().attr("id")
          $this.parent().remove()
          // In case there are two elements with the same ID, we can remove the second only once the first has been dealt with.
          $("#"+id).remove()
        }
        else
        {
          _Tooltip.follow()
          _Tooltip.show_delayed_with_text(I18n.t("tag_groups.remove_tag_error"))
        }
      },
      error: function() 
      {
        _Tooltip.follow()
        _Tooltip.show_delayed_with_text(I18n.t("tag_groups.remove_tag_error"))
      }
    })
  }
 
  event.preventDefault()
}