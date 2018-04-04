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
    <script src="https://use.fontawesome.com/1aa9a9820c.js"></script>	
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
    <link rel="stylesheet" href="css/bargraph.css">
    <link rel="stylesheet" href="css/network.css">
    <link rel="stylesheet" href="css/atooltip.css">
    <link rel="stylesheet" href="css/results.css">


    <script src="js/bargraph.js"></script>
    <script src="js/results.js"></script>
    <script src="js/network.js"></script>
    <script src="js/jquery.atooltip.pack.js"></script>
    <script src="js/saveSvgAsPng.js"></script>
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
</nav>

<!--Body-->
<div class="container-fluid bg-light" id="results-dashboard">
    <div class="row justify-content-center">
    	<div class="col-sm-1">
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
    	</div>
        <div class="col-sm-11">
            <div class="row justify-content-center align-items-start">
                <!--X2K-->
                <div class="col-sm-6" id="x2k">
                    <div class="card">
                        <nav class="nav nav-tabs navbar-light bg-light" role="tablist">
                            <button type="button" class="expand" data-toggle="modal"
                                    data-target="#dashboardFullModal"
                                    data-whatever="#x2k-network X2K"><i class="fa fa-expand" aria-hidden="true"></i>
                            </button>
                            <a class="navbar-brand" href="#">
                                X2K</a>
                        </nav>
                        <div id="x2k-network" class="card-body">
                            <svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="x2k-svg" id="x2ksvg" width="100%"
                                 height="100%" viewBox="-20 0 1020 600"></svg>
                            <div class="btn-group btn-group-justified" role="group" aria-label="Sorting type">
                                <button class="btn btn-outline-secondary btn-sm legend-button" disabled>
                                    <svg height="10" width="10">
                                        <circle cx="5" cy="5" r="5" fill="#FF546D"/>
                                    </svg>
                                    Transcription factor
                                </button>
                                <button class="btn btn-outline-secondary btn-sm legend-button" disabled>
                                    <svg height="10" width="10">
                                        <circle cx="5" cy="5" r="5" fill="#FF7F0E"/>
                                    </svg>
                                    Intermediate protein
                                </button>
                                <button class="btn btn-outline-secondary btn-sm legend-button" disabled>
                                    <svg height="10" width="10">
                                        <circle cx="5" cy="5" r="5" fill="#1F77B4"/>
                                    </svg>
                                    Kinase
                                </button>
                            </div>
                        </div>
                        <!--                 <div class="card-footer">
                                            <div class="row justify-content-between">
                                                <div class="legend col-sm-8">
                                                </div>
                                                <div class="download-buttons col-sm-4">
                                                    <a onclick="exportJson(this, 'X2K', json_file['X2K']);">
                                                        <button type="button" class="btn btn-outline-secondary btn-sm">JSON</button>
                                                    </a>
                                                </div>
                                            </div>
                                        </div> -->
                    </div>
                </div>

                <!--ChEA-->
                <div class="col-sm-6" id="chea">
                    <div class="card">
                        <nav class="nav nav-tabs navbar-light bg-light" role="tablist">
                            <button type="button" class="expand" data-toggle="modal"
                                    data-target="#dashboardFullModal"
                                    data-whatever="#chea-results ChEA">
                                <i class="fa fa-expand" aria-hidden="true"></i>
                            </button>
                            <a class="navbar-brand" href="#">
                                ChEA</a>
                            <a class="nav-item nav-link active" id="nav-chea-bar-tab" data-toggle="tab"
                               href="#nav-chea-bar"
                               role="tab" aria-controls="nav-chea-bar" aria-expanded="true">Bargraph</a>
                            <a class="nav-item nav-link" id="nav-chea-table-tab" data-toggle="tab"
                               href="#nav-chea-table"
                               role="tab"
                               aria-controls="nav-chae-table">Table</a>
                        </nav>
                        <div id="chea-results" class="card-body">
                            <div class="tab-content" id="nav-tabContent-chea">
                                <div class="tab-pane fade show active" id="nav-chea-bar" role="tabpanel"
                                     aria-labelledby="nav-chea-bar-tab">
                                    <div id="bargraph-chea" class="bargraph">
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
                        <!--                 <div class="download-buttons card-footer">
                                            <div class="row justify-content-end">
                                                <a onclick="exportJson(this, 'ChEA', json_file['ChEA']);">
                                                    <button type="button" class="btn btn-outline-secondary btn-sm">JSON</button>
                                                </a>
                                            </div>
                                        </div> -->
                    </div>
                </div>
            </div>

            <!--G2N-->
            <div class="row justify-content-center align-items-start">
                <div class="col-sm-6" id="g2n">
                    <div class="card">
                        <nav class="nav nav-tabs navbar-light bg-light" role="tablist">
                            <button type="button" class="expand" data-toggle="modal"
                                    data-target="#dashboardFullModal"
                                    data-whatever="#network-g2n G2N"><i class="fa fa-expand" aria-hidden="true"></i>
                            </button>
                            <a class="navbar-brand" href="#">G2N</a>
                        </nav>
                        <div id="network-g2n" class="card-body">
                            <svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="g2n-svg" width="100%"
                                 height="100%" viewBox="-20 0 1020 600"></svg>
                            <div class="btn-group btn-group-justified" role="group" aria-label="Sorting type">
                                <button class="btn btn-outline-secondary btn-sm legend-button" disabled>
                                    <svg height="10" width="10">
                                        <circle cx="5" cy="5" r="5" fill="#1F77B4"/>
                                    </svg>
                                    Seed protein
                                </button>
                                <button class="btn btn-outline-secondary btn-sm legend-button" disabled>
                                    <svg height="10" width="10">
                                        <circle cx="5" cy="5" r="5" fill="#FF7F0E"/>
                                    </svg>
                                    Intermediate protein
                                </button>

                            </div>

                        </div>
                        <!--                 <div class="card-footer">
                                            <div class="row justify-content-between">
                                                <div class="legend col-sm-8">
                                                </div>
                                                <div class="download-buttons col-sm-4">
                                                    <a onclick="exportJson(this, 'G2N', json_file['G2N']);">
                                                        <button type="button" class="btn btn-outline-secondary btn-sm">JSON</button>
                                                    </a>
                                                </div>
                                            </div>
                                        </div> -->
                    </div>
                </div>

                <!--KEA-->
                <div class="col-sm-6" id="kea">
                    <div class="card">
                        <nav class="nav nav-tabs navbar-light bg-light" role="tablist">
                            <button type="button" class="expand" data-toggle="modal"
                                    data-target="#dashboardFullModal"
                                    data-whatever="#kea-results KEA">
                                <i class="fa fa-expand" aria-hidden="true"></i>
                            </button>
                            <a class="navbar-brand" href="#">
                                KEA</a>
                            <a class="nav-item nav-link active" id="nav-kea-bar-tab" data-toggle="tab"
                               href="#nav-kea-bar"
                               role="tab" aria-controls="nav-kea-bar" aria-expanded="true">Bargraph</a>
                            <a class="nav-item nav-link" id="nav-kea-table-tab" data-toggle="tab"
                               href="#nav-kea-table"
                               role="tab"
                               aria-controls="nav-kea-table">Table</a>
                        </nav>

                        <div id="kea-results" class="card-body">
                            <div class="tab-content" id="nav-tabContent-kea">
                                <div class="tab-pane fade show active" id="nav-kea-bar" role="tabpanel"
                                     aria-labelledby="nav-kea-bar-tab">
                                    <div id="bargraph-kea" class="bargraph">
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
                        <!--                 <div class="download-buttons card-footer">
                                            <div class="row justify-content-end">
                                                <a onclick="exportJson(this, 'KEA', json_file['KEA']);">
                                                    <button type="button" class="btn btn-outline-secondary btn-sm">JSON</button>
                                                </a>
                                            </div>
                                        </div> -->
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