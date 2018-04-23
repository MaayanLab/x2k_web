var saveSvgAsPng = require('save-svg-as-png');

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
};

function sendToEnrichr(button) {
	// Get genes
	var genes = Object.values($(button).parents('.popover').find('.enriched-gene-link').map(function(index, elem){ return $(elem).text() }));

	// Create Form
	var $form = $('<form>', {'method': 'post', 'action': 'https://amp.pharm.mssm.edu/Enrichr/enrich', 'target': '_blank', 'enctype': 'multipart/form-data'})
					.append($('<input>', {'type': 'hidden', 'name': 'list', 'value': genes.join('\n')}))
					.append($('<input>', {'type': 'hidden', 'name': 'description', 'value': 'Enriched '+$(button).parents('.popover').find('b').first().text()+' targets from X2K'}))
	
	// Submit
	$(button).parents('.popover').append($form);
	$form.submit();
	$form.remove();
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
    for (var i = 0; i < json.length; i++) {

        // Get first column
        var splitName = json[i]["name"].split(/[-_]/),
            firstCol = $('<div>').html($('<a>', {'href': 'http://amp.pharm.mssm.edu/Harmonizome/gene/'+splitName[0], 'target': '_blank'}).html(splitName[0])),
            targetSource = '';
        if (splitName.length > 1) {
            targetSource = $('<div>', {'class': 'my-2'})
                .append('Associations were determined from the following experiment:')
                .append($('<ul>', {'class': 'mb-0'})
                        .append($('<li>').html('<b>Assay</b>: '+splitName[2]))
                        .append($('<li>').html('<b>Organism</b>: '+splitName[4]))
                        .append($('<li>').html('<b>Cell Type</b>: '+splitName[3]))
                        .append($('<li>').html('<b>PubMed ID</b>: <a href="https://www.ncbi.nlm.nih.gov/pubmed/'+splitName[1]+'" target="_blank">'+splitName[1]+'</a>'))
                ).prop('outerHTML');
        }

        // Links to enriched genes
        var enrichedLinks = [];
        $.each(json[i][enriched], function(index, gene) {
            enrichedLinks.push('<a class="enriched-gene-link" href="http://amp.pharm.mssm.edu/Harmonizome/gene/'+gene+'" target="_blank">'+gene+'</a>');
        });

        // Data Array
        dataArray[i] = [i+1,
            firstCol.prop('outerHTML'),
            json[i]["pvalue"].toPrecision(4),
            json[i]["zscore"].toFixed(2),
            json[i]["combinedScore"].toFixed(2),
            $('<div>', {
                    'class': 'enrichment-popover-button',
                    'data-toggle': 'popover',
                    'data-placement': 'left',
                    'data-html': 'true',
                    'data-template': '<div class="popover enrichment-popover" role="tooltip"><div class="arrow"></div><h3 class="popover-header"></h3><div class="popover-body"></div></div>',
					'title': enriched.replace('enriched', 'Overlapping <button class="float-right enrichr-button" onclick="sendToEnrichr(this, event);">En<span class="red">rich</span>r<i class="fas fa-external-link-alt ml-1"></i></button>'),
                    'data-content': '<b>'+json[i]["name"].split(/[-_]/)[0]+'</b> targets <span class="font-italic">'+json[i][enriched].length+' genes</span> from the input gene list.<br>'+targetSource+'<div class="my-1">The full list of '+enriched.replace('enriched', '').toLowerCase()+' is available below:</div>'+enrichedLinks.join(" ")
                })
                .css('cursor', 'pointer')
                .css('text-decoration', 'underline')
                .css('text-decoration-style', 'dotted')
                .append(json[i][enriched].length+' '+enriched.replace('enriched', '').toLowerCase())
                .prop('outerHTML')
        ];
    }

    $(container).DataTable( {
        width: '100%',
        data: dataArray,
        responsive: true,
        columns: [
            {title: "Rank"},
            {title: enriched.indexOf('Targets') > -1 ? 'Transcription Factor' : 'Protein Kinase' },
            {title: "Hypergeometric p-value" },
            {title: "Z-score" },
            {title: "Combined score" },
            {title: enriched.replace('enriched', 'Enriched ')}
        ],
        dom: 'B<"small"f>rt<"small row"ip>',
        buttons: [
            'copy',
            {
				extend: 'excel',
				exportOptions: {
					columns: [0, 1, 2, 3, 4]
				}
			},
            'csv',
            {
				extend: 'print',
				exportOptions: {
					columns: [0, 1, 2, 3, 4]
				}
			}
        ],
        columnDefs: [
            { sortable: false, targets: 5 },
            // Sorting removed temporarily
            {
                targets: [ 3, 4 ],
                visible: false,
                searchable: false,
            },
        ],
        drawCallback: function(){

			// Enriched gene popover
            $('.enrichment-popover-button').popover();
            $('.enrichment-popover-button').on('click', function () {
                $('.enrichment-popover-button').not(this).popover('hide');
			});
			
        }
    } );
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

function downloadUri(uri, filename) {
	var downloadAnchorNode = document.createElement('a');
	downloadAnchorNode.setAttribute("href", uri);
	downloadAnchorNode.setAttribute("download", filename);
	downloadAnchorNode.click();
	downloadAnchorNode.remove();
}

function downloadObj(obj, filename, fmt) {
	if(fmt === undefined)
		fmt = "application/octet-stream";
	downloadUri("data:"+fmt+";charset=utf-8," + encodeURIComponent(obj), filename);
}

function exportJson(name, export_json) {
	downloadObj(JSON.stringify(export_json), name + ".json");
}

function recordsToColData(records) {
	return {
		columns: Object.keys(records[0]),
		data: records.map(function(record) {
			return Object.keys(record).map(function(key) {
				return record[key]
			})
		}),
	}
}

function recordsToCsv(records) {
	var col_data = recordsToColData(records)
	return [col_data.columns].concat(col_data.data).map(function(row) {
		return row.join(',')
	}).join('\n')
}

function exportCsv(name, export_json) {
	var str;

	if(name ==="X2K") {
	    var tfs = typeof objArray !== 'object' ? export_json["transcriptionFactors"] : objArray;
	    var kinases = typeof objArray !== 'object' ? export_json["kinases"] : objArray;
	    var array = tfs.concat(kinases);
	    
    
	    str = "Name,Simple name,P-value,Z-score,Combined score,Targets\n";
	
	    for (var i = 0; i < array.length; i++) {
	        var line = '';
	        for (var index in array[i]) {
	            if (line !== '') line += ',';
	
	            line += array[i][index];
	        }
	
	        str += line + '\r\n';
	    }
	} else if(name === 'G2N') {
		var array = typeof objArray !== 'object' ? export_json["network"] : objArray;
		var nodes = array["nodes"];
		var interactions = array["interactions"];
		var inputList = typeof objArray !== 'object' ? export_json["input_list"] : objArray;
		str = "Source, Source type,Target,Target type\n";

		for (var i = 0; i < interactions.length; i++) {
			var sourceIndex = interactions[i]["source"];
			var targetIndex = interactions[i]["target"];
			var source = nodes[sourceIndex]["name"];
			var sourceType = "Intermediate protein";
			if(inputList.includes(source)) {
				sourceType = "Seed protein";
			}
						
			var target = nodes[targetIndex]["name"];
			var targetType = "Intermediate protein";
			if(inputList.includes(target)) {
				targetType = "Seed protein";
			}
			str += source + "," + sourceType + "," + target + "," + targetType + "\n";
		}
	} else if(name === 'KEA') {
		str = recordsToCsv(export_json['kinases'])
	} else if(name === 'ChEA') {
		str = recordsToCsv(export_json['tfs'])
	}

	downloadObj(str, name + ".csv");
}

function convertToCytoscape(network) {
	return {
		elements: {
			nodes: network.nodes.map(function(self) {
				var curNode = d3.select('text[title="'+self.name+'"]').node();
				var d3Data;
				if(curNode != null) {
					d3Data = d3.select(curNode.parentNode).data()[0]
				} else {
					d3Data = {
						x: (Math.random() - 0.5)*1000,
						y: (Math.random() - 0.5)*1000
					}
				}
				return {
					data: {
						id: self.name
					},
					position : {
					x : d3Data.x,
					y : d3Data.y
					},
					type: self.type,
					pvalue: self.pvalue
				}
			}),
			edges: network.interactions.map(function(self, ind) {
				return {
					data: {
						id: ind,
						source: network.nodes[self.source].name,
						target: network.nodes[self.target].name
					}
				}
			})
		}
	}
}

function createResults(json_file) {
	if(json_file['input'] !== undefined) {
		var input_list = json_file['input'].join('\n');
		$('#genelist').text(input_list);
	}

	// Draw ChEA table
	var chea = json_file['X2K']["transcriptionFactors"];
	createTable(chea, "#chea-table");
	
	// Draw ChEA bargraph
	drawBargraph(".chea-chart", chea);
	
	// Draw KEA table
	var kea = json_file['X2K']["kinases"];
	createTable(kea, '#kea-table');

	// Draw KEA bargraph	
	drawBargraph(".kea-chart", kea);
	
	// Networks functions
	function convertX2KNode(x2k_node) { //convert the style of a node from X2K output to cytoscape
	    return {name: x2k_node["name"], group: x2k_node["type"], pvalue: x2k_node["pvalue"]};
	}

	function convertG2NNode(g2n_node, input_list) { //convert the style of a node from G2N output to cytoscape
		var node_class;
	    if (input_list.indexOf(g2n_node["name"]) > -1) {
	        node_class = "input_protein";
	    }
	    else {
	        node_class = "intermediate"
	    }

	    return  {name: g2n_node["name"], group: node_class};
	}


	function containsInteraction(json_file, interaction, array) { //check if the interactions list already contains an interaction
	    //used against duplicates
	    for (var y = 0; y < array.length; y++) {
	        var a = array[y];
	        var source_a = a.data.source,
				target_a = a.data.target,
				source_b = json_file.network.nodes[interaction.source].name,
				target_b = json_file.network.nodes[interaction.target].name;
            if ((source_a === source_b && target_a === target_b) ||
	            source_a === target_b && target_a === source_b) {
	            return true;
	        }
	    }
	    return false;
	}

	//clean up a network - remove unused nodes, remove duplicate interactions, self-loops
	function cleanNetwork(json_file, network) {
	    var clean_interactions = [],
	    	connected_nodes = [];
	    for (var i = 0; i < network.interactions.length; i++) {
	        var interaction = network.interactions[i];
	        if (!containsInteraction(json_file, interaction, clean_interactions) && interaction.target !== interaction.source) {
	            var cyto_interaction = {
					data: {
						source: network.nodes[interaction.source]["name"],
						target: network.nodes[interaction.target]["name"],
						pvalue: network.nodes[interaction.source]["pvalue"]
					}
				};
	            clean_interactions.push(cyto_interaction);
	            connected_nodes.push(interaction.source);
	            connected_nodes.push(interaction.target);
	        }
	    }
	    var clean_nodes = [];
	    for (var i = 0; i < network.nodes.length; i++) {
	        if (connected_nodes.indexOf(i) > -1) {
	            clean_nodes.push(network.nodes[i]);
	        }
	    }
	    return [clean_interactions, clean_nodes];
	}
	
	// X2K Processing
	var x2k = json_file["X2K"],
		network = x2k.network,
		clean_network = cleanNetwork(x2k, network),
		clean_nodes = clean_network[1],
		clean_interactions = clean_network[0];
    
    network_string = JSON.stringify(network);
    tf_string = JSON.stringify(x2k.transcriptionFactors);
    kinase_string = JSON.stringify(x2k.kinases);
    x2k_d3_array = {"nodes": [], "links": []};

    for (i = 0; i < clean_nodes.length; i++) {
    	x2k_d3_array["nodes"].push(convertX2KNode(clean_nodes[i]));
    }
    for (i = 0; i < clean_interactions.length; i++) {
    	x2k_d3_array["links"].push(clean_interactions[i]);
    }
    
    draw_network(x2k_d3_array, ".x2k-svg", "#x2k-network");
	
	// G2N Processing
    // var g2n = json_file["G2N"];
	
	// Get G2N Network
    g2n_network = json_file["G2N"]['network'];
    input_tfs = json_file["G2N"]['input_list'];
    $.each(g2n_network['nodes'], function(index) {
    	g2n_network['nodes'][index]['name'] = g2n_network['nodes'][index]['name'].split(/[-_]/)[0];
    });

	// Label G2N network according to input TFs
	
    $.each(g2n_network['nodes'], function(index, elem){
    	if (input_tfs.indexOf(elem['name'].split(/[-_]/)[0]) > -1) {
    		g2n_network['nodes'][index]['type'] = 'input_protein';
    	} else {
    		g2n_network['nodes'][index]['type'] = 'other';
    	}
    });

    var g2n = {'network': g2n_network, 'input_list': input_tfs};
	network = g2n.network;
	clean_network = cleanNetwork(g2n, network);
	clean_nodes = clean_network[1];
	clean_interactions = clean_network[0];

    var input_list = [];
    for (i = 0; i < g2n.input_list.length; i++) input_list.push(g2n.input_list[i].toUpperCase());
    g2n_d3_array = {"nodes": [], "links": []};
    for (i = 0; i < clean_nodes.length; i++) {
    	g2n_d3_array["nodes"].push(convertG2NNode(clean_nodes[i], input_list));
    }
    for (i = 0; i < clean_interactions.length; i++) {
    	g2n_d3_array["links"].push(clean_interactions[i]);
    }
    
    network_string = JSON.stringify(network);
    draw_network(g2n_d3_array, ".g2n-svg", "#g2n-network");
    
	// Modals
	var cur_modal = {};

	$("#dashboardFullModal").on("show.bs.modal", function (event) {
		var button = $(event.relatedTarget) // Button that triggered the modal
		var modal = $(this)
		var div_name = button.data('whatever') // Extract info from data-* attributes
		var modal_title = button.data('modal-title')
		var name = button.data('name')
		var svg = $(div_name).find("svg")

		if ((name === 'ChEA')||(name === 'KEA')) {
            $('.cytoscape-button').hide();
        }
        else {
		    $('.cytoscape-button').show();
		}

		// Hide popover when opening modal
		modal.find(".modal-title").text(modal_title);
		svg.appendTo(modal.find(".modal-body"));
		$('.info-popover-button').popover('hide');

		// We save current model info in a global
		cur_modal = {
			button,
			name,
			div_name,
			svg,
		};
	});

	$(".csv-button").on("click", function () {
		exportCsv(cur_modal.name, json_file[cur_modal.name]);
	});

	$(".svg-button").on("click", function() {
        // Removing zoom controls before exporting and returning them back in the end
        var zoom_controls = $('.modal-body').find('.zoom-controls');
		cur_modal.svg.find('g.zoom-controls').remove();
		
		saveSvgAsPng.svgAsDataUri(cur_modal.svg[0], {}, function(uri) {
			downloadUri(uri, cur_modal.name + '.svg')
			cur_modal.svg.append(zoom_controls);
		})
	});

	$(".png-button").on("click", function(){
        // Removing zoom controls before exporting and returning them back in the end
        var zoom_controls = $('.modal-body').find('.zoom-controls');
		cur_modal.svg.find('g.zoom-controls').remove();
		
		saveSvgAsPng.svgAsPngUri(cur_modal.svg[0], {}, function(uri) {
			downloadUri(uri, cur_modal.name + '.png')
			cur_modal.svg.append(zoom_controls);
		})
	});

	$(".cytoscape-button").on("click", function(){
		downloadObj(
			JSON.stringify(
				convertToCytoscape(
					json_file[cur_modal.name].network
				)
			),
			cur_modal.name + '_network.json',
			'text/json'
		);
	});
		
	$("#dashboardFullModal").on("hide.bs.modal", function() {
		cur_modal.svg.appendTo($(cur_modal.div_name));
	});

	// Popover handler
	$('[data-toggle="popover"]').popover();

	// Hide Popover when clicking elsewhere on the document
	$(document).on('click', function(evt){
		if (($(evt.target).parents('.popover').length === 0)) {
			$('.popover').popover('hide');

			// Show help popover
			if ($(evt.target).parents('button').attr('data-toggle')) {
				$(evt.target).parents('button').popover('toggle');
			}

			// Toggle target popover
			if ($(evt.target).hasClass('enrichment-popover-button')) {
				$(evt.target).popover('toggle');
			}
		}
	})

}

$(function() {
	if(typeof json_file !== 'undefined') {
		createResults(
			Object.keys(json_file).reduce(function(J, c) {
				if(typeof json_file[c] === 'string') {
					J[c] = JSON.parse(json_file[c]);
				} else {
					J[c] = json_file[c];
				}
				return J;
			}, {})
		);
	}
});
