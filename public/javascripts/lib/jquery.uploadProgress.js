(function($) {
  $.fn.uploadProgress = function(options) {
    options = $.extend({
      dataType: "json",
      interval: 2000,
      progressBar: "#progressbar",
      progressUrl: "/progress",
      start: function() {},
      uploading: function() {},
      complete: function() {},
      success: function() {},
      error: function() {},
      iframe: "",
      timer: ""
    }, options);
  
  return this.each(function(){
    $(this).bind('submit', function() {
      var uuid = "";
      for (i = 0; i < 32; i++) { uuid += Math.floor(Math.random() * 16).toString(16); }
      
      // update uuid 
      options.uuid = uuid;
      // start callback 
      options.start();
 
      // Patch the form-action tag to include the progress-id if X-Progress-ID has been already added just replace it 
      if(old_id = /X-Progress-ID=([^&]+)/.exec($(this).attr("action"))) {
        var action = $(this).attr("action").replace(old_id[1], uuid);
        $(this).attr("action", action);
      } else {
       $(this).attr("action", jQuery(this).attr("action") + "?X-Progress-ID=" + uuid);
       $("X-Progress-ID").val(uuid);
      }
      
      options.timer = window.setInterval(function() { jQuery.uploadProgress(this, options) }, options.interval);
    });
    });
  };
 
jQuery.uploadProgress = function(e, options) {
  jQuery.ajax({
    type: "GET",
    url: options.progressUrl + "?X-Progress-ID=" + options.uuid,
    dataType: options.dataType,
    success: function(upload) {
      if (upload.state == 'uploading') {
        upload.percents = Math.floor((upload.received / upload.size)*1000)/10;
        
        var bar = $(options.progressBar);
        bar.css({width: upload.percents+'%'});
        options.uploading(upload);
      }
      
      if (upload.state == 'done' || upload.state == 'error') {
        window.clearTimeout(options.timer);
        options.complete(upload);
      }
      
      if (upload.state == 'done') {
        options.success(upload);
      }
      
      if (upload.state == 'error') {
        options.error(upload);
      }
    }
  });
};
 
})(jQuery);
