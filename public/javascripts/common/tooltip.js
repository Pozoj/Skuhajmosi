var _Tooltip = {
  tip: null,
  should_follow: false,
  spinner: false,
  
  init: function() {
    this.tip = $("#tooltip")
    if ( !this.tip ) return false
    
    // Hide initially.
    this.hide()
    
    // Setup global AJAX handlers.
    this.tip.ajaxComplete(function() {
      _Tooltip.hide_spinner()
      _Tooltip.dont_follow()
      _Tooltip.hide()
    })
    this.tip.ajaxStart(function() {
      _Tooltip.show_spinner()
      _Tooltip.follow()
      _Tooltip.show_with_text(I18n.t("crud.please_wait"))
    })
    
    // Pointer tracker.
    $(document).mousemove(function(e){
      if ( _Tooltip.should_follow )
      {
        _Tooltip.tip.css({
          top: (e.pageY + 15) + "px",
          left: (e.pageX + 15) + "px"
        })
      }
      else {
        _Tooltip.tip.css({
          top: "0px",
          right: "0px"
        })
      }
    })
  },
  text: function(str) {
    this.tip.find("#tip").text(str)
  },
  show: function() {
    this.tip.show()
  },
  hide: function() {
    this.tip.hide()
  },
  show_with_text: function(str) {
    this.text(str)
    this.show()
  },
  show_delayed_with_text: function(str, timeout) {
    this.hide_spinner()
    this.show_with_text(str)
    timeout = timeout ? timeout : 3500
    setTimeout(function() { _Tooltip.hide() }, timeout)
  },
  follow: function() {
    this.should_follow = true
  },
  dont_follow: function() {
    this.should_follow = false
  },
  show_spinner: function() {
    this.spinner = true
    this.tip.find("#spinner").show()
  },
  hide_spinner: function() {
    this.spinner = false
    this.tip.find("#spinner").hide()
  }
}

$(function() {
  _Tooltip.init()
  _Tooltip.dont_follow()
})