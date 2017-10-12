<!DOCTYPE html>
<html lang="en">
<head>
    <title>Results</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>

    <link rel="shortcut icon" href="static/favicon.ico" type="image/x-icon"/>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">

    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>


    <script src="https://d3js.org/d3.v4.min.js"></script>

    <!--Datatables-->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap4.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.4.2/css/buttons.bootstrap4.css"/>
    <link rel="stylesheet" type="text/css"
          href="https://cdn.datatables.net/fixedheader/3.1.3/css/fixedHeader.bootstrap4.css"/>
    <link rel="stylesheet" type="text/css"
          href="https://cdn.datatables.net/responsive/2.2.0/css/responsive.bootstrap4.css"/>

    <script type="text/javascript" src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.16/js/dataTables.bootstrap4.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.4.2/js/dataTables.buttons.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.4.2/js/buttons.bootstrap4.js"></script>
    <script type="text/javascript"
            src="https://cdn.datatables.net/fixedheader/3.1.3/js/dataTables.fixedHeader.js"></script>
    <script type="text/javascript"
            src="https://cdn.datatables.net/responsive/2.2.0/js/dataTables.responsive.js"></script>

    <!--From old results-->

    <script src="js/bargraph.js"></script>
    <script src="js/results.js"></script>
    <script src="js/network.js"></script>
    <script src="js/jquery.atooltip.pack.js"></script>

    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato:300,400,700">
    <link rel="stylesheet" href="css/results.css">
    <link rel="stylesheet" href="css/bargraph.css">
    <link rel="stylesheet" href="css/network.css">
    <link rel="stylesheet" href="css/atooltip.css">

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <!--Own-->
    <script> var json_file = ${json}; </script>
    <link rel="stylesheet" href="css/results.css">

</head>
<body>


<!--Header-->
<div id="logo">
    <a href="/X2K"><img id="logo-png" class="img-fluid mx-auto" src="static/logo.png"/></a>
    <p id="x2k_title">A web interface for the Expression to Kinases application</p>
</div>


