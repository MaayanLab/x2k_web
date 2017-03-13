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
	
	// Draw KEA bargraph	
	function compare(a, b) {
		if (a[type] < b[type])
			return -1;
		if (a[type] > b[type])
			return 1;
		return 0;
	};

	function sortBarGraph() {
		circulate(type, sortingtypes);
		drawBarGraph();

	};
	
	data_kea = kea["kinases"];
	
	var type = "pvalue";
	data_kea.sort(compare);
	var div = d3.select("#bargraph-kea").append("div").attr("class", "toolTip");
	var axisMargin = 20,
		margin = 40,
		valueMargin = 4,
//		width = parseInt(d3.select("#bargraph-kea").style("width"), 10),
		width = 960,
//		height = parseInt(d3.select("body").style("height"), 10),
		height = 500,
		barHeight = (height - axisMargin - margin * 2) * 0.4 / data_kea.length,
		barPadding = (height - axisMargin - margin * 2) * 0.6 / data_kea.length,
		data_kea, bar, svg, scale, xAxis, labelWidth = 0;
	
	max = d3.max(data_kea, function(d) {return d["pvalue"];});
	
	svg = d3.select("#bargraph-kea").append("svg").attr("width", width).attr("height", height);
	bar = svg.selectAll("g").data(data_kea).enter().append("g");
	
	bar
		.attr("class", "bar")
		.attr("cx", 0)
		.attr("transform",
				function(d, i) {
					return "translate(" + margin + "," + (i * (barHeight + barPadding) + barPadding) + ")";
				});
	
	bar.append("text").attr("class", "label").attr("y", barHeight / 2)
			.attr("dy", ".35em") //vertical align middle
			.text(function(d) {return d["name"];})
			.each(
					function() {
						labelWidth = Math.ceil(Math.max(labelWidth, this.getBBox().width));
					});
	scale = d3.scale.linear().domain([ 0, max ]).range([0, width - margin * 2 - labelWidth]);
	xAxis = d3.svg.axis().scale(scale).tickSize(-height + 2 * margin + axisMargin).orient("bottom");
	
	bar.append("rect")
			.attr("transform", "translate(" + labelWidth + ", 0)")
			.attr("height", barHeight).attr("width", function(d) {
				return scale(d["pvalue"]);
			});
	
	bar.append("text").attr("class", "value").attr("y", barHeight / 2)
			.attr("dx", -valueMargin + labelWidth) //margin right
			.attr("dy", ".35em") //vertical align middle
			.attr("text-anchor", "end").text(function(d) {return (d["pvalue"]);})
			.attr("x", function(d) {
				var width = this.getBBox().width;
				return Math.max(width + valueMargin, scale(d["pvalue"]));
			});
	
	bar.on("mousemove", function(d) {
		div.style("left", d3.event.pageX + 10 + "px");
		div.style("top", d3.event.pageY - 25 + "px");
		div.style("display", "inline-block");
		div.html((d["name"]) + "<br>" + (d["pvalue"]));
	});
	
	bar.on("mouseout", function(d) {
		div.style("display", "none");
	});
	
	svg.insert("g", ":first-child").attr("class", "axisHorizontal").attr(
			"transform",
			"translate(" + (margin + labelWidth) + ","
					+ (height - axisMargin - margin) + ")").call(xAxis);
	
	// Draw ChEA bargraph
	// Draw KEA bargraph	

	data_chea = chea["tfs"];
	
	var type = "pvalue";
	data_chea.sort(compare);
	var div = d3.select("#bargraph-chea").append("div").attr("class", "toolTip");
	var axisMargin = 20,
		margin = 40,
		valueMargin = 4,
//		width = parseInt(d3.select("#bargraph-kea").style("width"), 10),
		width = 960,
//		height = parseInt(d3.select("body").style("height"), 10),
		height = 500,
		barHeight = (height - axisMargin - margin * 2) * 0.4 / data_chea.length,
		barPadding = (height - axisMargin - margin * 2) * 0.6 / data_chea.length,
		data_chea, bar, svg, scale, xAxis, labelWidth = 0;
	
	max = d3.max(data_chea, function(d) {return d["pvalue"];});
	
	svg = d3.select("#bargraph-chea").append("svg").attr("width", width).attr("height", height);
	bar = svg.selectAll("g").data(data_chea).enter().append("g");
	
	bar
		.attr("class", "bar")
		.attr("cx", 0)
		.attr("transform",
				function(d, i) {
					return "translate(" + margin + "," + (i * (barHeight + barPadding) + barPadding) + ")";
				});
	
	bar.append("text").attr("class", "label").attr("y", barHeight / 2)
			.attr("dy", ".35em") //vertical align middle
			.text(function(d) {return d["name"];})
			.each(
					function() {
						labelWidth = Math.ceil(Math.max(labelWidth, this.getBBox().width));
					});
	scale = d3.scale.linear().domain([ 0, max ]).range([0, width - margin * 2 - labelWidth]);
	xAxis = d3.svg.axis().scale(scale).tickSize(-height + 2 * margin + axisMargin).orient("bottom");
	
	bar.append("rect")
			.attr("transform", "translate(" + labelWidth + ", 0)")
			.attr("height", barHeight).attr("width", function(d) {
				return scale(d["pvalue"]);
			});
	
	bar.append("text").attr("class", "value").attr("y", barHeight / 2)
			.attr("dx", -valueMargin + labelWidth) //margin right
			.attr("dy", ".35em") //vertical align middle
			.attr("text-anchor", "end").text(function(d) {return (d["pvalue"]);})
			.attr("x", function(d) {
				var width = this.getBBox().width;
				return Math.max(width + valueMargin, scale(d["pvalue"]));
			});
	
	bar.on("mousemove", function(d) {
		div.style("left", d3.event.pageX + 10 + "px");
		div.style("top", d3.event.pageY - 25 + "px");
		div.style("display", "inline-block");
		div.html((d["name"]) + "<br>" + (d["pvalue"]));
	});
	
	bar.on("mouseout", function(d) {
		div.style("display", "none");
	});
	
	svg.insert("g", ":first-child").attr("class", "axisHorizontal").attr(
			"transform",
			"translate(" + (margin + labelWidth) + ","
					+ (height - axisMargin - margin) + ")").call(xAxis);
});