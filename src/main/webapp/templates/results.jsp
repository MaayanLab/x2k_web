<!DOCTYPE html>
<html lang="en">
<head>
    <title>Results</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <link rel="shortcut icon" href="static/favicon.ico" type="image/x-icon">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">

    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.0.9/js/all.js" integrity="sha384-8iPTk2s/jMVj81dnzb/iFR2sdA7u06vHJyyLlAd4snFpCl/SnyUjRrbdJsw1pGIl" crossorigin="anonymous"></script>
    <script src="https://d3js.org/d3.v4.min.js"></script>

    <!--Datatables-->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap4.css"/>
    <link rel="stylesheet" type="text/css"
          href="https://cdn.datatables.net/responsive/2.2.0/css/responsive.bootstrap4.css"/>


    <script type="text/javascript" src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.16/js/dataTables.bootstrap4.js"></script>
    <script type="text/javascript"
            src="https://cdn.datatables.net/responsive/2.2.0/js/dataTables.responsive.js"></script>

    <!--Datatables buttons-->
    <link rel="stylesheet" type="text/css"
          href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.min.css"/>
    <link rel="stylesheet" type="text/css"
          href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.bootstrap4.min.css"/>

    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.1/js/buttons.bootstrap4.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js"></script>

    <!--Own-->
    <link rel="stylesheet" href="dist/css/bargraph.css">
    <link rel="stylesheet" href="dist/css/network.css">
    <link rel="stylesheet" href="dist/css/atooltip.css">
    <link rel="stylesheet" href="dist/css/results.css">


    <script src="dist/js/bargraph.js"></script>
    <script src="dist/js/results.js"></script>
    <script src="dist/js/network.js"></script>
    <script src="dist/js/jquery.atooltip.pack.js"></script>
    <script> var json_file = ${json}; </script>

    <script>
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r;
            i[r] = i[r] || function () {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date();
            a = s.createElement(o), m = s.getElementsByTagName(o)[0];
            a.async = 1;
            a.src = g;
            m.parentNode.insertBefore(a, m)
        })(window, document, 'script',
            'https://www.google-analytics.com/analytics.js', 'ga');
        ga('create', 'UA-6277639-28', 'auto');
        ga('send', 'pageview');
    </script>

</head>
<body>
<!--Header-->
<nav class="navbar navbar-light bg-light justify-content-center navbar-expand-sm" id="x2k-navbar">
    <a class="navbar-brand" href="/X2K">
        <img id="logo" src="static/logo.png" height="50px" class="d-inline-block full-logo">
    </a>
    <!-- <button class="btn btn-primary lead">View Input Genes</button> -->
</nav>

<!--Body-->
<div class="container-fluid bg-light px-5" id="results-dashboard">
    <div class="row justify-content-center">
