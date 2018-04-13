<!DOCTYPE html>
<html lang="en">
<head>
    <title>X2K Web</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <link rel="shortcut icon" href="static/favicon.ico" type="image/x-icon"/>

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
    <link rel="stylesheet" href="dist/css/results_index.css">
    <link rel="stylesheet" href="dist/css/index_beta.css">

    <script src="dist/js/bargraph.js"></script>
    <script src="dist/js/results.js"></script>
    <script src="dist/js/results_index.js"></script>
    <script src="dist/js/network.js"></script>
    <script src="dist/js/index.js"></script>
    <script src="dist/js/ljp.js"></script>

    <!--GA-->
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

<body data-spy="scroll" data-target="#x2k-navbar" data-offset="150">
<!-- Anchor for scrollspy -->
<div id="x2k-scroll"></div>
<nav class="navbar navbar-light sticky-top bg-light justify-content-center navbar-expand-sm" id="x2k-navbar">
    <a class="navbar-brand" href="/X2K">
        <img id="logo" src="static/logo.png" height="50px" class="d-inline-block full-logo">
        <!-- <p class="caption">A web interface for the Expression to Kinases application</p> -->
    </a>
    <div id="scrollspy-nav" class="collapse navbar-collapse">
        <ul class="nav nav-pills">
            <li class="nav-item">
                <a class="nav-link active" href="#x2k-scroll">Submit</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#example">Example</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#api">API</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#case-studies">Case study</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#command-line">Command line tools</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#datasets">Download datasets</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#about">About</a>
            </li>
        </ul>
    </div>
</nav>

