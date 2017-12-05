function drawBargraph(chart, bargraph_data) {
	function sortByScore(data, score, dir){
	    if (dir == "desc"){
	        data.sort(function(a, b) { return (a[score] > b[score]) ? 1 : ((b[score] > a[score]) ? -1 : 0);} );
	    } else {
	        data.sort(function(a, b) { return (a[score] < b[score]) ? 1 : ((b[score] < a[score]) ? -1 : 0);} );
	    }
	}

	function change(score) {
	    var range0 = function(d) { return d[score]; };
	    sortByScore(bargraph_data, score, "asc");

	    if (score === "combinedScore") {
	        sortByScore(bargraph_data, score, "desc");
	        var x0 = x.domain([0, d3.max(bargraph_data, function(d) { return d[score]; })]);
	        var caption = "Combined score";
	    }
	    else if (score === "pvalue") {
	        var x0 = x.domain([0, d3.max(bargraph_data, function(d) { return -Math.log10(d[score]); })]);
	        var range0 = function(d) { return -Math.log10(d[score]); }
	        var caption = "-log₁₀(p-value)";
	    }
	    else if (score === "zscore") {
	        var x0 = x.domain([d3.max(bargraph_data, function(d) { return d[score]; }), d3.min(bargraph_data, function(d) { return d[score]; })]);
	        var caption = "Z-score"
	    }

	    var y0 = y.domain(bargraph_data.map(function(d) { return d.name; }));

	    var transition = svg.transition().duration(750),
	        delay = function(d, i) { return i * 50; };

	    transition.selectAll(".bar")
	        .attr("width", function(d) { return x0(range0(d)); })
	        .attr("y", function(d) { return y0(d.name); });

	    transition.select(".axis--x")
	        .call(d3.axisBottom(x0));

	    transition.select(".caption")
	        .text(caption);

	    transition.select(".axis--y")
	        .call(d3.axisLeft(y0).tickSize(0))
	        .selectAll("text")
	        .text(function(d) {return d.split("_")[0]});
	    
		transition.selectAll(".bar-label")
			.attr("x", function(d) { return x0(range0(d)) - 5; })
			.attr("y", function(d) { return y0(d.name) + y.bandwidth()/2; })
		    .text(function(d) {
		    	if (score === "pvalue"){ return d[score].toExponential(2); }
		    	else { return d[score].toFixed(3); }
		    	 
		    });
	}

	function onClick(chart, score){
		$("input[class*='" + chart.substr(1) +  "-']").removeClass("selected");
		change(score); 
	}
	
	sortByScore(bargraph_data, "pvalue", "asc");

	// Change buttons listeners
	var change_pvalue = $(chart + "-pvalue").on("click", function() { onClick(chart, "pvalue"); $(this).addClass("selected");});
	var change_zscore = $(chart + "-zscore").on("click", function() { onClick(chart, "zscore"); $(this).addClass("selected");});
	var change_combinedScore = $(chart + "-combinedScore").on("click", function() { onClick(chart, "combinedScore"); $(this).addClass("selected");});
	
	var svg = d3.select(chart),
	    margin = {top: 10, right: 10, bottom: 50, left: 50},
	    width = 1000 - margin.left - margin.right,
	    height = 600 - margin.top - margin.bottom;
	    
//	    width = +svg.attr("width") - margin.left - margin.right,
//	    height = +svg.attr("height") - margin.top - margin.bottom;
	var x = d3.scaleLinear().rangeRound([0, width]),
	    y = d3.scaleBand().rangeRound([height, 0]).padding(0.3);

	var g = svg.append("g")
	    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

	x.domain([0, d3.max(bargraph_data, function(d) { return -Math.log10(d.pvalue); })]);
	y.domain(bargraph_data.map(function(d) { return d.name; }));

	g.append("g")
	    .attr("class", "axis axis--x")
	    .attr("transform", "translate(0," + height + ")")
	    .call(d3.axisBottom(x));

	g.select(".axis--x")
	    .append("text")
	    .attr("class", "caption")
	    .attr("x", width/2)
	    .attr("y", margin.bottom/2)
	    .attr("dy", "0.71em")
	    .attr("font-size", "1rem")
	    .text("-log₁₀(p-value)");

	g.selectAll(".axis--x text")
    	.attr("fill", "black")
    	.attr("font-size", "1rem");
	
	g.append("g")
	    .attr("class", "axis axis--y")
	    .attr("fill", "none")
	    .call(d3.axisLeft(y).tickSize(0))
	    .selectAll("text")
	    .attr("fill", "black")
	    .attr("font-size", "1rem")
	    .text(function(d) {return d.split("_")[0]});

	g.select(".axis--y path")
		.attr("display", "none");
	
	g.selectAll(".bar")
	    .data(bargraph_data)
	    .enter()
	    .append("g")
	    .attr("class", "bar-container");
	
	g.selectAll(".bar-container")
	    .append("rect")
        .attr("class", "bar")
        .attr("x", 0)
        .attr("y", function(d) { return y(d.name); })
        .attr("width", function(d) { return x(-Math.log10(d.pvalue)); })
        .attr("height", y.bandwidth())
        .attr("fill", "#6B9BC3");
	
	g.selectAll(".bar-container")
		.append("text")
		.attr("class", "bar-label")
		.attr("text-anchor", "end")
		.attr("x", function(d) { return x(-Math.log10(d.pvalue)) - 5; })
		.attr("y", function(d) { return y(d.name) + y.bandwidth()/2; })
		.attr("dy", ".35em")
		.attr("fill", "white")
		.attr("font-size", "1rem")
	    .text(function(d) { return d["pvalue"].toExponential(2); });
}