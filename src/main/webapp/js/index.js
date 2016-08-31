/* index.js: Primary JavaScript file for handling user interface.
 */

/* Checks for page loading with hash or hash changing.
 */
function listenForHashChange() {
    if (hasHash()) { highlightTabAndShowContent(); }
    $(window).on('hashchange', highlightTabAndShowContent);
}

/* Highlights the selected/active tab and shows the appropriate content.
 */
function highlightTabAndShowContent() {
    var hash = getHash(),
        $tabToHighlight = $('#menu a[href="#' + hash + '"]'),
        $tabContentToShow = $('#' + hash);
    $('.tab-content').hide();
    $('.tab-link').removeClass('active');
    $tabToHighlight.addClass('active');
    $tabContentToShow.fadeIn(600);
}

/* Returns true if URL contains characters beyond hash symbol, False otherse.
 */
function hasHash() {
    var h = window.location.hash;
    return !!h && h !== '#';
}

/* Returns URL hash, stripping the "#" symbol.
 */
function getHash() {
    return window.location.hash.substring(1);
}

/* Fetches and inserts example genes.
 */
function insertExample() {
    $.get('resources/example_genes', function(data) {
        $('textarea#textGenes').val(data);
    });
    return false;
}

var GRAPH_WIDTH = 300;
var GRAPH_HEIGHT = 290;

function histogram(data, labels, title, canvas, width, height) {
    var ctx = document.getElementById(canvas).getContext("2d");
    ctx.canvas.height = height;
    ctx.canvas.width = width;
    var myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels.slice(1,labels.length),
            datasets: [
                {
                    lineTension: .1,
                    pointHoverBackgroundColor: "rgba(8,103,136,1)",
                    pointHoverBorderColor: "rgba(8,103,136,1)",
                    backgroundColor: "rgba(0,204,153,0.4)",
                    borderColor: "rgba(0,204,153,1)",
                    label: title,
                    data: data
                }
            ]
        },
        options: {
            maintainAspectRatio: true,
            responsive: false,
            legend: {
                display: false},
            scales: {
                yAxes: [{
                    scaleLabel: {
                        display: true,
                        labelString: 'Nodes'
                    }
                }],
                xAxes: [{
                    scaleLabel:{
                        display: true,
                        labelString: "Interactions per Node "
                    }
                }]
            }
        }
    });
}

function statsDiv(dataset_name, data) {
    dataset = data[dataset_name];
    div_string = '<div id=' + dataset_name + ' class="stats">' +
        '<h4 class="stats_name">' + dataset_name.replace(/_/g, ' ') + '</h4>' +
        'Total Interactions: ' + dataset.count +
        '<canvas id=' + dataset_name + '_graph></canvas>' +
        '</div>';
    return div_string;
}

//data type refers to KEA, ChEA, or G2N
function buildHistograms(data, data_type, datasets){
    for(i = 0; i < datasets.length; i++){
        dataset_name = datasets[i];
        $( "#" + data_type + "_stats" ).append(statsDiv(dataset_name,data[data_type]));
        histogram(data[data_type][dataset_name].data,
            data[data_type][dataset_name].labels,
            "Number of interactors",
            dataset_name + "_graph",
            GRAPH_WIDTH,
            GRAPH_HEIGHT);
    }
}

function submitButtonListener(button, endpoint){
    console.log(button, endpoint);
    document.getElementById(button).addEventListener("click", function(event){
        event.preventDefault();
        document.getElementById("settings_form").setAttribute("action", endpoint);

        text_input = document.getElementById("textGenes").value;
        file_input = document.getElementById("file_upload").value;
        if (text_input.length > 0 || file_input.length > 0){
            document.getElementById("settings_form").submit();
            loading_elem = document.getElementById("loading_wheel");
            loading_elem.style.display = "block";
        }
    });
}

window.onload = function() {

    listenForHashChange();

    // Get the thing that submits to different servlets
    submitButtonListener("chea_submit", "ChEA");
    submitButtonListener("kea_submit", "KEA");
    submitButtonListener("x2k_submit", "network");
    submitButtonListener("g2n_submit", "G2N");

    // Confirm the initial tab selection
    //document.getElementById("tf_tab").click();

    // Display stats
    $.ajax({
        url: 'datasets/dataset_statistics.json',
        success: function(data) {
            buildHistograms(
                data,
                "ChEA",
                ["ChEA_2015", "ENCODE_2015", "ChEA_&_ENCODE_Consensus", "Transfac_&_Jaspar"]
            );
            buildHistograms(
                data,
                "G2N",
                ["Biocarta", "BioGrid", "DIP", "innateDB", "IntAct", "KEGG", "MINT", "ppid", "SNAVI"]
            );
            buildHistograms(
                data,
                "KEA",
                ["Kinase-Protein", "Phosphorylation"]
            );
        }
    })
};