<div class="container-fluid">
    <div class="row justify-content-center bg-light">
        <div class="col-sm-9 show-on-ie" style="display: none; color: red; font-weight: bold; text-align:center;">
            For best app performance, please use a browser other than Internet Explorer.
        </div>
        <div class="col-sm-9 bg-white">
            <div class="my-3 mx-2">
                <h4>Submit</h4>
                <div class="my-3">
                    <p>
                        X2K Web is an online tool used to infer upstream regulatory
                        networks from differentially expressed genes. Combining the <a
                            href="http://amp.pharm.mssm.edu/Enrichr">ChEA</a>, Genes2Networks,
                        and <a href="http://amp.pharm.mssm.edu/Enrichr">KEA</a> apps
                        together, X2K Web produces inferred networks of transcription
                        factors, proteins, and kinases which take part in the upstream
                        regulation of the inputted gene list. X2K web also allows users to
                        analyze their differentially expressed gene lists using ChEA, G2N,
                        and KEA individually. You
                        can read more about X2K concept on the <a href="http://www.maayanlab.net/X2K/">X2K standalone
                        version website</a>.
                    </p>
                </div>
                <form id="x2k-form" enctype="multipart/form-data" method="POST">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-6 my-2">
                                <label for="genelist">Gene list (<a href="javascript:void(0)"
                                                                    onclick="insertExample();"
                                                                    id="example-link">insert
                                    an example</a>)</label>
                                <textarea class="form-control form-control-sm" id="genelist" rows="12"
                                          name="text-genes"></textarea>
                                          <span id="gene-count" style="color: darkgrey; font-size: 0.9rem;"></span>
                                          <br/>
                                          <span id="warning" style="color: coral; font-size: 0.8rem;"></span>
                                <!--Buttons-->
                                <div class="my-3">
                                    <button type="submit" class="btn btn-outline-primary btn-sm" id="results_submit" disabled>
                                        Submit
                                    </button>
                                </div>

                                <!--Settings-->
                                <div id="settings-accordion" role="tablist" class="my-1">
                                    <div class="card">
                                        <div class="card-header py-1 border-0  bg-white" role="tab" id="settings-acc">
                                            <a data-toggle="collapse" href="#settings" aria-expanded="true"
                                               aria-controls="settings">
                                                Advanced Settings
                                            </a>
                                        </div>

                                        <div id="settings" class="collapse" role="tabpanel"
                                             aria-labelledby="settings-acc" data-parent="#accordion">
                                            <div class="card-body">
                                                <div id="accordion" role="tablist">

                                                    <!--X2K-->
                                                    <div class="card my-1">
                                                        <div class="card-header py-1 border-0" role="tab"
                                                             id="x2k-settings">
                                                            <a data-toggle="collapse" href="#x2k-collapse"
                                                               aria-expanded="true" aria-controls="x2k-collapse">
                                                                X2K
                                                            </a>
                                                        </div>
                                                        <div id="x2k-collapse" class="collapse" role="tabpanel"
                                                             aria-labelledby="x2k-settings" data-parent="#accordion">
                                                            <div class="card-body">
                                                                <div class="form-group row align-items-center">
                                                                    <label for="min_network_size"
                                                                           class="col-form-label col-sm-9">Minimum
                                                                        number of proteins in subnetwork</label>
                                                                    <div class="col-sm-3">
                                                                        <input class="form-control form-control-sm"
                                                                               type="text" value="30"
                                                                               id="min_network_size"
                                                                               name="min_network_size">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group row align-items-center"
                                                                     style="display:none">
                                                                    <label for="number_of_results"
                                                                           class="col-form-label col-sm-9">Number of
                                                                        results</label>
                                                                    <div class="col-sm-3">
                                                                        <input class="form-control form-control-sm"
                                                                               type="text" value="500"
                                                                               id="number_of_results"
                                                                               name="number_of_results">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!--ChEA-->
                                                    <div class="card my-1">
                                                        <div class="card-header py-1 border-0" role="tab"
                                                             id="chea-x2k-settings">
                                                            <a class="collapsed" data-toggle="collapse"
                                                               href="#chea-x2k-collapse" aria-expanded="false"
                                                               aria-controls="chea-x2k-collapse">
                                                                ChEA
                                                            </a>
                                                        </div>
                                                        <div id="chea-x2k-collapse" class="collapse" role="tabpanel"
                                                             aria-labelledby="chea-x2k-settings"
                                                             data-parent="#accordion">
                                                            <div class="card-body">
                                                                <div class="form-group" id="chea-x2k-sorting">
                                                                    <div class="row align-items-center">
                                                                        <label class="col-form-label col-sm-5">Sort
                                                                            by</label>
                                                                        <div class="col-sm-7">
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="radio"
                                                                                           name="sort transcription factors by"
                                                                                           id="chea-x2k-pvalue"
                                                                                           value="p-value" checked>
                                                                                    p-value
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="radio"
                                                                                           name="sort transcription factors by"
                                                                                           id="chea-x2k-rank"
                                                                                           value="rank">
                                                                                    rank
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="radio"
                                                                                           name="sort transcription factors by"
                                                                                           id="chea-x2k-combscore"
                                                                                           value="combined score">
                                                                                    combined score
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <hr/>
                                                                <div class="form-group" id="chea-x2k-species">
                                                                    <div class="row align-items-center">
                                                                        <label class="col-form-label col-sm-5">Background
                                                                            organism</label>
                                                                        <div class="col-sm-7">
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="radio"
                                                                                           name="included organisms in the background database"
                                                                                           id="chea-x2k-human"
                                                                                           value="human">
                                                                                    human
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="radio"
                                                                                           name="included organisms in the background database"
                                                                                           id="chea-x2k-mouse"
                                                                                           value="mouse">
                                                                                    mouse
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="radio"
                                                                                           name="included organisms in the background database"
                                                                                           id="chea-x2k-both"
                                                                                           value="both" checked>
                                                                                    both
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <hr/>
                                                                <div class="form-group" id="chea-x2k-tfdb">
                                                                    <div class="row align-items-center">
                                                                        <label class="col-form-label col-sm-5">Transcription
                                                                            factor database</label>
                                                                        <div class="col-sm-7">
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="radio"
                                                                                           name="TF-target gene background database used for enrichment"
                                                                                           id="x2k_chea2015"
                                                                                           value="ChEA 2015" checked>
                                                                                    ChEA 2015
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="radio"
                                                                                           name="TF-target gene background database used for enrichment"
                                                                                           id="x2k_encode2015"
                                                                                           value="ENCODE 2015">
                                                                                    ENCODE 2015
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="radio"
                                                                                           name="TF-target gene background database used for enrichment"
                                                                                           id="x2k_chea-encode"
                                                                                           value="ChEA & ENCODE Consensus">
                                                                                    ChEA & ENCODE Consensus
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="radio"
                                                                                           name="TF-target gene background database used for enrichment"
                                                                                           id="x2k_transfac-jaspar"
                                                                                           value="Transfac and Jaspar">
                                                                                    Transfac & Jaspar
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!--G2N-->
                                                    <div class="card my-1">
                                                        <div class="card-header py-1 border-0" role="tab"
                                                             id="g2n-x2k-settings">
                                                            <a class="collapsed" data-toggle="collapse"
                                                               href="#g2n-x2k-collapse" aria-expanded="false"
                                                               aria-controls="g2n-x2k-collapse">
                                                                G2N
                                                            </a>
                                                        </div>
                                                        <div id="g2n-x2k-collapse" class="collapse" role="tabpanel"
                                                             aria-labelledby="g2n-x2k-settings"
                                                             data-parent="#accordion">
                                                            <div class="card-body">

                                                                <div class="form-group row align-items-center">
                                                                    <label for="x2k_path_length"
                                                                           class="col-form-label col-sm-9">Path
                                                                        length</label>
                                                                    <div class="col-sm-3">
                                                                        <input class="form-control form-control-sm"
                                                                               type="text" value="2"
                                                                               id="x2k_path_length" name="path_length">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group row align-items-center">
                                                                    <label for="x2k_min_number_of_articles_supporting_interaction"
                                                                           class="col-form-label col-sm-9">Minimum
                                                                        number of articles</label>
                                                                    <div class="col-sm-3">
                                                                        <input class="form-control form-control-sm"
                                                                               type="text" value="2"
                                                                               id="x2k_min_number_of_articles_supporting_interaction"
                                                                               name="min_number_of_articles_supporting_interaction">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group row align-items-center">
                                                                    <label for="x2k_max_number_of_interactions_per_protein"
                                                                           class="col-form-label col-sm-9">Maximum
                                                                        number of interactions per protein</label>
                                                                    <div class="col-sm-3">
                                                                        <input class="form-control form-control-sm"
                                                                               type="text" value="200"
                                                                               id="x2k_max_number_of_interactions_per_protein"
                                                                               name="max_number_of_interactions_per_protein">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group row align-items-center">
                                                                    <label for="x2k_max_number_of_interactions_per_article"
                                                                           class="col-form-label col-sm-9">Maximum
                                                                        number of interactions per article</label>
                                                                    <div class="col-sm-3">
                                                                        <input class="form-control form-control-sm"
                                                                               type="text" value="100"
                                                                               id="x2k_max_number_of_interactions_per_article"
                                                                               name="max_number_of_interactions_per_article">
                                                                    </div>
                                                                </div>
                                                                <hr/>
                                                                <div class="form-group" id="g2n-x2k-ppi">
                                                                    <label>PPI Networks</label>
                                                                    <div class="row">
                                                                        <div class="col-sm-4">
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="checkbox"
                                                                                           name="enable_Biocarta"
                                                                                           value="true" checked>
                                                                                    Biocarta
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="checkbox"
                                                                                           name="enable_BioGRID"
                                                                                           value="true" checked>
                                                                                    BioGRID 2017
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="checkbox"
                                                                                           name="enable_BioPlex"
                                                                                           value="true" checked>
                                                                                    BioPlex
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="checkbox"
                                                                                           name="enable_DIP"
                                                                                           value="true" checked>
                                                                                    DIP 2017
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-sm-4">
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="checkbox"
                                                                                           name="enable_huMAP"
                                                                                           value="true" checked>
                                                                                    huMAP 2017
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="checkbox"
                                                                                           name="enable_InnateDB"
                                                                                           value="true" checked>
                                                                                    InnateDB 2017
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="checkbox"
                                                                                           name="enable_IntAct"
                                                                                           value="true" checked>
                                                                                    IntAct 2017
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="checkbox"
                                                                                           name="enable_KEGG"
                                                                                           value="true" checked>
                                                                                    KEGG
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-sm-4">
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="checkbox"
                                                                                           name="enable_MINT"
                                                                                           value="true" checked>
                                                                                    MINT 2017
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="checkbox"
                                                                                           name="enable_ppid"
                                                                                           value="true" checked>
                                                                                    ppid
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="checkbox"
                                                                                           name="enable_SNAVI"
                                                                                           value="true" checked>
                                                                                    SNAVI 2017
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="checkbox"
                                                                                           name="enable_iREF"
                                                                                           value="false">
                                                                                    iREF 2017
                                                                                </label>
                                                                            </div>                                                                            
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!--KEA-->
                                                    <div class="card  my-1">
                                                        <div class="card-header py-1 border-0" role="tab"
                                                             id="kea-x2k-settings">
                                                            <a class="collapsed" data-toggle="collapse"
                                                               href="#kea-x2k-collapse" aria-expanded="false"
                                                               aria-controls="kea-x2k-collapse">
                                                                KEA
                                                            </a>
                                                        </div>
                                                        <div id="kea-x2k-collapse" class="collapse" role="tabpanel"
                                                             aria-labelledby="kea-x2k-settings"
                                                             data-parent="#accordion">
                                                            <div class="card-body">
                                                                <div class="form-group">
                                                                    <div class="row align-items-center">
                                                                        <label class="col-form-label col-sm-5">Sort
                                                                            by</label>
                                                                        <div class="col-sm-7" id="kea-x2k-sorting">
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="radio"
                                                                                           name="sort kinases by"
                                                                                           id="kea-x2k-pvalue"
                                                                                           value="p-value" checked>
                                                                                    p-value
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="radio"
                                                                                           name="sort kinases by"
                                                                                           id="kea-x2k-rank"
                                                                                           value="rank">
                                                                                    rank
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input"
                                                                                           type="radio"
                                                                                           name="sort kinases by"
                                                                                           id="kea-x2k-combscore"
                                                                                           value="combined score">
                                                                                    combined score
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-6 my-5">
                                <p id="x2k-desc" class="desc">
                                    Enter a list of differentially expressed genes to receive results for:
                                <ol>
                                    <li>Putative enriched transcription factors through <a
                                            href="https://www.ncbi.nlm.nih.gov/pubmed/20709693">ChIP-x enrichment
                                        analysis (ChEA)</a>.
                                    </li>
                                    <li>Protein–protein interactions subnetwork that connects the input genes using <a
                                            href="https://www.ncbi.nlm.nih.gov/pubmed/17916244">Genes2Networks (G2N)</a>.
                                    </li>
                                    <li>Ranked list of kinases based on known kinase–substrate phosphorylation data from
                                        <a href="https://www.ncbi.nlm.nih.gov/pubmed/19176546">kinase enrichment
                                            analysis (KEA)</a>.
                                    </li>
                                    <li>Complete upstream pathway that connects the enriched transcription factors to
                                        kinases through known protein-protein interactions via <a
                                                href="https://www.ncbi.nlm.nih.gov/pubmed/22080467">the
                                            Expression2Kinases (X2K) algorithm</a>.
                                    </li>
                                </ol>
                                </p>
                                <p id="chea-desc" class="desc" style="display: none;">
                                    ChEA identifies upstream transcription factors. It uses
                                    gene set enrichment for transcription factors likely to bind at the promoters of the
                                    differentilly expressed genes based on integration of publicly available ChIP-seq
                                    data.
                                </p>
                                <p id="g2n-desc" class="desc" style="display: none;">
                                    G2N generates protein-protein interaction network of input transcription factors
                                    connected with each other by using known protein-protein interactions.
                                </p>
                                <p id="kea-desc" class="desc" style="display: none;">
                                    KEA uses kinase-substrate libraries to predict
                                    protein kinases connected to intermediate proteins and transcription factors
                                    that putatively regulate the observed changes in mRNA expression and perform kinase
                                    enrichment
                                    analysis.
                                </p>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div id="example">
                <h4>Example</h4>
                <%@ include file="/templates/dashboard.jsp" %>
            </div>
            <!--<div id="about" class="my-5">-->
            <!--<h4>About</h4>-->
            <!--<p>-->
            <!--X2K Web is an online tool used to infer upstream regulatory-->
            <!--networks from differentially expressed genes. Combining the <a-->
            <!--href="http://amp.pharm.mssm.edu/Enrichr">ChEA</a>, Genes2Networks,-->
            <!--and <a href="http://www.maayanlab.net/KEA2/">KEA</a> apps-->
            <!--together, X2K Web produces inferred networks of transcription-->
            <!--factors, proteins, and kinases which take part in the upstream-->
            <!--regulation of the inputted gene list. X2K web also allows users to-->
            <!--analyze their differentially expressed gene lists using ChEA, G2N,-->
            <!--and KEA individually. To read more about the concept of X2K, you-->
            <!--can read about it <a href="http://www.maayanlab.net/X2K/">here</a>.-->
            <!--</p>-->

            <!--<h4>Instructional Video</h4>-->

            <!--<iframe width="560" height="315" src="https://www.youtube.com/embed/ipchvqQhdpc" frameborder="0"-->
            <!--allowfullscreen></iframe>-->
            <!--</div>-->
            <div id="api">
                <h4>API</h4>
                <div class="row">
                    <div class="col-sm-12 text-left my-3 table-responsive">

                        <table class="table table-sm">
                            <thead>
                            <tr>
                                <th>Form field</th>
                                <th>Value</th>
                                <th>Example</th>
                            </tr>
                            </thead>

                            <tbody>
                            <tr>
                                <td class="align-middle">text-genes</td>
                                <td>Newline separated Entrez ids</td>
                                <td><textarea readonly rows=7 disabled>
    Nsun3
    Polrmt
    Nlrx1
    Sfxn5
    Zc3h12c
    Slc25a39
    Arsg
    Defb29
    Ndufb6
    Zfand1
    Tmem77
    5730403B10Rik
    RP23-195K8.6
    Tlcd1
    Psmc6
    Slc30a6
    LOC100047292
    Lrrc40
    Orc5l
    Mpp7
    Unc119b
    Prkaca
    Tcn2
    Psmc3ip
    Pcmtd2
    Acaa1a
    Lrrc1
    2810432D09Rik
    Sephs2
    Sac3d1
    Tmlhe
    LOC623451
    Tsr2
    Plekha7
    Gys2
    Arhgef12
    Hibch
    Lyrm2
    Zbtb44
    Entpd5
    Rab11fip2
    Lipt1
    Intu
    Anxa13
    Klf12
    Sat2
    Gal3st2
    Vamp8
    Fkbpl
    Aqp11
    Trap1
    Pmpcb
    Tm7sf3
    Rbm39
    Bri3
    Kdr
    Zfp748
    Nap1l1
    Dhrs1
    Lrrc56
    Wdr20a
    Stxbp2
    Klf1
    Ufc1
    Ccdc16
    9230114K14Rik
    Rwdd3
    2610528K11Rik
    Aco1
    Cables1
    LOC100047214
    Yars2
    Lypla1
    Kalrn
    Gyk
    Zfp787
    Zfp655
    Rabepk
    Zfp650
    4732466D17Rik
    Exosc4
    Wdr42a
    Gphn
    2610528J11Rik
    1110003E01Rik
    Mdh1
    1200014M14Rik
    AW209491
    Mut
    1700123L14Rik
    2610036D13Rik
    Cox15
    Tmem30a
    Nsmce4a
    Tm2d2
    Rhbdd3
    Atxn2
    Nfs1
    3110001I20Rik
    BC038156
    LOC100047782
    2410012H22Rik
    Rilp
    A230062G08Rik
    Pttg1ip
    Rab1
    Afap1l1
    Lyrm5
    2310026E23Rik
    C330002I19Rik
    Zfyve20
    Poli
    Tomm70a
    Slc7a6os
    Mat2b
    4932438A13Rik
    Lrrc8a
    Smo
    Nupl2
    Trpc2
    Arsk
    D630023B12Rik
    Mtfr1
    5730414N17Rik
    Scp2
    Zrsr1
    Nol7
    C330018D20Rik
    Ift122
    LOC100046168
    D730039F16Rik
    Scyl1
    1700023B02Rik
    1700034H14Rik
    Fbxo8
    Paip1
    Tmem186
    Atpaf1
    LOC100046254
    LOC100047604
    Coq10a
    Fn3k
    Sipa1l1
    Slc25a16
    Slc25a40
    Rps6ka5
    Trim37
    Lrrc61
    Abhd3
    Gbe1
    Parp16
    Hsd3b2
    Esm1
    Dnajc18
    Dolpp1
    Lass2
    Wdr34
    Rfesd
    Cacnb4
    2310042D19Rik
    Srr
    Bpnt1
    6530415H11Rik
    Clcc1
    Tfb1m
    4632404H12Rik
    D4Bwg0951e
    Med14
    Adhfe1
    Thtpa
    Cat
    Ell3
    Akr7a5
    Mtmr14
    Timm44
    Sf1
    Ipp
    Iah1
    Trim23
    Wdr89
    Gstz1
    Cradd
    2510006D16Rik
    Fbxl6
    LOC100044400
    Zfp106
    Cd55
    0610013E23Rik
    Afmid
    Tmem86a
    Aldh6a1
    Dalrd3
    Smyd4
    Nme7
    Fars2
    Tasp1
    Cldn10
    A930005H10Rik
    Slc9a6
    Adk
    Rbks
    2210016F16Rik
    Vwce
    4732435N03Rik
    Zfp11
    Vldlr
    9630013D21Rik
    4933407N01Rik
    Fahd1
    Mipol1
    1810019D21Rik
    1810049H13Rik
    Tfam
    Paics
    1110032A03Rik
    LOC100044139
    Dnajc19
    BC016495
    A930041I02Rik
    Rqcd1
    Usp34
    Zcchc3
    H2afj
    Phf7
    4921508D12Rik
    Kmo
    Prpf18
    Mcat
    Txndc4
    4921530L18Rik
    Vps13b
    Scrn3
    Tor1a
    AI316807
    Acbd4
    Fah
    Apool
    Col4a4
    Lrrc19
    Gnmt
    Nr3c1
    Sip1
    Ascc1
    Fech
    Abhd14a
    Arhgap18
    2700046G09Rik
    Yme1l1
    Gk5
    Glo1
    Sbk1
    Cisd1
    2210011C24Rik
    Nxt2
    Notum
    Ankrd42
    Ube2e1
    Ndufv1
    Slc33a1
    Cep68
    Rps6kb1
    Hyi
    Aldh1a3
    Mynn
    3110048L19Rik
    Rdh14
    Proz
    Gorasp1
    LOC674449
    Zfp775
    5430437P03Rik
    Npy
    Adh5
    Sybl1
    4930432O21Rik
    Nat9
    LOC100048387
    Mettl8
    Eny2
    2410018G20Rik
    Pgm2
    Fgfr4
    Mobkl2b
    Atad3a
    4932432K03Rik
    Dhtkd1
    Ubox5
    A530050D06Rik
    Zdhhc5
    Mgat1
    Nudt6
    Tpmt
    Wbscr18
    LOC100041586
    Cdk5rap1
    4833426J09Rik
    Myo6
    Cpt1a
    Gadd45gip1
    Tmbim4
    2010309E21Rik
    Asb9
    2610019F03Rik
    7530414M10Rik
    Atp6v1b2
    2310068J16Rik
    Ddt
    Klhdc4
    Hpn
    Lifr
    Ovol1
    Nudt12
    Cdan1
    Fbxo9
    Fbxl3
    Hoxa7
    Aldh8a1
    3110057O12Rik
    Abhd11
    Psmb1
    ENSMUSG00000074286
    Chpt1
    Oxsm
    2310009A05Rik
    1700001L05Rik
    Zfp148
    39509
    Mrpl9
    Tmem80
    9030420J04Rik
    Naglu
    Plscr2
    Agbl3
    Pex1
    Cno
    Neo1
    Asf1a
    Tnfsf5ip1
    Pkig
    AI931714
    D130020L05Rik
    Cntd1
    Clec2h
    Zkscan1
    1810044D09Rik
    Mettl7a
    Siae
    Fbxo3
    Fzd5
    Tmem166
    Tmed4
    Gpr155
    Rnf167
    Sptlc1
    Riok2
    Tgds
    Pms1
    Pitpnc1
    Pcsk7
    4933403G14Rik
    Ei24
    Crebl2
    Tln1
    Mrpl35
    2700038C09Rik
    Ubie
    Osgepl1
    2410166I05Rik
    Wdr24
    Ap4s1
    Lrrc44
    B3bp
    Itfg1
    Dmxl1
    C1d
                </textarea></td>
                            </tr>
                            <tr>
                                <td class="align-middle" rowspan="3">included_organisms</td>
                                <td>'human_only'</td>
                                <td rowspan="3" class="align-middle">'human_only'</td>
                            </tr>
                            <tr>
                                <td>'mouse_only'</td>
                            </tr>
                            <tr>
                                <td>'both'</td>
                            </tr>
                            <tr>
                                <td rowspan="4" class="align-middle">included_database
                                    <div class="api-note">(choose one)</div>
                                </td>
                                <td>'ChEA 2015'</td>
                                <td rowspan="4" class="align-middle">ChEA 2015</td>
                            </tr>
                            <tr>
                                <td>'Transfac and Jaspar'</td>
                            </tr>
                            <tr>
                                <td>'ChEA &amp; ENCODE Consensus'</td>
                            </tr>
                            <tr>
                                <td>'ENCODE 2015'</td>
                            </tr>
                            <tr>
                                <td>path_length</td>
                                <td>integer</td>
                                <td>2</td>
                            </tr>
                            <tr>
                                <td>min_network_size</td>
                                <td>integer</td>
                                <td>50</td>
                            </tr>
                            <tr>
                                <td>min_number_of_articles_supporting_interaction</td>
                                <td>integer</td>
                                <td>2</td>
                            </tr>
                            <tr>
                                <td>max_number_of_interactions_per_protein</td>
                                <td>integer</td>
                                <td>200</td>
                            </tr>
                            <tr>
                                <td>max_number_of_interactions_per_article</td>
                                <td>integer</td>
                                <td>100</td>
                            </tr>
                            <tr>
                                <td>biocarta</td>
                                <td>boolean</td>
                                <td>true</td>
                            </tr>
                            <tr>
                                <td>biogrid</td>
                                <td>boolean</td>
                                <td>true</td>
                            </tr>
                            <tr>
                                <td>dip</td>
                                <td>boolean</td>
                                <td>true</td>
                            </tr>
                            <tr>
                                <td>innatedb</td>
                                <td>boolean</td>
                                <td>true</td>
                            </tr>
                            <tr>
                                <td>intact</td>
                                <td>boolean</td>
                                <td>true</td>
                            </tr>
                            <tr>
                                <td>kegg</td>
                                <td>boolean</td>
                                <td>true</td>
                            </tr>
                            <tr>
                                <td>mint</td>
                                <td>boolean</td>
                                <td>true</td>
                            </tr>
                            <tr>
                                <td>ppid</td>
                                <td>boolean</td>
                                <td>true</td>
                            </tr>
                            <tr>
                                <td>snavi</td>
                                <td>boolean</td>
                                <td>true</td>
                            </tr>
                            <tr>
                                <td>number_of_results</td>
                                <td>integer</td>
                                <td>50</td>
                            </tr>
                            <tr>
                                <td rowspan="3" class="align-middle">sort_tfs_by
                                    <div class="api-note">(choose one)</div>
                                </td>
                                <td>'combined score'</td>
                                <td rowspan="3" class="align-middle">'combined score'</td>
                            </tr>
                            <tr>
                                <td>'pvalue'</td>
                            </tr>
                            <tr>
                                <td>'rank'</td>
                            </tr>
                            <tr>
                                <td rowspan="3" class="align-middle">sort_kinases_by
                                    <div class="api-note">(choose one)</div>
                                </td>
                                <td>'combined score'</td>
                                <td rowspan="3" class="align-middle">'combined score'</td>
                            </tr>
                            <tr>
                                <td>'pvalue'</td>
                            </tr>
                            <tr>
                                <td>'rank'</td>
                            </tr>
                            </tbody>
                        </table>

                        <div id="api-example" class="">
                            <div class="row">
                                <div class="card col-sm-6 my-1">
                                    <div class="panel-group" id="accordion-api" role="tablist"
                                         aria-multiselectable="true">
                                        <div class="panel panel-default">
                                            <div class="panel-heading" role="tab" id="heading1">
                                                <a class="collapsed" data-toggle="collapse" data-parent="#accordion"
                                                   href="#collapse1"
                                                   aria-expanded="false" aria-controls="collapse1">
                                                    JavaScript
                                                </a>
                                            </div>
                                            <div id="collapse1" class="panel-collapse collapse" role="tabpanel"
                                                 aria-labelledby="heading1">
                                                <div class="panel-body">
                                        <pre><code class="javascript">var form = new FormData();
