
  $(document).ready(function() {
      $('#asset_photo').click(function(event){ 
        event.preventDefault();
        }); 
      $('#asset_photo').uploadify({
        'uploader'  : '/javascripts/uploadify/uploadify.swf', 
        'script'    : '/assets/create', 
        'multi'     : true, 
        'auto'      : true,
        'buttonText': 'Upload Photos',
        'cancelImg' : '/images/cancel.png',
        onComplete : function(event, queueID, fileObj, response, data) { var dat = eval('(' + response + ')');$.getScript(dat.asset);},
        'scriptData': { '<%= session_key_name %>' : encodeURIComponent('<%= u cookies[session_key_name] %>'), 
        'authenticity_token' : encodeURIComponent('<%= u form_authenticity_token if protect_against_forgery? %>'),
        'album_id' : '<%= @album.id %>',
        'format'  : 'json' }
        });
      $('#asset_submit').click(function(event){ 
        event.preventDefault(); 
        $('#asset_photo').uploadifyUpload(); 
        });
        /*
      $(window).keypress(function(event) {
        if (event.keyCode == '39') {
          alert('Right Arrow');
        } else if (event.keyCode == '37') {
          alert('Left Arrow');
        }
      });
        */
  }); 
  
  TopUp.images_path = "/images/top_up/";
  TopUp.addPresets({
      "#asset_list a": {
        title: "Gallery {alt} ({current} of {total})",
        group: "asset_group",
        readAltText: 0,
        effect: "switch",
        overlayClose: 1,
        resizable: 1,
        layout: "flatlook",
        shaded: 1
      }
  });
  
  function slideSwitch(direction) {

      var $active = $('#asset_list DIV.active');

      if ( $active.length == 0 ) $active = $('#asset_list DIV:last');

      var $next;
      if (direction == '37')
        $next =  $active.prev().length ? $active.prev() : $('#asset_list DIV:last');
      else     
        $next =  $active.next().length ? $active.next() : $('#asset_list DIV:first');

      $active.addClass('last-active');

      $next.css({opacity: 0.0})
          .addClass('active')
          .animate({opacity: 1.0}, 1000, function() {
              $active.removeClass('active last-active');
          });
  }
/*
  jQuery.ajaxSetup({
      'beforeSend': function(xhr) {xhr.setRequestHeader("Accept","text/javascript")}
  })
  
  $(window).keypress(function(event) {
      $.post('<%= albums_path action='index' %>', null, null, "script");
      return false;
  });
  */
  
