$(function() {
	var $head = $("head");
 var $headlinklast = $head.find('link[rel="stylesheet"]:last');
 var linkElement = '<link rel="stylesheet" href="https://web-assets.multiarray.com/email-modal/style.css" type="text/css" media="screen">';
 if ($headlinklast.length){
   $headlinklast.after(linkElement);
 }
 else {
   $head.append(linkElement);
 }
	// Email Agent Modal
	$('a.em-agent[href^=mailto]').each(function() {
	 $(this).click(function() {
	  var t;
	  var self = $(this);
	
  	$(window).blur(function() {
	   clearTimeout(t);
	  });
	
	  t = setTimeout(function() {
	   self.text(self.attr('data-email'));
  	}, 500);
 	});
	});
	// Email Friend Modal
	$('a.em-friend[href^=mailto]').each(function() {
	 $(this).click(function() {
	  var u = window.location.href;  
	  var t;
	  var self = $(this);
	
	  $(window).blur(function() {
   	clearTimeout(t);
  	});
	
	  t = setTimeout(function() {
   	$('body').append('<div class="email-modal is-visible"><div><h3>Email Friend</h3><p>Please copy and paste the URL below into your preferred email account</p> <p><input onclick="this.focus();this.select()" style="width: 100%;" value="' + u + '" /></p><button type="button">x</button></div></div>');  
  	}, 500);
 	});
	});
});
$('body').on('click', '.email-modal button', function () {
 $('.email-modal').remove();
});