<div class="container" id="results-dashboard">
    <div class="row justify-content-center">
        <!--X2K-->
        <div class="col-sm-6" id="tabs-x2k">
            <div class="desc">
                <p>Subnetwork of upstream transcription factors, intermediate proteins, and protein kinases.</p>
            </div>
            <ul>
                <li><a href="#x2k-network">Subnetwork</a></li>
            </ul>

            <!-- network -->
            <div id="x2k-network">
                <svg class="x2k-svg" width="480" height="300"></svg>
            </div>
            <div id="legend">
                <ul class="no_bullet">
                    <li class="legend">
                        <svg id="legend-dot" height="12" width="12">
                            <circle cx="6" cy="6" r="6" fill="#1F77B4"/>
                        </svg>
                        Kinase
                    </li>
                    <li class="legend">
                        <svg id="legend-dot" height="12" width="12">
                            <circle cx="6" cy="6" r="6" fill="#FF7F0E"/>
                        </svg>
                        Intermediate protein
                    </li>
                    <li class="legend">
                        <svg id="legend-dot" height="12" width="12">
                            <circle cx="6" cy="6" r="6" fill="#FF546D"/>
                        </svg>
                        Transcription Factor
                    </li>
                </ul>
            </div>
            <div id="download_buttons">
                <a id="exportData" onclick="exportJson(this, 'X2K', json_file['X2K']);">
                    <button type="button" id="download-button">JSON</button>
                </a>
                <!-- 		        <a id="exportData" onclick="svgExport('#x2k-network', 'X2K_network', 'jpg'); return false;">
                                    <button type="button" id="download-button">JPG</button>
                                </a>
                                <a id="exportData" onclick="svgExport('#x2k-network', 'X2K_network', 'png'); return false;">
                                    <button type="button" id="download-button">PNG</button>
                                </a>
                                <a id="exportData" onclick="svgExport('#x2k-network', 'X2K_network', 'svg'); return false;">
                                    <button type="button" id="download-button">SVG</button>
                                </a> -->
            </div>
        </div>

        <!--ChEA-->
        <div class="col-sm-6" id="tabs-chea">
            <div class="desc">
                <p>Top ten most enriched transcription factors as determined by ChEA or ENCODE.</p>
            </div>
            <ul>
                <li><a href="#bargraph-chea">Bargraph</a></li>
                <li><a href="#chea-table-wrap">Table</a></li>
            </ul>

            <!-- bargraph -->
            <div id="bargraph-chea" class="bargraph">
                <div id="label">
                    <input type="button" class="chea-chart-pvalue selected" value="P-value"/>
                    <input type="button" class="chea-chart-zscore" value="Z-score"/>
                    <input type="button" class="chea-chart-combinedScore" value="Combined score"/>
                </div>
                <svg class="chea-chart" width="480" height="300"></svg>
            </div>

            <!-- table -->
            <div id="chea" class="results-table">
                <div id="chea-table-wrap">
                    <table id="chea-table"></table>
                </div>
            </div>
            <div id="download_buttons">
                <a id="exportData" onclick="exportJson(this, 'ChEA', json_file['ChEA']);">
                    <button type="button" id="download-button">JSON</button>
                </a>
                <!--  		        <a id="exportData" onclick="svgExport('.chea-chart', 'ChEA_bargraph', 'jpg'); return false;">
                                    <button type="button" id="download-button">JPG</button>
                                </a>
                                <a id="exportData" onclick="svgExport('.chea-chart', 'ChEA_bargraph', 'png'); return false;">
                                    <button type="button" id="download-button">PNG</button>
                                </a>
                                <a id="exportData" onclick="svgExport('.chea-chart', 'ChEA_bargraph', 'svg'); return false;">
                                    <button type="button" id="download-button">SVG</button>
                                </a>     -->
            </div>
        </div>
    </div>
    <!--G2N-->
    <div class="row">
        <div class="col-sm-6" id="tabs-g2n">
            <div class="desc">
                <p>Subnetwork that connects the transcription factors using known protein-protein interactions.</p>
            </div>
            <ul>
                <li><a href="#g2n-network">Subnetwork</a></li>
            </ul>

            <!-- network -->
            <div id="network-g2n">
                <svg class="g2n-svg" width="480" height="300"></svg>
            </div>
            <div id="legend">
                <ul class="no_bullet">
                    <li class="legend">
                        <svg id="legend-dot" height="12" width="12">
                            <circle cx="6" cy="6" r="6" fill="#1F77B4"/>
                        </svg>
                        Seed Protein
                    </li>
                    <li class="legend">
                        <svg id="legend-dot" height="12" width="12">
                            <circle cx="6" cy="6" r="6" fill="#FF7F0E"/>
                        </svg>
                        Intermediate protein
                    </li>
                </ul>
            </div>
            <div id="download_buttons">
                <a id="exportData" onclick="exportJson(this, 'G2N', json_file['G2N']);">
                    <button type="button" id="download-button">JSON</button>
                </a>
                <!--  		        <a id="exportData" onclick="svgExport('#network-g2n', 'G2N_network', 'jpg'); return false;">
                                    <button type="button" id="download-button">JPG</button>
                                </a>
                                <a id="exportData" onclick="svgExport('#network-g2n', 'G2N_network', 'png'); return false;">
                                    <button type="button" id="download-button">PNG</button>
                                </a>
                                <a id="exportData" onclick="svgExport('#network-g2n', 'G2N_network', 'svg'); return false;">
                                    <button type="button" id="download-button">SVG</button> -->
                </a>
            </div>
        </div>

        <!--KEA-->
        <div class="col-sm-6" id="tabs-kea">
            <div class="desc">
                <p>Top ten most enriched protein kinases to regulate the subnetwork as determined by KEA.</p>
            </div>
            <ul>
                <li><a href="#bargraph-kea">Bargraph</a></li>
                <li><a href="#kea-table-wrap">Table</a></li>
            </ul>

            <!-- bargraph -->
            <div id="bargraph-kea" class="bargraph">
                <div id="label">
                    <input type="button" class="kea-chart-pvalue selected" value="P-value"/>
                    <input type="button" class="kea-chart-zscore" value="Z-score"/>
                    <input type="button" class="kea-chart-combinedScore" value="Combined score"/>
                </div>
                <svg class="kea-chart" width="480" height="300"></svg>
            </div>

            <!-- table -->
            <div id="kea" class="results-table">
                <div id="kea-table-wrap">
                    <table id="kea-table"></table>
                </div>
            </div>
            <div id="download_buttons">
                <a id="exportData" onclick="exportJson(this, 'KEA', json_file['KEA']);">
                    <button type="button" id="download-button">JSON</button>
                </a>
                <!--  		        <a id="exportData" onclick="svgExport('#bargraph-kea', 'KEA_bargraph', 'jpg'); return false;">
                                    <button type="button" id="download-button">JPG</button>
                                </a>
                                <a id="exportData" onclick="svgExport('#bargraph-kea', 'KEA_bargraph', 'png'); return false;">
                                    <button type="button" id="download-button">PNG</button>
                                </a>
                                <a id="exportData" onclick="svgExport('#bargraph-kea', 'KEA_bargraph', 'svg'); return false;">
                                    <button type="button" id="download-button">SVG</button>
                                </a> -->
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