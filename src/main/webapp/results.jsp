<!DOCTYPE html>
<html lang="en">
<head>
    <title>Results</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">

    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>


    <script src="https://d3js.org/d3.v4.min.js"></script>

    <!--Datatables-->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap4.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.4.2/css/buttons.bootstrap4.css">
    <link rel="stylesheet" type="text/css"
          href="https://cdn.datatables.net/fixedheader/3.1.3/css/fixedHeader.bootstrap4.css">
    <link rel="stylesheet" type="text/css"
          href="https://cdn.datatables.net/responsive/2.2.0/css/responsive.bootstrap4.css">

    <script type="text/javascript" src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.16/js/dataTables.bootstrap4.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.4.2/js/dataTables.buttons.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.4.2/js/buttons.bootstrap4.js"></script>
    <script type="text/javascript"
            src="https://cdn.datatables.net/fixedheader/3.1.3/js/dataTables.fixedHeader.js"></script>
    <script type="text/javascript"
            src="https://cdn.datatables.net/responsive/2.2.0/js/dataTables.responsive.js"></script>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <!--Own-->
    <link rel="stylesheet" href="css/bargraph.css">
    <link rel="stylesheet" href="css/network.css">
    <link rel="stylesheet" href="css/atooltip.css">
    <link rel="stylesheet" href="css/results.css">


    <script src="js/bargraph.js"></script>
    <script src="js/results.js"></script>
    <script src="js/network.js"></script>
    <script src="js/jquery.atooltip.pack.js"></script>
    <script> var json_file = ${json}; </script>
</head>
<body>
<!--Header-->
<div id="logo">
    <a href="/X2K"><img id="logo-png" class="img-fluid mx-auto" src="resources/logo.png"></a>
    <p id="x2k_title">A web interface for the Expression to Kinases application</p>
</div>

