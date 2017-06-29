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

	    svg.selectAll(".bar")
	        .sort(function(a, b) { return y0(a.pvalue) - y0(b.pvalue); });

	    var transition = svg.transition().duration(750),
	        delay = function(d, i) { return i * 50; };

	    transition.selectAll(".bar")
	        .delay(delay)
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
	}

	sortByScore(bargraph_data, "pvalue", "asc");

	// Change buttons listners
	var change_pvalue = $(chart + "-pvalue").on("click", function() { change('pvalue'); });
	var change_zscore = $(chart + "-zscore").on("click", function() { change('zscore'); });
	var change_combinedScore = $(chart + "-combinedScore").on("click", function() { change('combinedScore'); });
	
	var svg = d3.select(chart),
	    margin = {top: 20, right: 20, bottom: 50, left: 50},
	    width = +svg.attr("width") - margin.left - margin.right,
	    height = +svg.attr("height") - margin.top - margin.bottom;

	var x = d3.scaleLinear().rangeRound([0, width]),
	    y = d3.scaleBand().rangeRound([height, 0]).padding(0.1);

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
	    .text("-log₁₀(p-value)");


	g.append("g")
	    .attr("class", "axis axis--y")
	    .call(d3.axisLeft(y).tickSize(0))
	    .selectAll("text")
	    .text(function(d) {return d.split("_")[0]});


	g.selectAll(".bar")
	    .data(bargraph_data)
	    .enter()
	    .append("rect")
	        .attr("class", "bar")
	        .attr("x", 0)
	        .attr("y", function(d) { return y(d.name); })
	        .attr("width", function(d) { return x(-Math.log10(d.pvalue)); })
	        .attr("height", y.bandwidth());
}