form.append("text-genes", "Nsun3\nPolrmt\nNlrx1\nSfxn5\nZc3h12c\nSlc25a39\nArsg\nDefb29\nNdufb6\nZfand1\nTmem77\n5730403B10Rik\nRP23-195K8.6\nTlcd1\nPsmc6\nSlc30a6\nLOC100047292\nLrrc40\nOrc5l\nMpp7\nUnc119b\nPrkaca\nTcn2\nPsmc3ip\nPcmtd2\nAcaa1a\nLrrc1\n2810432D09Rik\nSephs2\nSac3d1\nTmlhe\nLOC623451\nTsr2\nPlekha7\nGys2\nArhgef12\nHibch\nLyrm2\nZbtb44\nEntpd5\nRab11fip2\nLipt1\nIntu\nAnxa13\nKlf12\nSat2\nGal3st2\nVamp8\nFkbpl\nAqp11\nTrap1\nPmpcb\nTm7sf3\nRbm39\nBri3\nKdr\nZfp748\nNap1l1\nDhrs1\nLrrc56\nWdr20a\nStxbp2\nKlf1\nUfc1\nCcdc16\n9230114K14Rik\nRwdd3\n2610528K11Rik\nAco1\nCables1\nLOC100047214\nYars2\nLypla1\nKalrn\nGyk\nZfp787\nZfp655\nRabepk\nZfp650\n4732466D17Rik\nExosc4\nWdr42a\nGphn\n2610528J11Rik\n1110003E01Rik\nMdh1\n1200014M14Rik\nAW209491\nMut\n1700123L14Rik\n2610036D13Rik\nCox15\nTmem30a\nNsmce4a\nTm2d2\nRhbdd3\nAtxn2\nNfs1\n3110001I20Rik\nBC038156\nLOC100047782\n2410012H22Rik\nRilp\nA230062G08Rik\nPttg1ip\nRab1\nAfap1l1\nLyrm5\n2310026E23Rik\nC330002I19Rik\nZfyve20\nPoli\nTomm70a\nSlc7a6os\nMat2b\n4932438A13Rik\nLrrc8a\nSmo\nNupl2\nTrpc2\nArsk\nD630023B12Rik\nMtfr1\n5730414N17Rik\nScp2\nZrsr1\nNol7\nC330018D20Rik\nIft122\nLOC100046168\nD730039F16Rik\nScyl1\n1700023B02Rik\n1700034H14Rik\nFbxo8\nPaip1\nTmem186\nAtpaf1\nLOC100046254\nLOC100047604\nCoq10a\nFn3k\nSipa1l1\nSlc25a16\nSlc25a40\nRps6ka5\nTrim37\nLrrc61\nAbhd3\nGbe1\nParp16\nHsd3b2\nEsm1\nDnajc18\nDolpp1\nLass2\nWdr34\nRfesd\nCacnb4\n2310042D19Rik\nSrr\nBpnt1\n6530415H11Rik\nClcc1\nTfb1m\n4632404H12Rik\nD4Bwg0951e\nMed14\nAdhfe1\nThtpa\nCat\nEll3\nAkr7a5\nMtmr14\nTimm44\nSf1\nIpp\nIah1\nTrim23\nWdr89\nGstz1\nCradd\n2510006D16Rik\nFbxl6\nLOC100044400\nZfp106\nCd55\n0610013E23Rik\nAfmid\nTmem86a\nAldh6a1\nDalrd3\nSmyd4\nNme7\nFars2\nTasp1\nCldn10\nA930005H10Rik\nSlc9a6\nAdk\nRbks\n2210016F16Rik\nVwce\n4732435N03Rik\nZfp11\nVldlr\n9630013D21Rik\n4933407N01Rik\nFahd1\nMipol1\n1810019D21Rik\n1810049H13Rik\nTfam\nPaics\n1110032A03Rik\nLOC100044139\nDnajc19\nBC016495\nA930041I02Rik\nRqcd1\nUsp34\nZcchc3\nH2afj\nPhf7\n4921508D12Rik\nKmo\nPrpf18\nMcat\nTxndc4\n4921530L18Rik\nVps13b\nScrn3\nTor1a\nAI316807\nAcbd4\nFah\nApool\nCol4a4\nLrrc19\nGnmt\nNr3c1\nSip1\nAscc1\nFech\nAbhd14a\nArhgap18\n2700046G09Rik\nYme1l1\nGk5\nGlo1\nSbk1\nCisd1\n2210011C24Rik\nNxt2\nNotum\nAnkrd42\nUbe2e1\nNdufv1\nSlc33a1\nCep68\nRps6kb1\nHyi\nAldh1a3\nMynn\n3110048L19Rik\nRdh14\nProz\nGorasp1\nLOC674449\nZfp775\n5430437P03Rik\nNpy\nAdh5\nSybl1\n4930432O21Rik\nNat9\nLOC100048387\nMettl8\nEny2\n2410018G20Rik\nPgm2\nFgfr4\nMobkl2b\nAtad3a\n4932432K03Rik\nDhtkd1\nUbox5\nA530050D06Rik\nZdhhc5\nMgat1\nNudt6\nTpmt\nWbscr18\nLOC100041586\nCdk5rap1\n4833426J09Rik\nMyo6\nCpt1a\nGadd45gip1\nTmbim4\n2010309E21Rik\nAsb9\n2610019F03Rik\n7530414M10Rik\nAtp6v1b2\n2310068J16Rik\nDdt\nKlhdc4\nHpn\nLifr\nOvol1\nNudt12\nCdan1\nFbxo9\nFbxl3\nHoxa7\nAldh8a1\n3110057O12Rik\nAbhd11\nPsmb1\nENSMUSG00000074286\nChpt1\nOxsm\n2310009A05Rik\n1700001L05Rik\nZfp148\n39509\nMrpl9\nTmem80\n9030420J04Rik\nNaglu\nPlscr2\nAgbl3\nPex1\nCno\nNeo1\nAsf1a\nTnfsf5ip1\nPkig\nAI931714\nD130020L05Rik\nCntd1\nClec2h\nZkscan1\n1810044D09Rik\nMettl7a\nSiae\nFbxo3\nFzd5\nTmem166\nTmed4\nGpr155\nRnf167\nSptlc1\nRiok2\nTgds\nPms1\nPitpnc1\nPcsk7\n4933403G14Rik\nEi24\nCrebl2\nTln1\nMrpl35\n2700038C09Rik\nUbie\nOsgepl1\n2410166I05Rik\nWdr24\nAp4s1\nLrrc44\nB3bp\nItfg1\nDmxl1\nC1d");
form.append("included_organisms", "both");
form.append("included_database", "ChEA 2015");
form.append("path_length", "2");
form.append("minimum network size", "50");
form.append("min_number_of_articles_supporting_interaction", "2");
form.append("max_number_of_interactions_per_protein", "200");
form.append("max_number_of_interactions_per_article", "100");
form.append("biocarta", "true");
form.append("biogrid", "true");
form.append("dip", "true");
form.append("innatedb", "true");
form.append("intact", "true");
form.append("kegg", "true");
form.append("mint", "true");
form.append("ppid", "true");
form.append("snavi", "true");
form.append("number_of_results", "50");
form.append("sort_tfs_by", "combined score");
form.append("sort_kinases_by", "combined score");

