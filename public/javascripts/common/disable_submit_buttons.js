$(function() {
  // This will disable all submit buttons on form submit.
  // This helps to reduce accidental double posts.
  
  $("form").submit(function(event) {
    $(event.target).find('input[type="submit"]').val(I18n.t("crud.please_wait") + "...").attr("disabled", "disabled")
  })
})