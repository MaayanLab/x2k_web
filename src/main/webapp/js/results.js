function exportJson(anchor, name, export_json) {
    var data = "application/octet-stream;charset=utf-16," + encodeURIComponent(export_json);
    anchor.setAttribute("href", "data:" + data);
    anchor.setAttribute("download", name + ".json");
}

$(function() {
	var tr;
	
	// Draw ChEA table
	var chea = $.parseJSON(json_file['ChEA']);
	for (var i = 0; i < chea.tfs.length; i++) {
		tr = $('<tr/>');
		tr.append("<td>" + chea.tfs[i].name.replace(/_/g, " ") + "</td>");		
		if (chea.tfs[i].pvalue < 0.01) {
			pval = chea.tfs[i].pvalue.toExponential(3);
		}
		else{
			pval = chea.tfs[i].pvalue.toFixed(3);
		};
		tr.append("<td>" + pval + "</td>");
		tr.append("<td>" + chea.tfs[i].zscore.toFixed(3) + "</td>");
		tr.append("<td>" + chea.tfs[i].combinedScore.toFixed(3) + "</td>");
		$('#chea-table').append(tr);
	};

	// Draw KEA table
	var kea = $.parseJSON(json_file['KEA']);
	for (var i = 0; i < kea.kinases.length; i++) {
		tr = $('<tr/>');
		tr.append("<td>" + kea.kinases[i].name.replace(/_/g, " ") + "</td>");
		if (kea.kinases[i].pvalue < 0.01){
			pval = kea.kinases[i].pvalue.toExponential(3);
		}
		else{
			pval = kea.kinases[i].pvalue.toFixed(3);
		};
		tr.append("<td>" + pval + "</td>");
		tr.append("<td>" + kea.kinases[i].zscore.toFixed(3) + "</td>");
		tr.append("<td>" + kea.kinases[i].combinedScore.toFixed(3) + "</td>");
		$('#kea-table').append(tr);
	};
	
	// Dashboard buttons
	$("button[id*='button']").click(function() {
		id = $(this).attr("id").split("-")[0];
		if (id !== "download"){
			$("div[id*='tabs']").hide();
			$("div#tabs-" + id).show();
		}
	});

	$('button').on('click', function() {
		$('button').removeClass('selected');
		$(this).addClass('selected');
	});

	// Dashboard tabs
	$("div[id*='tabs']").tabs();
	
	// Draw KEA bargraph	
	drawBargraph("#bargraph-kea", kea["kinases"]);
	// Draw ChEA bargraph
	data_chea = chea["tfs"];
	drawBargraph("#bargraph-chea", chea["tfs"])
	// Networks functions
	function convertX2KNode(x2k_node){ //convert the style of a node from X2K output to cytoscape
		cyto_node = {id: x2k_node["name"], group: x2k_node["type"]}
	    return cyto_node;
	}

	function convertG2NNode(g2n_node, input_list){ //convert the style of a node from G2N output to cytoscape
	    if(input_list.indexOf(g2n_node["name"]) > -1){
	        node_class = "input_protein";
	    }
	    else{
	        node_class = "intermediate"
	    }
	    cyto_node = {id: g2n_node["name"], group: node_class};
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
    x2k_d3_array = {"nodes": [], "links": []};

    for(i = 0; i < clean_nodes.length; i++){
    	x2k_d3_array["nodes"].push(convertX2KNode(clean_nodes[i]));
    }
    for(i = 0; i < clean_interactions.length; i++){
    	x2k_d3_array["links"].push(clean_interactions[i]);
    }
    
    draw_network(x2k_d3_array, "#x2k-network");
	
	// G2N Processing
    var g2n = $.parseJSON(json_file["G2N"]);
    network = g2n.network;
    clean_network = cleanNetwork(g2n, network);
    clean_nodes = clean_network[1];
    clean_interactions = clean_network[0];

    input_list = [];
    for(i = 0; i < g2n.input_list.length; i++) input_list.push(g2n.input_list[i].toUpperCase());
    g2n_d3_array = {"nodes": [], "links": []};
    for(i = 0; i < clean_nodes.length; i++){
    	g2n_d3_array["nodes"].push(convertG2NNode(clean_nodes[i], input_list));
    }
    for(i = 0; i < clean_interactions.length; i++){
    	g2n_d3_array["links"].push(clean_interactions[i]);
    }
    
    network_string = JSON.stringify(network);
    draw_network(g2n_d3_array, "#network-g2n");
});