<!--Body-->
<div class="container-fluid" id="results-dashboard">
    <div class="row justify-content-center align-items-start">
        <!--X2K-->
        <div class="col-sm-5 mx-2" id="x2k">
            <div class="card">
                <div class="card-header text-center">X2K</div>
                <div id="x2k-network" class="card-body">
                    <svg class="x2k-svg" width="500" height="320"></svg>
                </div>
                <div class="card-footer">
                    <div class="row justify-content-between">
                        <div class="legend col-sm-8">
                            <div class="btn-group" role="group" aria-label="X2K Legend">
                                <button type="button" class="btn btn-outline-secondary btn-sm">
                                    <svg id="legend-dot" height="12" width="12">
                                        <circle cx="6" cy="6" r="6" fill="#1F77B4"></circle>
                                    </svg>
                                    Kinase
                                </button>
                                <button type="button" class="btn btn-outline-secondary btn-sm">
                                    <svg id="legend-dot" height="12" width="12">
                                        <circle cx="6" cy="6" r="6" fill="#FF7F0E"></circle>
                                    </svg>
                                    Intermediate protein
                                </button>
                                <button type="button" class="btn btn-outline-secondary btn-sm">
                                    <svg id="legend-dot" height="12" width="12">
                                        <circle cx="6" cy="6" r="6" fill="#FF546D"></circle>
                                    </svg>
                                    Transcription Factor
                                </button>
                            </div>
                        </div>
                        <div class="download-buttons col-sm-4">
                            <a onclick="exportJson(this, 'X2K', json_file['X2K']);">
                                <button type="button" class="btn btn-outline-secondary btn-sm">JSON</button>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--ChEA-->
        <div class="col-sm-5 mx-2" id="chea">
            <div class="card">
                <div class="card-header text-center">ChEA</div>
                <div class="card-body">
                    <nav class="nav nav-tabs" id="chea-tabs" role="tablist">
                        <a class="nav-item nav-link active" id="nav-chea-bar-tab" data-toggle="tab" href="#nav-chea-bar"
                           role="tab" aria-controls="nav-chea-bar" aria-expanded="true">Bargraph</a>
                        <a class="nav-item nav-link" id="nav-chea-table-tab" data-toggle="tab" href="#nav-chea-table"
                           role="tab"
                           aria-controls="nav-chae-table">Table</a>
                    </nav>
                    <div class="tab-content" id="nav-tabContent-chea">
                        <div class="tab-pane fade show active" id="nav-chea-bar" role="tabpanel"
                             aria-labelledby="nav-chea-bar-tab">
                            <div id="bargraph-chea" class="bargraph">
                                <div class="mt-1">
                                    <input type="button" class="selected btn btn-outline-secondary btn-sm"
                                           value="P-value">
                                    <input type="button" class="btn btn-outline-secondary btn-sm" value="Z-score">
                                    <input type="button" class="btn btn-outline-secondary btn-sm"
                                           value="Combined score">
                                </div>
                                <svg class="chea-chart" width="500" height="250"></svg>
                            </div>
                        </div>

                        <div class="tab-pane fade" id="nav-chea-table" role="tabpanel"
                             aria-labelledby="nav-chea-table-tab">
                            <table class="table table-striped table-bordered table-sm" id="chea-table"></table>
                        </div>
                    </div>
                </div>
                <div class="download-buttons card-footer">
                    <div class="row justify-content-end">
                        <a onclick="exportJson(this, 'ChEA', json_file['ChEA']);">
                            <button type="button" class="btn btn-outline-secondary btn-sm">JSON</button>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--G2N-->
    <div class="row justify-content-center align-items-start">
        <div class="col-sm-5 mx-2" id="g2n">
            <div class="card">
                <div class="card-header text-center">G2N</div>
                <div id="network-g2n" class="card-body">
                    <svg class="g2n-svg" width="500" height="320"></svg>
                </div>
                <div class="card-footer">
                    <div class="row justify-content-between">
                        <div class="legend col-sm-8">
                            <div class="btn-group" role="group" aria-label="X2K Legend">
                                <button type="button" class="btn btn-outline-secondary btn-sm">
                                    <svg id="legend-dot" height="12" width="12">
                                        <circle cx="6" cy="6" r="6" fill="#1F77B4"></circle>
                                    </svg>
                                    Seed Protein
                                </button>
                                <button type="button" class="btn btn-outline-secondary btn-sm">
                                    <svg id="legend-dot" height="12" width="12">
                                        <circle cx="6" cy="6" r="6" fill="#FF7F0E"></circle>
                                    </svg>
                                    Intermediate protein
                                </button>
                            </div>
                        </div>
                        <div class="download-buttons col-sm-4">
                            <a onclick="exportJson(this, 'G2N', json_file['G2N']);">
                                <button type="button" class="btn btn-outline-secondary btn-sm">JSON</button>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--KEA-->
        <div class="col-sm-5 mx-2" id="kea">
            <div class="card">
                <div class="card-header text-center">KEA</div>
                <div class="card-body">
                    <nav class="nav nav-tabs" id="kea-tabs" role="tablist">
                        <a class="nav-item nav-link active" id="nav-kea-bar-tab" data-toggle="tab" href="#nav-kea-bar"
                           role="tab" aria-controls="nav-kea-bar" aria-expanded="true">Bargraph</a>
                        <a class="nav-item nav-link" id="nav-kea-table-tab" data-toggle="tab" href="#nav-kea-table"
                           role="tab"
                           aria-controls="nav-chae-table">Table</a>
                    </nav>
                    <div class="tab-content" id="nav-tabContent-kea">
                        <div class="tab-pane fade show active" id="nav-kea-bar" role="tabpanel"
                             aria-labelledby="nav-kea-bar-tab">
                            <div id="bargraph-kea" class="bargraph">
                                <div class="mt-1">
                                    <input type="button" class="selected btn btn-outline-secondary btn-sm"
                                           value="P-value">
                                    <input type="button" class="btn btn-outline-secondary btn-sm" value="Z-score">
                                    <input type="button" class="btn btn-outline-secondary btn-sm"
                                           value="Combined score">
                                </div>
                                <svg class="kea-chart" width="500" height="250"></svg>
                            </div>

                        </div>
                        <div class="tab-pane fade" id="nav-kea-table" role="tabpanel"
                             aria-labelledby="nav-kea-table-tab">
                            <table class="table table-striped table-bordered table-sm" id="kea-table"></table>
                        </div>
                    </div>
                </div>
                <div class="download-buttons card-footer">
                    <div class="row justify-content-end">
                        <a onclick="exportJson(this, 'KEA', json_file['KEA']);">
                            <button type="button" class="btn btn-outline-secondary btn-sm">JSON</button>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!--Footer-->
<footer class="container-fluid" id="footer">
    <div class="row justify-content-center">
        <div class="col-sm-7" id="citations">
            <p>Please cite this paper if you are using X2K for your publication:
                <a href="http://www.ncbi.nlm.nih.gov/pubmed/22080467"> Chen EY, Xu
                    H, Gordonov S, Lim MP, Perkins MH, Ma'ayan A. Expression2Kinases:
                    mRNA Profiling Linked to Multiple Upstream Regulatory Layers.
                    Bioinformatics. (2012) 28 (1): 105-111</a></p>
        </div>
    </div>
</footer>
</body>
</html>