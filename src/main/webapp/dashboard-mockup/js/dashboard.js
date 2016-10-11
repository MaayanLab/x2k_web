$(document).ready(function() {

	// buttons
	$("button[id*='button']").click(function() {
		id = $(this).attr("id").split("-")[0];
		$("div[id*='tabs']").hide();
		$("div#tabs-" + id).show();
	});

	$('button').on('click', function() {
		$('button').removeClass('selected');
		$(this).addClass('selected');
	});

	// tabs
	$("div[id*='tabs']").tabs();
});