var settings = {
  "async": true,
  "crossDomain": true,
  "url": "http://amp.pharm.mssm.edu/X2K/api",
  "method": "POST",
  "headers": {
    "cache-control": "no-cache",
  },
  "processData": false,
  "contentType": false,
  "mimeType": "multipart/form-data",
  "data": form
}

$.ajax(settings).done(function (response) {
  console.log(response);
});</code></pre>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="card col-sm-6 my-1">
                                    <div class="panel panel-default">
                                        <div class="panel-heading" role="tab" id="heading2">
                                            <a class="collapsed" data-toggle="collapse" data-parent="#accordion"
                                               href="#collapse2"
                                               aria-expanded="false" aria-controls="collapse2">
                                                Python
                                            </a>
                                        </div>
                                        <div id="collapse2" class="panel-collapse collapse" role="tabpanel"
                                             aria-labelledby="heading2">
                                            <div class="panel-body">
                                        <pre><code class="python">import http.client

conn = http.client.HTTPConnection("amp.pharm.mssm.edu")

payload = "------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"text-genes\"\r\n\r\nNsun3\nPolrmt\nNlrx1\nSfxn5\nZc3h12c\nSlc25a39\nArsg\nDefb29\nNdufb6\nZfand1\nTmem77\n5730403B10Rik\nRP23-195K8.6\nTlcd1\nPsmc6\nSlc30a6\nLOC100047292\nLrrc40\nOrc5l\nMpp7\nUnc119b\nPrkaca\nTcn2\nPsmc3ip\nPcmtd2\nAcaa1a\nLrrc1\n2810432D09Rik\nSephs2\nSac3d1\nTmlhe\nLOC623451\nTsr2\nPlekha7\nGys2\nArhgef12\nHibch\nLyrm2\nZbtb44\nEntpd5\nRab11fip2\nLipt1\nIntu\nAnxa13\nKlf12\nSat2\nGal3st2\nVamp8\nFkbpl\nAqp11\nTrap1\nPmpcb\nTm7sf3\nRbm39\nBri3\nKdr\nZfp748\nNap1l1\nDhrs1\nLrrc56\nWdr20a\nStxbp2\nKlf1\nUfc1\nCcdc16\n9230114K14Rik\nRwdd3\n2610528K11Rik\nAco1\nCables1\nLOC100047214\nYars2\nLypla1\nKalrn\nGyk\nZfp787\nZfp655\nRabepk\nZfp650\n4732466D17Rik\nExosc4\nWdr42a\nGphn\n2610528J11Rik\n1110003E01Rik\nMdh1\n1200014M14Rik\nAW209491\nMut\n1700123L14Rik\n2610036D13Rik\nCox15\nTmem30a\nNsmce4a\nTm2d2\nRhbdd3\nAtxn2\nNfs1\n3110001I20Rik\nBC038156\nLOC100047782\n2410012H22Rik\nRilp\nA230062G08Rik\nPttg1ip\nRab1\nAfap1l1\nLyrm5\n2310026E23Rik\nC330002I19Rik\nZfyve20\nPoli\nTomm70a\nSlc7a6os\nMat2b\n4932438A13Rik\nLrrc8a\nSmo\nNupl2\nTrpc2\nArsk\nD630023B12Rik\nMtfr1\n5730414N17Rik\nScp2\nZrsr1\nNol7\nC330018D20Rik\nIft122\nLOC100046168\nD730039F16Rik\nScyl1\n1700023B02Rik\n1700034H14Rik\nFbxo8\nPaip1\nTmem186\nAtpaf1\nLOC100046254\nLOC100047604\nCoq10a\nFn3k\nSipa1l1\nSlc25a16\nSlc25a40\nRps6ka5\nTrim37\nLrrc61\nAbhd3\nGbe1\nParp16\nHsd3b2\nEsm1\nDnajc18\nDolpp1\nLass2\nWdr34\nRfesd\nCacnb4\n2310042D19Rik\nSrr\nBpnt1\n6530415H11Rik\nClcc1\nTfb1m\n4632404H12Rik\nD4Bwg0951e\nMed14\nAdhfe1\nThtpa\nCat\nEll3\nAkr7a5\nMtmr14\nTimm44\nSf1\nIpp\nIah1\nTrim23\nWdr89\nGstz1\nCradd\n2510006D16Rik\nFbxl6\nLOC100044400\nZfp106\nCd55\n0610013E23Rik\nAfmid\nTmem86a\nAldh6a1\nDalrd3\nSmyd4\nNme7\nFars2\nTasp1\nCldn10\nA930005H10Rik\nSlc9a6\nAdk\nRbks\n2210016F16Rik\nVwce\n4732435N03Rik\nZfp11\nVldlr\n9630013D21Rik\n4933407N01Rik\nFahd1\nMipol1\n1810019D21Rik\n1810049H13Rik\nTfam\nPaics\n1110032A03Rik\nLOC100044139\nDnajc19\nBC016495\nA930041I02Rik\nRqcd1\nUsp34\nZcchc3\nH2afj\nPhf7\n4921508D12Rik\nKmo\nPrpf18\nMcat\nTxndc4\n4921530L18Rik\nVps13b\nScrn3\nTor1a\nAI316807\nAcbd4\nFah\nApool\nCol4a4\nLrrc19\nGnmt\nNr3c1\nSip1\nAscc1\nFech\nAbhd14a\nArhgap18\n2700046G09Rik\nYme1l1\nGk5\nGlo1\nSbk1\nCisd1\n2210011C24Rik\nNxt2\nNotum\nAnkrd42\nUbe2e1\nNdufv1\nSlc33a1\nCep68\nRps6kb1\nHyi\nAldh1a3\nMynn\n3110048L19Rik\nRdh14\nProz\nGorasp1\nLOC674449\nZfp775\n5430437P03Rik\nNpy\nAdh5\nSybl1\n4930432O21Rik\nNat9\nLOC100048387\nMettl8\nEny2\n2410018G20Rik\nPgm2\nFgfr4\nMobkl2b\nAtad3a\n4932432K03Rik\nDhtkd1\nUbox5\nA530050D06Rik\nZdhhc5\nMgat1\nNudt6\nTpmt\nWbscr18\nLOC100041586\nCdk5rap1\n4833426J09Rik\nMyo6\nCpt1a\nGadd45gip1\nTmbim4\n2010309E21Rik\nAsb9\n2610019F03Rik\n7530414M10Rik\nAtp6v1b2\n2310068J16Rik\nDdt\nKlhdc4\nHpn\nLifr\nOvol1\nNudt12\nCdan1\nFbxo9\nFbxl3\nHoxa7\nAldh8a1\n3110057O12Rik\nAbhd11\nPsmb1\nENSMUSG00000074286\nChpt1\nOxsm\n2310009A05Rik\n1700001L05Rik\nZfp148\n39509\nMrpl9\nTmem80\n9030420J04Rik\nNaglu\nPlscr2\nAgbl3\nPex1\nCno\nNeo1\nAsf1a\nTnfsf5ip1\nPkig\nAI931714\nD130020L05Rik\nCntd1\nClec2h\nZkscan1\n1810044D09Rik\nMettl7a\nSiae\nFbxo3\nFzd5\nTmem166\nTmed4\nGpr155\nRnf167\nSptlc1\nRiok2\nTgds\nPms1\nPitpnc1\nPcsk7\n4933403G14Rik\nEi24\nCrebl2\nTln1\nMrpl35\n2700038C09Rik\nUbie\nOsgepl1\n2410166I05Rik\nWdr24\nAp4s1\nLrrc44\nB3bp\nItfg1\nDmxl1\nC1d\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"included_organisms\"\r\n\r\nboth\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"included_database\"\r\n\r\nChEA 2015\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"path_length\"\r\n\r\n2\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"minimum network size\"\r\n\r\n50\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"min_number_of_articles_supporting_interaction\"\r\n\r\n2\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"max_number_of_interactions_per_protein\"\r\n\r\n200\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"max_number_of_interactions_per_article\"\r\n\r\n100\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"biocarta\"\r\n\r\ntrue\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"biogrid\"\r\n\r\ntrue\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"dip\"\r\n\r\ntrue\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"innatedb\"\r\n\r\ntrue\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"intact\"\r\n\r\ntrue\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"kegg\"\r\n\r\ntrue\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"mint\"\r\n\r\ntrue\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"ppid\"\r\n\r\ntrue\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"snavi\"\r\n\r\ntrue\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"number_of_results\"\r\n\r\n50\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"sort_tfs_by\"\r\n\r\ncombined score\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"sort_kinases_by\"\r\n\r\ncombined score\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW--"

