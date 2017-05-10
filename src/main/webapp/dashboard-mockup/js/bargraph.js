$(document).ready(function() {
	data = [
			{
				"name" : "CDK5",
				"pvalue" : 4.1089403232349536E-4,
				"zscore" : -2.071791427191609,
				"combinedScore" : 16.154120747290097,
				"enrichedSubstrates" : [ "NR3C1", "CDK5RAP1", "TLN1",
						"STXBP2", "KALRN", "SIPA1L1", "CABLES1" ]
			},
			{
				"name" : "MAPK10",
				"pvalue" : 0.020638231834273078,
				"zscore" : -1.9350437687825957,
				"combinedScore" : 7.5091502169570195,
				"enrichedSubstrates" : [ "NR3C1", "LIFR", "RBM39",
						"NAP1L1", "RPS6KB1" ]
			},
			{
				"name" : "PDPK1",
				"pvalue" : 0.025965526172490958,
				"zscore" : -1.9089208780487765,
				"combinedScore" : 6.969442517431054,
				"enrichedSubstrates" : [ "PRKACA", "CDAN1", "RPS6KB1" ]
			},
			{
				"name" : "PDK1",
				"pvalue" : 0.06452198221675895,
				"zscore" : -1.6612098008593776,
				"combinedScore" : 4.5529596049727985,
				"enrichedSubstrates" : [ "PRKACA", "RPS6KB1" ]
			},
			{
				"name" : "TRIM24",
				"pvalue" : 0.12591260931125214,
				"zscore" : -1.4096780795523849,
				"combinedScore" : 2.92108866429211,
				"enrichedSubstrates" : [ "NR3C1", "EXOSC4", "CRADD" ]
			},
			{
				"name" : "ATM",
				"pvalue" : 0.19399375234783794,
				"zscore" : -1.5214506950391264,
				"combinedScore" : 2.495071611077602,
				"enrichedSubstrates" : [ "NR3C1", "USP34", "CAT", "KLF1" ]
			},
			{
				"name" : "FYN",
				"pvalue" : 0.30181334991368114,
				"zscore" : -0.7641789369572446,
				"combinedScore" : 0.9154454823822123,
				"enrichedSubstrates" : [ "KDR", "SF1", "CD55", "NR3C1" ]
			},
			{
				"name" : "UHMK1",
				"pvalue" : 0.16326563430898777,
				"zscore" : -0.44622781397378514,
				"combinedScore" : 0.8087329135940245,
				"enrichedSubstrates" : [ "SF1" ]
			},
			{
				"name" : "FLT4",
				"pvalue" : 0.15252877740404056,
				"zscore" : -0.38522374619872457,
				"combinedScore" : 0.724375501431373,
				"enrichedSubstrates" : [ "KDR" ]
			},
			{
				"name" : "PRKDC",
				"pvalue" : 0.33374976102038123,
				"zscore" : -0.6511085574426748,
				"combinedScore" : 0.7145029512441574,
				"enrichedSubstrates" : [ "NR3C1", "C1D", "KLF1", "RPS6KB1" ]
			} ];

	function circulate(sortingtypes) {
		for (var i = 0, len = sortingtypes.length; i < len; i++) {
			sortingtypes.push(sortingtypes.shift());
		}
		type = sortingtypes[0];
	};

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
	
	var type = "pvalue";
	data.sort(compare);
	var div = d3.select("#bargraph-kea").append("div").attr("class", "toolTip");
	var axisMargin = 20,
		margin = 40,
		valueMargin = 4,
		width = parseInt(d3.select("#bargraph-kea").style("width"), 10),
		height = parseInt(d3.select("body").style("height"), 10),
		barHeight = (height - axisMargin - margin * 2) * 0.4 / data.length,
		barPadding = (height - axisMargin - margin * 2) * 0.6 / data.length,
		data, bar, svg, scale, xAxis, labelWidth = 0;
	
	max = d3.max(data, function(d) {return d["pvalue"];});
	svg = d3.select("#bargraph-kea").append("svg").attr("width", width).attr("height", height);
	bar = svg.selectAll("g").data(data).enter().append("g");
	
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
					function(d) {
						
						labelWidth = Math.ceil(Math.max(labelWidth, this.getBBox().width));
						console.log(this.getBBox().width/d["name"].length);
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