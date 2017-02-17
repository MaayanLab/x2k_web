// ChEA & KEA
function opentab(evt, tabName) {
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tab-content");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tab-link");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    document.getElementById(tabName).style.display = "block";
    evt.currentTarget.className += " active";
} //this is copy pasted, will fix later


function getData(sorting_style, data_list){
    score_array = []
    label_array = []
    if(sorting_style == "p-value"){
        x_axis_label = "-log(P-Value)";
        for (i = 0; i < data_list.length; i++){
            label_array.push(data_list[i]["name"]);
            score_array.push(-Math.log(data_list[i]["pvalue"]));
        }
    }
    else if (sorting_style == "rank"){
        x_axis_label = "Z-Score";
        for (i = 0; i < data_list.length; i++){
            label_array.push(data_list[i]["name"]);
            score_array.push(data_list[i]["zscore"].toFixed(4));
        }
    }
    else { //sorting_style == "combinedScore
        x_axis_label = "Combined Score";
        for (i = 0; i < data_list.length; i++) {
            label_array.push(data_list[i]["name"]);
            score_array.push(data_list[i]["combinedScore"].toFixed(4));
        }
    }
    return {scores:score_array,
            labels:label_array,
            axis_label:x_axis_label};
}

//parses ChEA data into a format ready to be charted
function parseChEA(json_file){
    tfs = json_file["tfs"];
    sort_by = json_file["sort transcription factors by"];
    return getData(sort_by, tfs);
}

//parses KEA data into a format ready to be charted
function parseKEA(json_file){
    kinases = json_file["kinases"];
    sort_by = json_file["sort kinases by"];
    return getData(sort_by, kinases);
}

//makes a chart of either KEA or ChEA data
function makeChart(graph_info){
    var ctx = document.getElementById("chart_canvas").getContext("2d");
    ctx.canvas.width = 650;
    ctx.canvas.height = 500;
    var myChart = new Chart(ctx, {
        type: 'horizontalBar',
        data: {
            labels: graph_info.labels,
            datasets: [
                {
                    backgroundColor: "rgba(0,204,153,0.4)",
                    borderColor: "rgba(0,204,153,1)",
                    label: graph_info.axis_label,
                    data: graph_info.scores
                }
            ]
        },
        options: {
            tooltips : {

                callbacks: {
                    label: function (tooltipItem, data) {
                        if (graph_info.axis_label == "-log(P-Value)"){
                            return  'P-Value : ' +
                                   Math.pow(Math.E,-tooltipItem.xLabel).toPrecision(3);
                        }
                        else{
                            return data.datasets[tooltipItem.datasetIndex].label + ': ' +
                                tooltipItem.xLabel;
                        }

                    }
                }
            },
            maintainAspectRatio: true,
            responsive: true,
            legend: {
                display: false},
            scales: {
                yAxes: [{
                    scaleLabel: {
                        display: false,
                        labelString: 'where is this'}
                }],
                xAxes: [{
                    scaleLabel:{
                        display: true,
                        labelString: graph_info.axis_label
                    },
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });
}

function makeTable(data_array){
    for(i = 0; i < data_array.length; i++){
        entry = data_array[i];
        table_row = "<tr>" +
            "<td class='table_left'>"+entry.name+"</td>" +
            "<td>"+entry.pvalue.toPrecision(3)+"</td>" +
            "<td>"+entry.zscore.toFixed(3)+"</td>" +
            "<td>"+entry.combinedScore.toFixed(3)+"</td>" +
            "</tr>"
        $("#data_table").append(table_row);
    }
}

// G2N & X2K

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

// main

window.onload = function(){
    graph_info_chea = parseChEA(json_file['ChEA']);
    makeTable(json_file['ChEA'].tfs);
    graph_info_kea = parseKEA(json_file['KEA']);
    makeTable(json_file['KEA'].kinases);
    makeChart(graph_info_chea);
    makeChart(graph_info_kea);
    
    // G2N & X2K

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
