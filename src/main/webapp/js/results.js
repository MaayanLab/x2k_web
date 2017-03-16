$(function() {
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
	
	// Networks functions
	function convertX2KNode(x2k_node){ //convert the style of a node from X2K output to cytoscape
		cyto_node = {data: {name: x2k_node["name"].split('_')[0],
	        id: x2k_node["name"]},
	        classes: x2k_node["type"]}
	    return cyto_node;

	}

	function convertG2NNode(g2n_node, input_list){ //convert the style of a node from G2N output to cytoscape
	    if(input_list.indexOf(g2n_node["name"]) > -1){
	        node_class = "input_protein";
	    }
	    else{
	        node_class = "intermediate"
	    }
	    cyto_node = {data: {name: g2n_node["name"].split('_')[0],
	                        id: g2n_node["name"]},
	                 classes: node_class}
	    return cyto_node
	}


	function containsInteraction(json_file, interaction, array){ //check if the interacitons list already contains an interaciton
	    //used against duplicates
	    for(y = 0; y < array.length; y++){
	        a = array[y];
	        source_a = a.data.source;
	        target_a = a.data.target;
	        source_b = json_file.network.nodes[interaction.source].name;
	        target_b = json_file.network.nodes[interaction.target].name;
	        if((source_a == source_b && target_a == target_b) ||
	            source_a == target_b && target_a == source_b){
	            return true;
	        }
	    }
	    return false;
	}

	//clean up a network - remove unused nodes, remove duplicate interactions, self-loops
	function cleanNetwork(json_file, network){
	    clean_interactions = [];
	    connected_nodes = [];
	    for(i = 0; i < network.interactions.length; i++){
	        interaction = network.interactions[i];
	        if(!containsInteraction(json_file, interaction, clean_interactions) && interaction.target != interaction.source) {
	            cyto_interaction = {data: {
	                source: network.nodes[interaction.source]["name"],
	                target: network.nodes[interaction.target]["name"]
	            }};
	            clean_interactions.push(cyto_interaction);
	            connected_nodes.push(interaction.source);
	            connected_nodes.push(interaction.target);
	        }
	    }
	    clean_nodes = [];
	    for(i = 0; i < network.nodes.length; i++){
	        if(connected_nodes.indexOf(i) > -1){
	            clean_nodes.push(network.nodes[i]);
	        }
	    }
	    return [clean_interactions, clean_nodes];
	}
	
	// X2K Processing
	var x2k = $.parseJSON(json_file["X2K"]);
    network = x2k.network;
    clean_network = cleanNetwork(x2k, network);
    clean_nodes = clean_network[1];
    clean_interactions = clean_network[0];
    
    network_string = JSON.stringify(network);
    tf_string = JSON.stringify(x2k.transcriptionFactors);
    kinase_string = JSON.stringify(x2k.kinases);
    cytoscape_array = {"nodes": [], "interactions": []};

    for(i = 0; i < clean_nodes.length; i++){
        cytoscape_array["nodes"].push(convertX2KNode(clean_nodes[i]));
    }
    for(i = 0; i < clean_interactions.length; i++){
        cytoscape_array["interactions"].push(clean_interactions[i]);
    }

    console.log(cytoscape_array);
	
	// G2N Processing
    var g2n = $.parseJSON(json_file["G2N"]);
    network = g2n.network;
    clean_network = cleanNetwork(g2n, network);
    clean_nodes = clean_network[1];
    clean_interactions = clean_network[0];

    input_list = [];
    for(i = 0; i < g2n.input_list.length; i++) input_list.push(g2n.input_list[i].toUpperCase());
    cytoscape_array = {"nodes": [], "interactions": []};
    for(i = 0; i < clean_nodes.length; i++){
        cytoscape_array["nodes"].push(convertG2NNode(clean_nodes[i],input_list));
    }
    for(i = 0; i < clean_interactions.length; i++){
        cytoscape_array["interactions"].push(clean_interactions[i]);
    }

    network_string = JSON.stringify(network);
    console.log(cytoscape_array);
});