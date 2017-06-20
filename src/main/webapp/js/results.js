var Base64 = {
	// private property
	_keyStr : "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",

	// public method for encoding
	encode : function(input) {
		var output = "";
		var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
		var i = 0;

		input = Base64._utf8_encode(input);

		while (i < input.length) {

			chr1 = input.charCodeAt(i++);
			chr2 = input.charCodeAt(i++);
			chr3 = input.charCodeAt(i++);

			enc1 = chr1 >> 2;
			enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
			enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
			enc4 = chr3 & 63;

			if (isNaN(chr2)) {
				enc3 = enc4 = 64;
			} else if (isNaN(chr3)) {
				enc4 = 64;
			}

			output = output + this._keyStr.charAt(enc1)
					+ this._keyStr.charAt(enc2) + this._keyStr.charAt(enc3)
					+ this._keyStr.charAt(enc4);
		}

		return output;
	},

	// private method for UTF-8 encoding
	_utf8_encode : function(string) {
		string = string.replace(/\r\n/g, "\n");
		var utftext = "";

		for (var n = 0; n < string.length; n++) {

			var c = string.charCodeAt(n);
			if (c < 128) {
				utftext += String.fromCharCode(c);
			} else if ((c > 127) && (c < 2048)) {
				utftext += String.fromCharCode((c >> 6) | 192);
				utftext += String.fromCharCode((c & 63) | 128);
			} else {
				utftext += String.fromCharCode((c >> 12) | 224);
				utftext += String.fromCharCode(((c >> 6) & 63) | 128);
				utftext += String.fromCharCode((c & 63) | 128);
			}
		}

		return utftext;
	}
}

function createTable(json, container) {		
	var enriched;
	
	if (container === "#chea-table"){
		enriched = "enrichedTargets"
	}
	else{
		enriched = "enrichedSubstrates"
	}
	
	var dataArray = [];
	for (i = 0; i < json.length; i++) {
		dataArray[i] = [i, json[i]["name"], json[i]["pvalue"].toPrecision(4), json[i]["zscore"].toFixed(2),
		                json[i]["combinedScore"].toFixed(2), json[i][enriched].join(", ")];
	}	
	
    var table = $(container).DataTable( {
        data: dataArray,
        columns: [
            {},      
            {title: "Term" },
            {title: "P-value" },
            {title: "Z-score" },
            {title: "Combined score" }, 
            {}
        ],        
        "columnDefs": [{
            "targets": [5],
            "visible": false,
            "searchable": false
        	}],
        buttons: ['copy', 'excel', 'csv'],
        drawCallback: function(settings){
        	
           var api = this.api();
           
           api.rows( { page: 'current' } ).every( function () {
        	    var rowData = this.data();
        	    api.cell(this.index(), 0).node().setAttribute('title', rowData[5]);
        	  } );
           
            $('tr', api.table().container()).each(function () {
            	title = this.cells[0].title;
               $(this).attr('title', title);
            });

            $('tr', api.table().container()).tooltip({
               container: 'body'
            });  
        	
        }
    } );
    
    table.buttons().container()
    	.appendTo( $('.col-sm-5:eq(0)', table.table().container() ) );
    
    table.$('tr').tooltip();
}

function download(url, data, method) {
	if (url && data) {
		var form = document.createElement('form');
		form.setAttribute('action', url);
		form.setAttribute('method', method || 'post');

		for ( var key in data) {
			var inputField = document.createElement('input');
			inputField.setAttribute('type', 'hidden');
			inputField.setAttribute('name', key);
			inputField.setAttribute('value', data[key]);
			form.appendChild(inputField);
		}
		document.body.appendChild(form);
		form.submit();
		document.body.removeChild(form);
	}
}

function exportJson(anchor, name, export_json) {
    var data = "application/octet-stream;charset=utf-16," + encodeURIComponent(export_json);
    anchor.setAttribute("href", "data:" + data);
    anchor.setAttribute("download", name + ".json");
}

function svgExport(container, filename, outputType) {
	var b64 = $(container).html();
	b64 = b64.replace(/<br>/g, "&lt;br&gt;")
	b64 = b64.replace(/<br\/>/g, "&lt;br&gt;&#47;")
	b64 = encodeURIComponent(Base64.encode(b64));
	download('http://amp.pharm.mssm.edu/Convertr/convert', {
		filename : filename,
		outputType : outputType,
		data : b64
	});

}

$(function() {
	var tr;
	
	// Draw ChEA table
	var chea = $.parseJSON(json_file['ChEA'])["tfs"];
	createTable(chea, "#chea-table");
	
	// Draw ChEA bargraph
//	drawBargraph("#bargraph-chea", chea);
	
	// Draw KEA table
	var kea = $.parseJSON(json_file['KEA'])["kinases"];
	createTable(kea, '#kea-table');

	// Draw KEA bargraph	
//	drawBargraph("#bargraph-kea", kea);
	
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

	
	// Networks functions
	function convertX2KNode(x2k_node){ //convert the style of a node from X2K output to cytoscape
		cyto_node = {name: x2k_node["name"], group: x2k_node["type"], pvalue: x2k_node["pvalue"]}
	    return cyto_node;
	}

	function convertG2NNode(g2n_node, input_list){ //convert the style of a node from G2N output to cytoscape
	    if(input_list.indexOf(g2n_node["name"]) > -1){
	        node_class = "input_protein";
	    }
	    else{
	        node_class = "intermediate"
	    }
	    cyto_node = {name: g2n_node["name"], group: node_class};
	    return cyto_node
	}


	function containsInteraction(json_file, interaction, array){ //check if the interactions list already contains an interaction
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
	                target: network.nodes[interaction.target]["name"],
	                pvalue: network.nodes[interaction.source]["pvalue"],
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
    
    draw_network(x2k_d3_array, ".x2k-svg", "#x2k-network");
	
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
//    draw_network(g2n_d3_array, ".g2n-svg", "#g2n-network");
});