<!--        <div class="col-sm-1">
            <div class="row">
                <div class="card" id="genelist-container">
                    <div class="card-header" id="genelist-header">
                        Input list
                    </div>
                    <div class="card-block">
                        <textarea class="form-control-sm" id="genelist" readonly></textarea>
                    </div>
                </div>
            </div>
        </div> -->
        <div class="col-12">
            <div class="row justify-content-center align-items-start">

                <!--ChEA-->
                <div class="col-xl-6" id="chea">
                    <div class="card">
                        <nav class="nav nav-tabs navbar-light bg-light" role="tablist">

                            <!-- Title -->
                            <div data-toggle="modal" data-target="#dashboardFullModal" data-whatever="#chea-results ChEA" data-modal-title="Transcription Factor Enrichment Analysis (TFEA)">
                                <button type="button" class="expand">
                                    <i class="fas fa-expand-arrows-alt" aria-hidden="true"></i>
                                </button>
                                <a class="navbar-brand" href="javascript:void(0)"><b>Step 1.</b> Transcription Factor Enrichment Analysis (TFEA)</a>
                            </div>

                            <a class="nav-item nav-link active dash-nav-item dash-nav-link"
                               id="nav-chea-bar-tab" data-toggle="tab"
                               href="#nav-chea-bar"
                               role="tab" aria-controls="nav-chea-bar" aria-expanded="true">Bargraph</a>
                            <a class="nav-item nav-link dash-nav-item dash-nav-link"
                               id="nav-chea-table-tab" data-toggle="tab"
                               href="#nav-chea-table"
                               role="tab"
                               aria-controls="nav-chae-table">Table</a>

                            <!-- Info Popover -->
                            <button class="info-popover-button ml-auto"
                                    data-toggle="popover"
                                    data-html="true"
                                    data-offset="50"
                                    data-template='<div class="popover x2k-card-popover" role="tooltip"><div class="arrow"></div><h3 class="popover-header"></h3><div class="popover-body"></div></div>'
                                    title="What is Transcription Factor Enrichment Analysis?"
                                    data-placement="left"
                                    data-content="<div class='mb-3'>Transcription Factor Enrichment Analysis (TFEA) is the first step of the X2K pipeline. It <b>predicts transcription factors which regulate the input gene list</b> by performing enrichment analysis on data integrated from ChIP-X experiments using ChEA.</div><div class='mb-3'>A ranked list of the <b>top predicted transcription factors</b> is displayed below. The results are made available through an interactive barchart and can be downloaded as a table.</div><div>These genes are used as input for the next step of the X2K pipeline, the <b>protein-protein interaction expansion</b>.</div>">
                                <i class="fa fa-question-circle fa-2x text-muted"></i>
                            </button>

                        </nav>
                        <div id="chea-results" class="card-body">
                            <div class="tab-content" id="nav-tabContent-chea">
                                <div class="tab-pane fade show active" id="nav-chea-bar" role="tabpanel"
                                     aria-labelledby="nav-chea-bar-tab">
                                    <div id="bargraph-chea" class="bargraph">
                                        <span style="font-size: 0.7rem;" class="my-auto mr-1 mt-2">Sort by:</span>
                                        <div class="btn-group btn-group-justified" role="group" aria-label="Sorting type">
                                            <!-- Classes like 'chea-chart-zscore' define sorting type in bargraph.js -->
                                            <input type="button"
                                                   class="selected btn btn-outline-secondary btn-sm chea-chart-pvalue"
                                                   value="P-value">
                                            <input type="button"
                                                   class="btn btn-outline-secondary btn-sm chea-chart-zscore"
                                                   value="Z-score">
                                            <input type="button"
                                                   class="btn btn-outline-secondary btn-sm chea-chart-combinedScore"
                                                   value="Combined score">
                                        </div>

                                        <svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="chea-chart"
                                             width="100%" height="100%" viewBox="-20 0 1020 600"></svg>
                                    </div>
                                </div>

                                <div class="tab-pane fade table-responsive" id="nav-chea-table" role="tabpanel"
                                     aria-labelledby="nav-chea-table-tab">
                                    <table class="display table table-striped table-bordered table-sm" cellspacing="0"
                                           id="chea-table"></table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!--G2N-->
                <div class="col-xl-6" id="g2n">
                    <div class="card">
                        <nav class="nav nav-tabs navbar-light bg-light" role="tablist">

                            <!-- Title -->
                            <div data-toggle="modal" data-target="#dashboardFullModal" data-whatever="#network-g2n G2N" data-modal-title="Protein-Protein Interaction Expansion">
                                <button type="button" class="expand">
                                        <i class="fas fa-expand-arrows-alt" aria-hidden="true"></i>
                                </button>
                                <a class="navbar-brand" href="javascript:void(0)"><b>Step 2.</b> Protein-Protein Interaction Expansion</a>
                            </div>

                            <!-- Info Popover -->
                            <button class="info-popover-button ml-auto"
                                    data-toggle="popover"
                                    data-html="true"
                                    data-offset="50"
                                    data-template='<div class="popover x2k-card-popover" role="tooltip"><div class="arrow"></div><h3 class="popover-header"></h3><div class="popover-body"></div></div>'
                                    title="What is Protein-Protein Interaction Expansion?"
                                    data-placement="left"
                                    data-content="<div class='mb-3'>Protein-Protein Interaction Expansion is the second step of the X2K pipeline. It <b>expands the regulatory network of the input gene list</b> by identifying proteins which physically interact with the top predicted transcription factors using Genes2Networks (G2N). To achieve this, data from Protein-Protein Interaction databases is integrated.</div><div class='mb-3'>A <b>network of transcription factors and interacting proteins is displayed below.</b> Transcription factors are shown in pink, physical interactors are shown in orange.</div><div>This network is used as input for the next step of the X2K pipeline, the <b>Kinase Enrichment Analysis</b>.</div>">
                                <i class="fa fa-question-circle fa-2x text-muted"></i>
                            </button>

                        </nav>
                        <div id="network-g2n" class="card-body">
                            <svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="g2n-svg" width="100%"
                                 height="100%" viewBox="-20 0 1020 600">
                                <g class="zoom-controls g2n-zoom-controls" transform="translate(10, 10)">
                                    <g id="g2n-zoom-in" transform="translate(0, 0)">
                                        <rect width="20" height="20"></rect>
                                        <line x1="5" y1="10" x2="15" y2="10"></line>
                                        <line x1="10" y1="5" x2="10" y2="15"></line>
                                    </g>
                                    <g id="g2n-zoom-out" transform="translate(0, 20)">
                                        <rect width="20" height="20"></rect>
                                        <line x1="5" y1="10" x2="15" y2="10"></line>
                                    </g>
                                </g>
                                <g class="legend" transform="translate(50, 10)">
                                    <g class="legend-background">
                                        <rect width="150" height="20" opacity="0.8" fill="white"></rect>
                                    </g>
                                    <g class="legend-item" transform="translate(0, 0)">
                                        <circle cx="5" cy="10" r="5" fill="#FF7F0E"/>
                                        <text x="15" y="15">Intermediate protein</text>
                                    </g>
                                    <g class="legend-item" transform="translate(150, 0)">
                                        <circle cx="5" cy="10" r="5" fill="#FF546D"/>
                                        <text x="15" y="15">Transcription factor</text>
                                    </g>
                                </g>
                            </svg>

                        </div>
                    </div>
                </div>

            </div>

            <div class="row justify-content-center align-items-start">

                <!--KEA-->
                <div class="col-xl-6" id="kea">
                    <div class="card">
                        <nav class="nav nav-tabs navbar-light bg-light" role="tablist">

                            <!-- Title -->
                            <div data-toggle="modal" data-target="#dashboardFullModal" data-whatever="#kea-results KEA" data-modal-title="Kinase Enrichment Analysis (KEA)">
                                <button type="button" class="expand">
                                    <i class="fas fa-expand-arrows-alt" aria-hidden="true"></i>
                                </button>
                                <a class="navbar-brand" href="javascript:void(0)"><b>Step 3.</b> Kinase Enrichment Analysis (KEA)</a>
                            </div>

                            <a class="nav-item nav-link active dash-nav-item dash-nav-link"
                               id="nav-kea-bar-tab" data-toggle="tab"
                               href="#nav-kea-bar"
                               role="tab" aria-controls="nav-kea-bar" aria-expanded="true">Bargraph</a>
                            <a class="nav-item nav-link"
                               id="nav-kea-table-tab dash-nav-item dash-nav-link" data-toggle="tab"
                               href="#nav-kea-table"
                               role="tab"
                               aria-controls="nav-kea-table">Table</a>

                            <!-- Info Popover -->
                            <button class="info-popover-button ml-auto"
                                    data-toggle="popover"
                                    data-html="true"
                                    data-template='<div class="popover x2k-card-popover" role="tooltip"><div class="arrow"></div><h3 class="popover-header"></h3><div class="popover-body"></div></div>'
                                    title="What is Kinase Enrichment Analysis?"
                                    data-placement="left"
                                    data-content="<div class='mb-3'>Kinase Enrichment Analysis is the third step of the X2K pipeline. It <b>predicts protein kinases which regulate the expanded regulatory network</b> by performing enrichment analysis on data integrated from kinase-substrate interaction databases using KEA.</div><div class='mb-3'>A ranked list of the <b>top predicted kinases</b> is displayed below. The results are made available through an interactive barchart and can be downloaded as a table.</div><div>The top kinases are displayed alongside the predicted transcription factors (Step 1) and expanded regulatory network (Step 2) in the <b>final Expression2Kinases network</b>.</div>">
                                <i class="fa fa-question-circle fa-2x text-muted"></i>
                            </button>

                        </nav>

                        <div id="kea-results" class="card-body">
                            <div class="tab-content" id="nav-tabContent-kea">
                                <div class="tab-pane fade show active" id="nav-kea-bar" role="tabpanel"
                                     aria-labelledby="nav-kea-bar-tab">
                                    <div id="bargraph-kea" class="bargraph">
                                        <span style="font-size: 0.7rem;" class="my-auto mr-1 mt-2">Sort by:</span>
                                        <div class="btn-group btn-group-justified" role="group" aria-label="Sorting type">
                                            <!-- Classes like 'kea-chart-zscore' define sorting type in bargraph.js -->
                                            <input type="button"
                                                   class="selected btn btn-outline-secondary btn-sm kea-chart-pvalue"
                                                   value="P-value">
                                            <input type="button"
                                                   class="btn btn-outline-secondary btn-sm kea-chart-zscore"
                                                   value="Z-score">
                                            <input type="button"
                                                   class="btn btn-outline-secondary btn-sm kea-chart-combinedScore"
                                                   value="Combined score">
                                        </div>

                                        <svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="kea-chart"
                                             width="100%" height="100%" viewBox="-20 0 1020 600"></svg>
                                    </div>

                                </div>
                                <div class="tab-pane fade table-responsive" id="nav-kea-table" role="tabpanel"
                                     aria-labelledby="nav-kea-table-tab">
                                    <table class="display table table-striped table-bordered table-sm" cellspacing="0"
                                           id="kea-table"></table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!--X2K-->
                <div class="col-xl-6" id="x2k">
                    <div class="card">
                        <nav class="nav nav-tabs navbar-light bg-light" role="tablist">

                            <!-- Title -->
                            <div data-toggle="modal" data-target="#dashboardFullModal" data-whatever="#x2k-network X2K" data-modal-title="Expression2Kinases Network" class="cursor-pointer">
                                <button type="button" class="expand cursor-pointer">
                                    <i class="fa fa-expand" aria-hidden="true"></i>
                                </button>
                                <a class="navbar-brand d-inline-block" href="#"><b>Step 4.</b> Expression2Kinases Network</a>
                            </div>

                            <!-- Info Popover -->
                            <button class="info-popover-button ml-auto"
                                    data-toggle="popover"
                                    data-html="true"
                                    data-template='<div class="popover x2k-card-popover" role="tooltip"><div class="arrow"></div><h3 class="popover-header"></h3><div class="popover-body"></div></div>'
                                    title="What is Expression2Kinases?"
                                    data-placement="left"
                                    data-content="<div class='mb-3'>The Expression2Kinases (X2K) network displays <b>the inferred upstream regulatory network of the input gene list</b> by integrating the results of ChEA (Step 1), G2N (Step 2), and KEA (Step 3).</div><div>Pink nodes represent the <b>top transcription factors</b> predicted to regulate the expression of the input gene list; orange nodes represent <b>physical interactors of the transcription factors</b>; blue nodes represent the <b>top protein kinases</b> predicted to phosphorylate such genes.</div>">
                                <i class="fa fa-question-circle fa-2x text-muted"></i>
                            </button>
                            
                        </nav>
                        <div id="x2k-network" class="card-body">
                            <svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="x2k-svg" id="x2ksvg" width="100%"
                                 height="100%" viewBox="-20 0 1020 600">
                                <g class="legend" transform="translate(50, 10)">
                                    <g class="legend-background">
                                        <rect width="150" height="20" opacity="0.8" fill="white"></rect>
                                    </g>
                                    <g class="legend-item" transform="translate(0, 0)">
                                        <circle cx="5" cy="10" r="5" fill="#FF546D"/>
                                        <text x="15" y="15">Transcription factor</text>
                                    </g>
                                    <g class="legend-item" transform="translate(150, 0)">
                                        <circle cx="5" cy="10" r="5" fill="#FF7F0E"/>
                                        <text x="15" y="15">Intermediate protein</text>
                                    </g>
                                    <g class="legend-item" transform="translate(300, 0)">
                                        <circle cx="5" cy="10" r="5" fill="#1F77B4"/>
                                        <text x="15" y="15">Kinase</text>
                                    </g>
                                </g>
                                <g class="zoom-controls x2k-zoom-controls" transform="translate(10, 10)">
                                    <g id="x2k-zoom-in" transform="translate(0, 0)">
                                        <rect width="20" height="20"></rect>
                                        <line x1="5" y1="10" x2="15" y2="10"></line>
                                        <line x1="10" y1="5" x2="10" y2="15"></line>
                                    </g>
                                    <g id="x2k-zoom-out" transform="translate(0, 20)">
                                        <rect width="20" height="20"></rect>
                                        <line x1="5" y1="10" x2="15" y2="10"></line>
                                    </g>
                                </g>
                            </svg>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<!--Modals-->
