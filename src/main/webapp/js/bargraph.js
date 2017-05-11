function drawBargraph(tab, data) {
		
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
//	var div = d3.select(tab).append("div").attr("class", "toolTip");
	var axisMargin = 20,
		margin = 40,
		valueMargin = 4,
		width = 960,
		height = 500,
		barHeight = (height - axisMargin - margin * 2) * 0.4 / data.length,
		barPadding = (height - axisMargin - margin * 2) * 0.6 / data.length,
		data, bar, svg, scale, xAxis, labelWidth = 0;
	
	max = d3.max(data, function(d) {return -1*Math.log10(d["pvalue"]);});
	svg = d3.select(tab).append("svg").attr("width", width).attr("height", height);
	
	svg.append("text")
	    .attr("text-anchor", "middle")
	    .attr("transform", "translate("+ (width/2) +","+(height-10)+")")
	    .text("-log10(p-value)");
	
	bar = svg.selectAll("g").data(data).enter().append("g");
	
	bar.attr("class", "bar")
		.attr("cx", 0)
		.attr("transform",
				function(d, i) {
					return "translate(" + margin + "," + (i * (barHeight + barPadding) + barPadding) + ")";
				});
	
	bar.append("text").attr("class", "label").attr("y", barHeight / 2)
			.attr("dy", ".35em")
			.text(function(d) {return d["name"];})
			.each(
					function(d) {
						// i stands for "dirty hack"
						// For some reason this.getBBox().width returns 0
						// But label length in pixels to label length in characters ratio is about 7.5-8						
						var i = 7.5;
						if (tab =="#bargraph-kea"){i = 8;}
						
						labelWidth = Math.ceil(Math.max(labelWidth, d["name"].length*i));
					});
	// Left margin for labels	
	labelWidth = labelWidth + 5; 
	
	scale = d3.scale.linear().domain([ 0, max ]).range([0, width - margin * 2 - labelWidth]);
	xAxis = d3.svg.axis().scale(scale).tickSize(-height + 2 * margin + axisMargin).orient("bottom");
	
	bar.append("rect")
			.attr("transform", "translate(" + labelWidth + ", 0)")
			.attr("height", barHeight).attr("width", function(d) {
				return scale(-1*Math.log10(d["pvalue"]));
			});
	
	bar.append("text").attr("class", "value").attr("y", barHeight / 2)
			.attr("dx", -valueMargin + labelWidth) //margin right
			.attr("dy", ".35em") //vertical align middle
			.attr("text-anchor", "end").text(function(d) {
				if (d["pvalue"] < 0.01) {
					return d["pvalue"].toExponential(3);
				}
				else{
					return d["pvalue"].toFixed(3);
				};})
			.attr("x", function(d) {
				var width = this.getBBox().width;
				return Math.max(width + valueMargin, scale(-1*Math.log10(d["pvalue"])));
			});
	
//	bar.on("mousemove", function(d) {
//		div.style("left", d3.event.pageX + 10 + "px");
//		div.style("top", d3.event.pageY - 25 + "px");
//		div.style("display", "inline-block");
//		div.html((d["name"]) + "<br>" + (d["pvalue"]));
//	});
//	
//	bar.on("mouseout", function(d) {
//		div.style("display", "none");
//	});
	
	svg.insert("g", ":first-child").attr("class", "axisHorizontal").attr(
			"transform",
			"translate(" + (margin + labelWidth) + ","
					+ (height - axisMargin - margin) + ")").call(xAxis);
}