$(function() {
	var x2k = $.parseJSON(json_file['X2K']);
	var g2n = $.parseJSON(json_file['G2N']);

	var tr;
	
	// Draw ChEA table
	var chea = $.parseJSON(json_file['ChEA']);
	for (var i = 0; i < chea.tfs.length; i++) {
		tr = $('<tr/>');
		tr.append("<td>" + chea.tfs[i].name + "</td>");
		tr.append("<td>" + chea.tfs[i].pvalue + "</td>");
		tr.append("<td>" + chea.tfs[i].zscore + "</td>");
		tr.append("<td>" + chea.tfs[i].combinedScore + "</td>");
		$('#chea-table').append(tr);
	};

	// Draw KEA table
	var kea = $.parseJSON(json_file['KEA']);
	for (var i = 0; i < kea.kinases.length; i++) {
		tr = $('<tr/>');
		tr.append("<td>" + kea.kinases[i].name + "</td>");
		tr.append("<td>" + kea.kinases[i].pvalue + "</td>");
		tr.append("<td>" + kea.kinases[i].zscore + "</td>");
		tr.append("<td>" + kea.kinases[i].combinedScore + "</td>");
		$('#kea-table').append(tr);
	};
	
	// Dashboard buttons
	$("button[id*='button']").click(function() {
		id = $(this).attr("id").split("-")[0];
		$("div[id*='tabs']").hide();
		$("div#tabs-" + id).show();
	});

	$('button').on('click', function() {
		$('button').removeClass('selected');
		$(this).addClass('selected');
	});

	// Dashboard tabs
	$("div[id*='tabs']").tabs();

});