<div class="modal fade" id="dashboardFullModal" tabindex="-1" role="dialog" aria-labelledby="dashboardFullModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body"></div>
            <div class="modal-footer">            
                <a id="json-anchor">
                    <button type="button" class="btn btn-outline-primary json-button">JSON</button>
                </a>
                <a id="csv-anchor">
                    <button type="button" class="btn btn-outline-primary csv-button">CSV</button>
                </a>
                <a id="exportData">
                    <button type="button" class="btn btn-outline-primary svg-button">SVG</button>
                </a>
                <a id="png-anchor">
                    <button type="button" class="btn btn-outline-primary png-button">PNG</button>
                </a>
                <a id="cytoscape-anchor">
                    <button type="button" class="btn btn-outline-primary cytoscape-button">Cytoscape</button>
                </a>
            </div>
        </div>
    </div>
</div>

<!--Footer-->
<footer class="container-fluid" id="footer">
    <div class="row justify-content-center mt-2">
        <div class="col-sm-7" id="citations">
            <!--             <p>Please cite this paper if you are using X2K for your publication:
                            <a href="http://www.ncbi.nlm.nih.gov/pubmed/22080467"> Chen EY, Xu
                                H, Gordonov S, Lim MP, Perkins MH, Ma'ayan A. Expression2Kinases:
                                mRNA Profiling Linked to Multiple Upstream Regulatory Layers.
                                Bioinformatics. (2012) 28 (1): 105-111</a></p> -->
        </div>
    </div>
</footer>
</body>
</html>