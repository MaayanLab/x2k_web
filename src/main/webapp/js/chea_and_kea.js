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
    console.log(json_file);
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
    console.log(graph_info);
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
    console.log(data_array);
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

window.onload = function(){
    type = json_file["type"];
    if(type == "ChEA"){
        graph_info = parseChEA(json_file);
        makeTable(json_file.tfs);
    }
    else{ //type == "KEA"
        graph_info = parseKEA(json_file);
        makeTable(json_file.kinases);
    }
    makeChart(graph_info);
}
