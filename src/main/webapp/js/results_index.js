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

        $(".tab-content").show();

        //Add smooth scrolling on all links inside the navbar
    	$("#scrollspy-nav a").on('click', function(event) {
        let hash = $(this).attr('href');
        event.preventDefault();
        event.stopPropagation();

        $('html, body').animate({
          scrollTop: $(hash).offset().top
        }, 400, function() {
        // Add hash (#) to URL when done scrolling (default click behavior)
          window.location.hash = hash;
        });
    });
  })
});