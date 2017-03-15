
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


function containsInteraction(interaction, array){ //check if the interacitons list already contains an interaciton
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
function cleanNetwork(network){
    clean_interactions = [];
    connected_nodes = [];
    for(i = 0; i < network.interactions.length; i++){
        interaction = network.interactions[i];
        if(!containsInteraction(interaction, clean_interactions) && interaction.target != interaction.source) {
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

//main function
window.onload = function(){
	var json_file = json["X2K"]
	
    network = json_file.network;
    clean_network = cleanNetwork(network);
    clean_nodes = clean_network[1];
    clean_interactions = clean_network[0];

    if(json_file.type == "X2K"){
        //x2k processing - we need to make more things avaialble as strings to download
        network_string = JSON.stringify(network);
        tf_string = JSON.stringify(json_file.transcriptionFactors);
        kinase_string = JSON.stringify(json_file.kinases);
        cytoscape_array = [];

        for(i = 0; i < clean_nodes.length; i++){
            cytoscape_array.push(convertX2KNode(clean_nodes[i]));
        }
        for(i = 0; i < clean_interactions.length; i++){
            cytoscape_array.push(clean_interactions[i]);
        }

    }
    else{ //json_file.type = "G2N"
        input_list = [];
        for(i = 0; i < json_file.input_list.length; i++) input_list.push(json_file.input_list[i].toUpperCase());
        cytoscape_array = [];
        for(i = 0; i < clean_nodes.length; i++){
            cytoscape_array.push(convertG2NNode(clean_nodes[i],input_list));
        }
        for(i = 0; i < clean_interactions.length; i++){
            cytoscape_array.push(clean_interactions[i]);
        }

        network_string = JSON.stringify(network);

    }

    console.log(cytoscape_array);
    
    var cy = cytoscape({
        container: $('#graph'),
        style: [
            {
                "selector": "core",
                "style": {
                    "selection-box-color": "#AAD8FF",
                    "selection-box-border-color": "#8BB0D0",
                    "selection-box-opacity": "0.2"
                }
            },
            {
                "selector": "node",
                "style": {
                    "content": "data(name)",
                    "font-size": "14px",
                    "text-valign": "center",
                    "text-halign": "center",
                    "text-outline-width": "0px",
                    "color": "#000",
                    "overlay-padding": "3px",
                    "z-index": "10"
                }
            },
            {
                "selector": ".tf",
                "style": {
                    "background-color": "#DD4484",
                    "width": "50",
                    "height": "50"
                }
            },
            {
                "selector": ".kinase",
                "style": {
                    "background-color": "#ABDAFC",
                    "width": "60",
                    "height": "60"
                }
            },
            {
                "selector": ".other",
                "style": {
                    "background-color": "#C490D1",
                    "width": "40",
                    "height": "40"
                }
            },
            {
                "selector": ".input_protein",
                "style": {
                    "background-color": "#DD4484",
                    "width": "40",
                    "height": "40"
                }
            },
            {
                "selector": ".intermediate",
                "style": {
                    "background-color": "#C490D1",
                    "width": "40",
                    "height": "40"
                }
            },
            {
                "selector": ".hidden",
                "style": {
                    "display": "none"
                }
            },
            {
                "selector": "edge",
                "style": {
                    "curve-style": "haystack",
                    "haystack-radius": "0",
                    "opacity": "0.3",
                    "line-color": "#222",
                    "width": "mapData(weight, 0, 1, 1, 8)",
                    "overlay-padding": "3px"                	
                }
            }
        ],
        elements: cytoscape_array,
        layout: {
            name: 'cola',
            maxSimulationTime: 1000,
            edgeLengthVal: 50,
            nodeSpacing: 10,
            randomize: false,
            animate: false,
            edgeJaccardLength: 50,
            flow: { axis: 'x', minSeparation: 40 }
        }
    });
    cy.nodes().forEach(function(node) {
        var name = name.split('_')[0];
        node.qtip({
            content: [
//                    {
//                        name: 'View node graph',
//                        url: '/components/'+name+'.html'
//                    },
                {
                    name: 'View on Harminizome',
                    url: 'http://amp.pharm.mssm.edu/Harmonizome/gene/'+name
                },
                {
                    name: 'View on GeneCard',
                    url: 'http://www.genecards.org/cgi-bin/carddisp.pl?gene='+name
                }
            ].map(function(link) {
                return '<a href="'+link.url+'">'+link.name+'</a>';
            }).join('<br />\n'),
            position: {
                my: 'top center',
                at: 'bottom center'
            },
            style: {
                classes: 'qtip',
                tip: {
                    width: 16,
                    height: 8
                }
            }
        });
    });

}

