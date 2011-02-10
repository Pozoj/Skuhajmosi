$(function(){ 
    $(".activation a").click(function(event){
        var target = $(this)
        // console.log(target.get(0))
        var enabled = $(".cb-enable", target).hasClass('selected')
        
        $.ajax({
          url: target.attr('href'),
          dataType: 'json',
          success: function(data) {
            if ( data )
            {
              if ( data.status && data.reverse_url )
              {
                // Toggle body.
                if ( !$('body').hasClass('activated') )
                  $('body').addClass('activated')
                
                // Switch parent URL.
                target.attr('href', data.reverse_url)
                
                // Switch state.
                if ( enabled )
                {
                  $('.cb-enable', target).removeClass('selected');
                  $('.cb-disable', target).addClass('selected');
                }
                else
                {
                  $('.cb-disable', target).removeClass('selected');
                  $('.cb-enable', target).addClass('selected');
                }
              }
            }
          },
          error: function() {
            _Tooltip.follow()
            _Tooltip.show_delayed_with_text(I18n.t("activation_error"))
          }
        })
        
        event.stopPropagation()
        event.preventDefault()
    });
});