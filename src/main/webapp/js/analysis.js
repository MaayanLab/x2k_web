$(function() {
	var x2k = $.parseJSON(json_file['X2K']);
	var chea = $.parseJSON(json_file['ChEA']);
	var g2n = $.parseJSON(json_file['G2N']);
	var kea = $.parseJSON(json_file['KEA']);
	var tr;
	for (var i = 0; i < chea.tfs.length; i++) {
		tr = $('<tr/>');
		tr.append("<td>" + chea.tfs[i].name + "</td>");
		tr.append("<td>" + chea.tfs[i].pvalue + "</td>");
		tr.append("<td>" + chea.tfs[i].zscore + "</td>");
		tr.append("<td>" + chea.tfs[i].combinedScore + "</td>");
		$('table').append(tr);
	};
});