headers = {
    'content-type': "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
    'cache-control': "no-cache",
    }

conn.request("POST", "/X2K/api", payload, headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))</code></pre>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="card col-sm-6 my-1">
                                    <div class="panel panel-default">
                                        <div class="panel-heading" role="tab" id="heading3">
                                            <a class="collapsed" data-toggle="collapse" data-parent="#accordion"
                                               href="#collapse3"
                                               aria-expanded="false" aria-controls="collapse3">
                                                cURL
                                            </a>
                                        </div>
                                        <div id="collapse3" class="panel-collapse collapse" role="tabpanel"
                                             aria-labelledby="heading3">
                                            <div class="panel-body">
                                       <pre><code class="bash">curl -X POST \
  http://amp.pharm.mssm.edu/X2K/api \
  -H 'cache-control: no-cache' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -F 'text-genes=Nsun3
Polrmt
Nlrx1
Sfxn5
Zc3h12c
Slc25a39
Arsg
Defb29
Ndufb6
Zfand1
Tmem77
5730403B10Rik
RP23-195K8.6
Tlcd1
Psmc6
Slc30a6
LOC100047292
Lrrc40
Orc5l
Mpp7
Unc119b
Prkaca
Tcn2
Psmc3ip
Pcmtd2
Acaa1a
Lrrc1
2810432D09Rik
Sephs2
Sac3d1
Tmlhe
LOC623451
Tsr2
Plekha7
Gys2
Arhgef12
Hibch
Lyrm2
Zbtb44
Entpd5
Rab11fip2
Lipt1
Intu
Anxa13
Klf12
Sat2
Gal3st2
Vamp8
Fkbpl
Aqp11
Trap1
Pmpcb
Tm7sf3
Rbm39
Bri3
Kdr
Zfp748
Nap1l1
Dhrs1
Lrrc56
Wdr20a
Stxbp2
Klf1
Ufc1
Ccdc16
9230114K14Rik
Rwdd3
2610528K11Rik
Aco1
Cables1
LOC100047214
Yars2
Lypla1
Kalrn
Gyk
Zfp787
Zfp655
Rabepk
Zfp650
4732466D17Rik
Exosc4
Wdr42a
Gphn
2610528J11Rik
1110003E01Rik
Mdh1
1200014M14Rik
AW209491
Mut
1700123L14Rik
2610036D13Rik
Cox15
Tmem30a
Nsmce4a
Tm2d2
Rhbdd3
Atxn2
Nfs1
3110001I20Rik
BC038156
LOC100047782
2410012H22Rik
Rilp
A230062G08Rik
Pttg1ip
Rab1
Afap1l1
Lyrm5
2310026E23Rik
C330002I19Rik
Zfyve20
Poli
Tomm70a
Slc7a6os
Mat2b
4932438A13Rik
Lrrc8a
Smo
Nupl2
Trpc2
Arsk
D630023B12Rik
Mtfr1
5730414N17Rik
Scp2
Zrsr1
Nol7
C330018D20Rik
Ift122
LOC100046168
D730039F16Rik
Scyl1
1700023B02Rik
1700034H14Rik
Fbxo8
Paip1
Tmem186
Atpaf1
LOC100046254
LOC100047604
Coq10a
Fn3k
Sipa1l1
Slc25a16
Slc25a40
Rps6ka5
Trim37
Lrrc61
Abhd3
Gbe1
Parp16
Hsd3b2
Esm1
Dnajc18
Dolpp1
Lass2
Wdr34
Rfesd
Cacnb4
2310042D19Rik
Srr
Bpnt1
6530415H11Rik
Clcc1
Tfb1m
4632404H12Rik
D4Bwg0951e
Med14
Adhfe1
Thtpa
Cat
Ell3
Akr7a5
Mtmr14
Timm44
Sf1
Ipp
Iah1
Trim23
Wdr89
Gstz1
Cradd
2510006D16Rik
Fbxl6
LOC100044400
Zfp106
Cd55
0610013E23Rik
Afmid
Tmem86a
Aldh6a1
Dalrd3
Smyd4
Nme7
Fars2
Tasp1
Cldn10
A930005H10Rik
Slc9a6
Adk
Rbks
2210016F16Rik
Vwce
4732435N03Rik
Zfp11
Vldlr
9630013D21Rik
4933407N01Rik
Fahd1
Mipol1
1810019D21Rik
1810049H13Rik
Tfam
Paics
1110032A03Rik
LOC100044139
Dnajc19
BC016495
A930041I02Rik
Rqcd1
Usp34
Zcchc3
H2afj
Phf7
4921508D12Rik
Kmo
Prpf18
Mcat
Txndc4
4921530L18Rik
Vps13b
Scrn3
Tor1a
AI316807
Acbd4
Fah
Apool
Col4a4
Lrrc19
Gnmt
Nr3c1
Sip1
Ascc1
Fech
Abhd14a
Arhgap18
2700046G09Rik
Yme1l1
Gk5
Glo1
Sbk1
Cisd1
2210011C24Rik
Nxt2
Notum
Ankrd42
Ube2e1
Ndufv1
Slc33a1
Cep68
Rps6kb1
Hyi
Aldh1a3
Mynn
3110048L19Rik
Rdh14
Proz
Gorasp1
LOC674449
Zfp775
5430437P03Rik
Npy
Adh5
Sybl1
4930432O21Rik
Nat9
LOC100048387
Mettl8
Eny2
2410018G20Rik
Pgm2
Fgfr4
Mobkl2b
Atad3a
4932432K03Rik
Dhtkd1
Ubox5
A530050D06Rik
Zdhhc5
Mgat1
Nudt6
Tpmt
Wbscr18
LOC100041586
Cdk5rap1
4833426J09Rik
Myo6
Cpt1a
Gadd45gip1
Tmbim4
2010309E21Rik
Asb9
2610019F03Rik
7530414M10Rik
Atp6v1b2
2310068J16Rik
Ddt
Klhdc4
Hpn
Lifr
Ovol1
Nudt12
Cdan1
Fbxo9
Fbxl3
Hoxa7
Aldh8a1
3110057O12Rik
Abhd11
Psmb1
ENSMUSG00000074286
Chpt1
Oxsm
2310009A05Rik
1700001L05Rik
Zfp148
39509
Mrpl9
Tmem80
9030420J04Rik
Naglu
Plscr2
Agbl3
Pex1
Cno
Neo1
Asf1a
Tnfsf5ip1
Pkig
AI931714
D130020L05Rik
Cntd1
Clec2h
Zkscan1
1810044D09Rik
Mettl7a
Siae
Fbxo3
Fzd5
Tmem166
Tmed4
Gpr155
Rnf167
Sptlc1
Riok2
Tgds
Pms1
Pitpnc1
Pcsk7
4933403G14Rik
Ei24
Crebl2
Tln1
Mrpl35
2700038C09Rik
Ubie
Osgepl1
2410166I05Rik
Wdr24
Ap4s1
Lrrc44
B3bp
Itfg1
Dmxl1
C1d' \
  -F included_organisms=both \
  -F 'included_database=ChEA 2015' \
  -F path_length=2 \
  -F 'minimum network size=50' \
  -F min_number_of_articles_supporting_interaction=2 \
  -F max_number_of_interactions_per_protein=200 \
  -F max_number_of_interactions_per_article=100 \
  -F biocarta=true \
  -F biogrid=true \
  -F dip=true \
  -F innatedb=true \
  -F intact=true \
  -F kegg=true \
  -F mint=true \
  -F ppid=true \
  -F snavi=true \
  -F number_of_results=50 \
  -F 'sort_tfs_by=combined score' \
  -F 'sort_kinases_by=combined score'</code></pre>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <div id="case-studies">
                <h4><a href="http://www.lincsproject.org/LINCS/ljp">The LINCS Joint Project
                    Case Study</a>
                </h4>
                <div class="row justify-content-center">
                    <div id="ljp" class="col-sm-6">
                        <p>In a recent study published in <a href="https://www.ncbi.nlm.nih.gov/pubmed/29084964">Nature
                            Communications, Niepel et al. (2017)</a> combined L1000
                            expression signatures together with cell growth phenotypes for over 600 drug-cell line
                            combinations utilizing over hundred drugs, many of them kinase inhibitors.
                            The case study provides the up and down differentially expressed genes after drug
                            perturbations
                            by these kinase inhibitors. Using the X2K pipeline it is possible to recover the targeted
                            kinase
                            as a highly ranked entry within the last KEA step.</p>
                    </div>
                    <div class="col-sm-6">
                <textarea class="form-control form-control-sm" id="ljp-genelist" rows="10"
                          name="ljp-text-genes"></textarea>
                        <div class="my-3">
                            <button type="submit" class="btn btn-outline-primary btn-sm" id="results_submit_ljp">
                                Submit
                            </button>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div id="ljp" class="col-sm-12 my-3 table-responsive">
                        <table id="ljp-table"
                               class="display table table-striped table-bordered table-sm"
                               cellspacing="0">
                            <thead>
                            <tr>
                                <th>Batch</th>
                                <th>Perturbation</th>
                                <th>Drug</th>
                                <th>Dose, μM</th>
                                <th>Time, hours</th>
                                <th>Celline</th>
                                <th>Insert genelist</th>
                            </tr>
                            </thead>
                            <tfoot>
                            <tr>
                                <th>Batch</th>
                                <th>Perturbation</th>
                                <th>Drug</th>
                                <th>Dose, μM</th>
                                <th>Time, hours</th>
                                <th>Celline</th>
                                <th></th>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div id="command-line">
                <h4>Command line tools</h4>
                <p>You can download command line standalone versions of the X2K tools in JAR format.
                    <br/>Command near each download link suggests usage:</p>
                <p>
                    <a href=http://www.maayanlab.net/X2K/download/install_X2K.jar>X2K with source code (61.3 MB)</a>
                    <code>java -jar X2K.jar genelist output.xml</code>
                </p>
                <p>
                    <a href=http://www.maayanlab.net/X2K/download/X2K-1.5-SNAPSHOT-jar-with-dependencies.jar>X2K only
                        binary
                        (28.9 MB)</a>
                    <code>java -jar X2K.jar genelist output.xml</code>
                </p>
                <p>
                    <a href=http://www.maayanlab.net/X2K/download/ChEA-1.5-SNAPSHOT-jar-with-dependencies.jar>ChEA (8.1
                        MB)</a>
                    <code>java -jar ChEA.jar [background] genelist output.csv</code>
                </p>
                <p>
                    <a href=http://www.maayanlab.net/X2K/download/G2N-1.5-SNAPSHOT-jar-with-dependencies.jar>G2N (3.6
                        MB)</a>
                    <code>java -jar G2N.jar input output.sig [backgroundSigFiles...]</code>
                </p>
                <p>
                    <a href=http://www.maayanlab.net/X2K/download/KEA-1.5-SNAPSHOT-jar-with-dependencies.jar>KEA (188
                        KB)</a>
                    <code>java -jar KEA.jar [background] genelist output.csv</code>
                </p>
                <p>
                    <a href=http://www.maayanlab.net/X2K/download/List2Networks-1.0-SNAPSHOT-jar-with-dependencies.jar>L2N
                        (2
                        MB)</a>
                    <code>java -jar L2N.jar gene_list [background_file...] output.xml</code>
                </p>
            </div>

            <div id="datasets">
                <h4>Download datasets</h4>
                <div class="row">
                    <div class="col-sm-12">
                        <h6>Protein-Protein Interaction</h6>
                        <div class="table-responsive">
                            <table class="table table-sm">
                                <thead>
                                <tr>
                                    <th>Link</th>
                                    <th>PPIs</th>
                                    <th>Proteins</th>
                                    <th>PMIDs</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td><a href="datasets/Biocarta.sig">Biocarta</a></td>
                                    <td>756</td>
                                </tr>
                                <tr>
                                    <td><a href="datasets/BioGRID_2017.sig">BioGrid 2017</a></td>
                                    <td>61,387</td>
                                </tr>
                                <tr>
                                    <td><a href="datasets/BioPlex.sig">BioPlex</a></td>
                                    <td>56,553</td>
                                </tr>
                                <tr>
                                    <td><a href="datasets/DIP_2017.sig">DIP 2017</a></td>
                                    <td>3,909</td>
                                </tr>
                                <tr>
                                    <td><a href="datasets/huMAP.sig">huMAP 2017</a></td>
                                    <td>62,214</td>
                                </tr>
                                <tr>
                                    <td><a href="datasets/iREF.sig">iREF 2017</a></td>
                                    <td>424,104</td>
                                </tr>                                
                                <tr>
                                    <td><a href="datasets/innateDB_2017.sig">innateDB 2017</a></td>
                                    <td>5,415</td>
                                </tr>
                                <tr>
                                    <td><a href="datasets/IntAct_2017.sig">IntAct 2017</a></td>
                                    <td>14,770</td>
                                </tr>
                                <tr>
                                    <td><a href="datasets/KEGG.sig">KEGG</a></td>
                                    <td>13,993</td>
                                </tr>
                                <tr>
                                    <td><a href="datasets/MINT_2017.sig">MINT 2017</a></td>
                                    <td>6,394</td>
                                </tr>
                                <tr>
                                    <td><a href="datasets/ppid.sig">ppid</a></td>
                                    <td>6,998</td>
                                </tr>
                                <tr>
                                    <td><a href="datasets/SNAVI.sig">SNAVI</a></td>
                                    <td>1,448</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="col-sm-12">
                        <h6>Transcriptional Regulation</h6>
                        <div class="table-responsive">
                            <table class="table table-sm">
                                <thead>
                                <tr>
                                    <th>Link</th>
                                    <th>TFs</th>
                                    <th>Targets</th>
                                    <th>PMIDs</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td><a href="datasets/ChEA2015.zip">ChEA 2015</a></td>
                                    <td>395</td>
                                </tr>
                                <tr>
                                    <td><a href="datasets/ENCODE2015.zip">ENCODE 2015</a></td>
                                    <td>816</td>
                                </tr>
                                <tr>
                                    <td><a href="datasets/Consensus.zip">ChEA & ENCODE Consensus</a></td>
                                    <td>105</td>
                                </tr>
                                <tr>
                                    <td><a href="datasets/TransfacAndJaspar.zip">TRANSFAC & JASPAR</a></td>
                                    <td>326</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="col-sm-12">
                        <h6>Kinome Regulation</h6>
                        <div class="table-responsive">
                            <table class="table table-sm">
                                <thead>
                                <tr>
                                    <th>Link</th>
                                    <th>Kinase-<br class="visible-sm" />substrates</th>
                                    <th>Kinases</th>
                                    <th>Substrates</th>
                                    <th>PMIDs</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td><a href="datasets/KEA_2017.zip">KEA 2017</a></td>
                                    <td>11,420</td>
                                </tr>
                                <tr>
                                    <td>HPRD</td>
                                    <td>4833</td>
                                    <td>176</td>
                                    <td>2044</td>
                                    <td>257</td>
                                </tr>
                                <tr>
                                    <td>iPTMnet</td>
                                    <td>5153</td>
                                    <td>161</td>
                                    <td>2135</td>
                                    <td>716</td>
                                </tr>
                                <tr>
                                    <td>iREF</td>
                                    <td>27097</td>
                                    <td>437</td>
                                    <td>7915</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>MINT</td>
                                    <td>1314</td>
                                    <td>90</td>
                                    <td>879</td>
                                    <td>450</td>
                                </tr>
                                <tr>
                                    <td>NetworkIN_2017</td>
                                    <td>169059</td>
                                    <td>207</td>
                                    <td>8308</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>Phospho.ELM</td>
                                    <td>1149</td>
                                    <td>68</td>
                                    <td>714</td>
                                    <td>1458</td>
                                </tr>
                                <tr>
                                    <td>PhosphositePlus</td>
                                    <td>6434</td>
                                    <td>168</td>
                                    <td>2680</td>
                                    <td></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div id="about">
                <h4>About</h4>
                <h5>Reference</h5>
                <p>X2Kweb is an updated version of the original Expression2Kinases (X2K) publication:
                    <br/><a href="https://www.ncbi.nlm.nih.gov/pubmed/22080467">Chen EY, Xu H, Gordonov S, Lim MP, Perkins MH, Ma'ayan A. Expression2Kinases: mRNA profiling linked
                    to multiple upstream regulatory layers. Bioinformatics. 28:105 (2012)</a>
                </p>
                <h5>Affiliations</h5>
                <p>Expression2Kinases (X2K) is actively developed by the <a
                        href="http://icahn.mssm.edu/research/labs/maayan-laboratory">Ma’ayan Laboratory</a> and the <a
                        href="http://icahn.mssm.edu/research/bioinformatics">Mount Sinai Center
                    for Bioinformatics</a> for <a href="http://lincs-dcic.org/">BD2K-LINCS Data Coordination and
                    Integration Center</a> and <a href="https://commonfund.nih.gov/idg/overview">Illuminating the
                    Druggable Genome</a> Common Fund Programs at the <a href="http://icahn.mssm.edu/">Icahn School of
                    Medicine at Mount Sinai</a>, New York, NY
                    10029 USA</p>
                <h5>Contact</h5>
                <ul class="list-unstyled">
                    <li>
                        <p><a href="mailto:avi.maayan@mssm.edu">Avi Ma'ayan, PhD</a>
                            <br/>Professor, Department of Pharmacological Sciences
                            <br/>Director, Mount Sinai Center for Bioinformatics
                            <br/>Icahn School of Medicine at Mount Sinai
                            <br/>New York, NY 10029</p>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<!-- Loader -->
<div id="loader"></div>
<div id="blocker"></div>

</body>
</html>