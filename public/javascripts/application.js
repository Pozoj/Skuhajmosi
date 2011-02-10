// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

String.prototype.is_empty = function() {
  return $.trim(this) == ""
}

String.prototype.debalkanize = function() {
  str = this.replace(/š/g, "ssss")
  str = str.replace(/č/g, "cccc")
  str = str.replace(/ž/g, "zzzz")
  str = str.replace(/ć/g, "csss")
  str = str.replace(/đ/g, "dzzz")
  str = str.replace(/Š/g, "SSSS")
  str = str.replace(/Č/g, "CCCC")
  str = str.replace(/Ž/g, "ZZZZ")
  str = str.replace(/Ć/g, "CSSS")
  str = str.replace(/Đ/g, "DZZZ")
  return str
}

String.prototype.rebalkanize = function() {
  str = this.replace(/ssss/g, "š")
  str = str.replace(/cccc/g, "č")
  str = str.replace(/zzzz/g, "ž")
  str = str.replace(/csss/g, "ć")
  str = str.replace(/dzzz/g, "đ")
  str = str.replace(/SSSS/g, "Š")
  str = str.replace(/CCCC/g, "Č")
  str = str.replace(/ZZZZ/g, "Ž")
  str = str.replace(/CSSS/g, "Ć")
  str = str.replace(/DZZZ/g, "Đ")
  return str
}

$(function() {
  //
  // LIMITATION ENABLERS
  //
  $(".enabler").change(function(el) {
    var $el = $(this)
    
    if ( !$el.attr("checked") )
    {
      color = "#333"
      disabled = ""
    }
    else
    {      
      color = "#ccc"
      disabled = "disabled"
    }
    
    $el.closest("fieldset").find("input").each(function(idx, input) {
      $input = $(input)
      if ( $input.attr("id") != $el.attr("id") )
      {
        $input.attr("disabled", disabled)
        
        labels = $input.parent().parent().find("label")
        labels.each(function(idx, label) {
          label = $(label)
          // If not the one marking the disables.
          if ( label.attr("for") != "campaign_disable_time_limits" && label.attr("for") != "campaign_disable_publisher_limits" && label.attr("for") != "campaign_disable_tag_limits" && label.attr("for") != "company_disable_publisher" && label.attr("for") != "company_disable_advertiser" )
            label.attr("style", "color: "+ color +";")
        })
      }
    })
  })
  $(".enabler").change()
  
  // Global thrift change host.
  $("#change_thrift_host").click(function(event) {
    if ( host = prompt("Enter new thrift server (e.g.: http://coro.doublerecall.com)") )
    {
      if ( host.is_empty() ) return false;
      location.href = $(this).attr("href") + "?host=" + host
    }
    return false;
  })
})