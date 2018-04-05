//
//$(window).scroll(function() {
//	var scroll = $(window).scrollTop();
//	var logo = $('#logo');
//	var caption = $('.caption');
//	if (scroll > 100) {
//		logo.addClass('shrink');
//		caption.hide();
//	} else {
//		logo.removeClass('shrink');
//		caption.show();
//	}
//});

$(function() {
    $.getJSON("static/results.json", function(json_file) {
        createResults(json_file);

        $(".tab-content").show()

        //Add smooth scrolling on all links inside the navbar
    	$("#indexScrollspy a").on('click', function(event) {
            // Make sure this.hash has a value before overriding default behavior
            if (this.hash !== "") {
  
              // Prevent default anchor click behavior
              event.preventDefault();
  
              // Store hash
              var hash = this.hash;
  
              // Using jQuery's animate() method to add smooth page scroll
              // The optional number (800) specifies the number of milliseconds it takes to scroll to the specified area
              $('html, body').animate({
                scrollTop: $(hash).offset().top
              }, 400, function(){
              // Add hash (#) to URL when done scrolling (default click behavior)
                window.location.hash = hash;
              });
            }
          });
    });
});
