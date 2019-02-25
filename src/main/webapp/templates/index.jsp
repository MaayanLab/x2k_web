<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>X2K Web</title>

    <%@ include file="/templates/head.jsp" %>

    <link rel="stylesheet" href="dist/css/atooltip.css">
    <link rel="stylesheet" href="dist/css/results.css">
    <link rel="stylesheet" href="dist/css/index_beta.css">

    <script src="dist/js/bargraph.js"></script>
    <script src="dist/js/index.js"></script>
    <script src="dist/js/ljp.js"></script>
    <script src="dist/js/network.js"></script>
    <script src="dist/js/results_index.js"></script>
    <script src="dist/js/results.js"></script>
</head>

<body data-spy="scroll" data-target="#x2k-navbar" data-offset="150">
<!-- Anchor for scrollspy -->
<div id="x2k-scroll"></div>

<div class="container-fluid">
    <div class="row justify-content-center bg-light">
        <div class="col-sm col-md-8">
            <nav class="navbar navbar-light sticky-top bg-light justify-content-center navbar-expand-sm"
                 id="x2k-navbar">
                <a class="navbar-brand" href="/X2K">
                    <img id="logo" src="static/logo.png" height="50px" class="d-inline-block full-logo">
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
                            <a class="nav-link" href="#case-studies">Canned Signatures</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#command-line">Command Line</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#datasets">Datasets</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#about">About</a>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
        <div class="col-sm col-md-8 show-on-ie" style="display: none; color: red; font-weight: bold; text-align:center;">
            For best app performance, please use a browser other than Internet Explorer.
        </div>
        <div class="col-sm col-md-8 bg-white">
            <div class="my-3 mx-2">
                <h4>Submit</h4>
                <div class="my-3">
                    <p>

                        X2K Web infers upstream regulatory networks from signatures of differentially expressed genes.
                        By combining transcription factor enrichment analysis, protein-protein interaction network
                        expansion, with kinase enrichment analysis, X2K Web produces inferred networks of transcription
                        factors, proteins, and kinases predicted to regulate the expression of the inputted gene list.
                        X2K Web provides the results as tables and interactive vector graphic figures that can be
                        readily embedded within publications.. You can read more about the X2K concept by reading the
                        original <a href="https://www.ncbi.nlm.nih.gov/pubmed/22080467">X2K publication</a>.
                    </p>
                </div>
                <form id="x2k-form" enctype="multipart/form-data" method="POST">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-6 my-2">
                                <label for="genelist" role="alert">Gene list (<a href="javascript:void(0)"
                                                                                 onclick="insertExample();"
                                                                                 id="example-link">try an
                                    example</a>)</label>
                                <div id="error" class="alert alert-danger" style="display: none"></div>
                                <textarea class="form-control form-control-sm" id="genelist" rows="12"
                                          name="text-genes"></textarea>
                                <span id="gene-count" style="color: darkgrey; font-size: 0.9rem;"></span>
                                <br/>
                                <span id="warning" style="color: coral; font-size: 0.8rem;"></span>
                                <!--Buttons-->
                                <div class="mb-4 mt-2">
                                    <button type="submit" class="btn btn-sm btn-outline-primary" id="results_submit"
                                            disabled>
                                        Submit
                                    </button>
                                </div>

                                <!--Settings-->
                                <div id="settings-accordion" role="tablist" class="my-1">
                                    <div class="card">
                                        <div class="card-header py-1 border-0  bg-white" role="tab" id="settings-acc">
                                            <a data-toggle="collapse" href="#settings" aria-expanded="true"
                                               aria-controls="settings">
                                                Advanced Settings (Defaults to optimized parameters)
                                            </a>
                                        </div>

                                        <div id="settings" class="collapse" role="tabpanel"
                                             aria-labelledby="settings-acc" data-parent="#accordion">
                                            <div class="card-body">
                                                <div id="accordion" role="tablist">

                                                    <!--ChEA-->
                                                    <div class="card my-1">
                                                        <div class="card-header py-1 border-0" role="tab"
                                                             id="chea-x2k-settings">
                                                            <a class="collapsed" data-toggle="collapse"
                                                               href="#chea-x2k-collapse" aria-expanded="false"
                                                               aria-controls="chea-x2k-collapse">
                                                                Transcription Factor Enrichment Analysis
                                                            </a>
                                                        </div>
                                                        <div id="chea-x2k-collapse" class="collapse" role="tabpanel"
                                                             aria-labelledby="chea-x2k-settings"
                                                             data-parent="#accordion">
                                                            <div class="card-body">
                                                                <div class="form-group" id="chea-x2k-species">
                                                                    <div class="row align-items-center">
                                                                        <label class="col-form-label col-sm-5">
                                                                            Background organism
                                                                            <sup data-toggle="tooltip"
                                                                                 data-placement="top" container="body"
                                                                                 title="The organism from which TF-target interaction data should be integrated.">
                                                                                <i class="fa fa-question-circle"></i>
                                                                            </sup>
                                                                        </label>
                                                                        <div class="col-sm-7">
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input-species"
                                                                                           type="radio"
                                                                                           name="included organisms in the background database"
                                                                                           id="chea-x2k-human"
                                                                                           value="human">
                                                                                    human
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input-species"
                                                                                           type="radio"
                                                                                           name="included organisms in the background database"
                                                                                           id="chea-x2k-mouse"
                                                                                           value="mouse">
                                                                                    mouse
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input-species"
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
                                                                        <label class="col-form-label col-sm-5">
                                                                            Transcription factor database
                                                                            <sup data-toggle="tooltip"
                                                                                 data-placement="top" container="body"
                                                                                 title="The database from which TF-target interaction data should be integrated.">
                                                                                <i class="fa fa-question-circle"></i>
                                                                            </sup>
                                                                        </label>
                                                                        <div class="col-sm-7">
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input-chea"
                                                                                           type="radio"
                                                                                           name="TF-target gene background database used for enrichment"
                                                                                           id="x2k_chea2015"
                                                                                           value="ChEA 2015">
                                                                                    ChEA 2015
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input-chea"
                                                                                           type="radio"
                                                                                           name="TF-target gene background database used for enrichment"
                                                                                           id="x2k_encode2015"
                                                                                           value="ENCODE 2015">
                                                                                    ENCODE 2015
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input-chea"
                                                                                           type="radio"
                                                                                           name="TF-target gene background database used for enrichment"
                                                                                           id="x2k_chea-encode"
                                                                                           value="ChEA & ENCODE Consensus"
                                                                                           checked>
                                                                                    ChEA & ENCODE Consensus
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input-chea"
                                                                                           type="radio"
                                                                                           name="TF-target gene background database used for enrichment"
                                                                                           id="x2k_transfac-jaspar"
                                                                                           value="Transfac and Jaspar">
                                                                                    TRANSFAC & JASPAR
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input-chea"
                                                                                           type="radio"
                                                                                           name="TF-target gene background database used for enrichment"
                                                                                           id="x2k_ChEA_2016"
                                                                                           value="ChEA 2016">
                                                                                    ChEA 2016
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input-chea"
                                                                                           type="radio"
                                                                                           name="TF-target gene background database used for enrichment"
                                                                                           id="x2k_ARCHS4"
                                                                                           value="ARCHS4 TFs Coexp">
                                                                                    ARCHS4
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input-chea"
                                                                                           type="radio"
                                                                                           name="TF-target gene background database used for enrichment"
                                                                                           id="x2k_CREEDS"
                                                                                           value="CREEDS">
                                                                                    CREEDS
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input-chea"
                                                                                           type="radio"
                                                                                           name="TF-target gene background database used for enrichment"
                                                                                           id="x2k_Enrichr_Co-occurrence"
                                                                                           value="Enrichr Submissions TF-Gene Coocurrence">
                                                                                    Enrichr Co-occurrence
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
                                                                Network Expansion with PPI
                                                            </a>
                                                        </div>
                                                        <div id="g2n-x2k-collapse" class="collapse" role="tabpanel"
                                                             aria-labelledby="g2n-x2k-settings"
                                                             data-parent="#accordion">
                                                            <div class="card-body">
                                                                <div class="form-group row align-items-center">
                                                                    <label for="min_network_size"
                                                                           class="col-form-label col-sm-9">Minimum
                                                                        number of proteins in subnetwork
                                                                        <sup data-toggle="tooltip" data-placement="top"
                                                                             container="body"
                                                                             title="The minimum size of the expanded Protein-Protein interaction subnetwork generated using Genes2Networks.">
                                                                            <i class="fa fa-question-circle"></i>
                                                                        </sup>
                                                                    </label>
                                                                    <div class="col-sm-3">
                                                                        <input class="form-control form-control-sm"
                                                                               type="text" value="10"
                                                                               id="min_network_size"
                                                                               name="min_network_size">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group row align-items-center">
                                                                    <label for="number of top TFs"
                                                                           class="col-form-label col-sm-9">Minimum
                                                                        number of transcription factors in subnetwork
                                                                        <sup data-toggle="tooltip" data-placement="top"
                                                                             container="body"
                                                                             title="The minimum size of the expanded transcription factor subnetwork generated using Genes2Networks.">
                                                                            <i class="fa fa-question-circle"></i>
                                                                        </sup>
                                                                    </label>
                                                                    <div class="col-sm-3">
                                                                        <input class="form-control form-control-sm"
                                                                               type="text" value="10"
                                                                               id="number of top TFs"
                                                                               name="number of top TFs">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group row align-items-center">
                                                                    <label for="x2k_path_length"
                                                                           class="col-form-label col-sm-9">
                                                                        Minimum path length
                                                                        <sup data-toggle="tooltip" data-placement="top"
                                                                             container="body"
                                                                             title="The minimum Protein-Protein Interaction path length for the subnetwork expansion step of Genes2Networks.">
                                                                            <i class="fa fa-question-circle"></i>
                                                                        </sup>
                                                                    </label>
                                                                    <div class="col-sm-3">
                                                                        <input class="form-control form-control-sm"
                                                                               type="text" value="2"
                                                                               id="x2k_path_length" name="path_length">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group row align-items-center">
                                                                    <label for="x2k_min_number_of_articles_supporting_interaction"
                                                                           class="col-form-label col-sm-9">
                                                                        Minimum number of articles
                                                                        <sup data-toggle="tooltip" data-placement="top"
                                                                             container="body"
                                                                             title="The minimum number of published articles supporting a Protein-Protein Interaction for the expanded subnetwork.">
                                                                            <i class="fa fa-question-circle"></i>
                                                                        </sup>
                                                                    </label>
                                                                    <div class="col-sm-3">
                                                                        <input class="form-control form-control-sm"
                                                                               type="text" value="0"
                                                                               id="x2k_min_number_of_articles_supporting_interaction"
                                                                               name="min_number_of_articles_supporting_interaction">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group row align-items-center">
                                                                    <label for="x2k_max_number_of_interactions_per_protein"
                                                                           class="col-form-label col-sm-9">
                                                                        Maximum number of interactions per protein
                                                                        <sup data-toggle="tooltip" data-placement="top"
                                                                             container="body"
                                                                             title="The maximum number of physical interactions allowed for the proteins in the expanded subnetwork.">
                                                                            <i class="fa fa-question-circle"></i>
                                                                        </sup>
                                                                    </label>
                                                                    <div class="col-sm-3">
                                                                        <input class="form-control form-control-sm"
                                                                               type="text" value="200"
                                                                               id="x2k_max_number_of_interactions_per_protein"
                                                                               name="max_number_of_interactions_per_protein">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group row align-items-center">
                                                                    <label for="x2k_max_number_of_interactions_per_article"
                                                                           class="col-form-label col-sm-9">
                                                                        Maximum number of interactions per article
                                                                        <sup data-toggle="tooltip" data-placement="top"
                                                                             container="body"
                                                                             title="The maximum number of physical interactions reported in the publications used for the subnetwork expansion in Genes2Networks.">
                                                                            <i class="fa fa-question-circle"></i>
                                                                        </sup>
                                                                    </label>
                                                                    <div class="col-sm-3">
                                                                        <input class="form-control form-control-sm"
                                                                               type="text" value="100"
                                                                               id="x2k_max_number_of_interactions_per_article"
                                                                               name="max_number_of_interactions_per_article">
                                                                    </div>
                                                                </div>
                                                                <hr/>
                                                                <div class="form-group" id="g2n-x2k-ppi">
                                                                    <label>
                                                                        PPI Networks
                                                                        <sup data-toggle="tooltip" data-placement="top"
                                                                             container="body"
                                                                             title="The Protein-Protein Interaction databases to integrate for generation of the expanded subnetwork.">
                                                                            <i class="fa fa-question-circle"></i>
                                                                        </sup>
                                                                    </label>
                                                                    <div class="row">
                                                                        <div class="form-check col-sm-4">
                                                                            <label class="form-check-label">
                                                                                <input class="form-check-input"
                                                                                       type="checkbox"
                                                                                       name="enable_Biocarta"
                                                                                       value=false>
                                                                                Biocarta
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-sm-4">
                                                                            <label class="form-check-label">
                                                                                <input class="form-check-input"
                                                                                       type="checkbox"
                                                                                       name="enable_BioGRID"
                                                                                       value=true checked>
                                                                                BioGRID 2017
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-sm-4">
                                                                            <label class="form-check-label">
                                                                                <input class="form-check-input"
                                                                                       type="checkbox"
                                                                                       name="enable_BioPlex"
                                                                                       value=false>
                                                                                BioPlex
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-sm-4">
                                                                            <label class="form-check-label">
                                                                                <input class="form-check-input"
                                                                                       type="checkbox"
                                                                                       name="enable_DIP"
                                                                                       value=false>
                                                                                DIP 2017
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-sm-4">
                                                                            <label class="form-check-label">
                                                                                <input class="form-check-input"
                                                                                       type="checkbox"
                                                                                       name="enable_huMAP"
                                                                                       value=false>
                                                                                huMAP 2017
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-sm-4">
                                                                            <label class="form-check-label">
                                                                                <input class="form-check-input"
                                                                                       type="checkbox"
                                                                                       name="enable_InnateDB"
                                                                                       value="false">
                                                                                InnateDB 2017
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-sm-4">
                                                                            <label class="form-check-label">
                                                                                <input class="form-check-input"
                                                                                       type="checkbox"
                                                                                       name="enable_IntAct"
                                                                                       value=true checked>
                                                                                IntAct 2017
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-sm-4">
                                                                            <label class="form-check-label">
                                                                                <input class="form-check-input"
                                                                                       type="checkbox"
                                                                                       name="enable_KEGG"
                                                                                       value=false>
                                                                                KEGG
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-sm-4">
                                                                            <label class="form-check-label">
                                                                                <input class="form-check-input"
                                                                                       type="checkbox"
                                                                                       name="enable_MINT"
                                                                                       value=true checked>
                                                                                MINT 2017
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-sm-4">
                                                                            <label class="form-check-label">
                                                                                <input class="form-check-input"
                                                                                       type="checkbox"
                                                                                       name="enable_ppid"
                                                                                       value="true" checked>
                                                                                ppid
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-sm-4">
                                                                            <label class="form-check-label">
                                                                                <input class="form-check-input"
                                                                                       type="checkbox"
                                                                                       name="enable_SNAVI"
                                                                                       value="false">
                                                                                SNAVI 2017
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-sm-4">
                                                                            <label class="form-check-label">
                                                                                <input class="form-check-input"
                                                                                       type="checkbox"
                                                                                       name="enable_iREF"
                                                                                       value="false">
                                                                                iREF 2017
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-sm-4">
                                                                            <label class="form-check-label">
                                                                                <input
                                                                                        type="checkbox"
                                                                                        class="form-check-input"
                                                                                        name="enable_Stelzl"
                                                                                        value="true" checked>
                                                                                Stelzl
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-sm-4">
                                                                            <label class="form-check-label">
                                                                                <input
                                                                                        type="checkbox"
                                                                                        class="form-check-input"
                                                                                        name="enable_vidal"
                                                                                        value="false">
                                                                                Vidal
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-sm-4">
                                                                            <label class="form-check-label">
                                                                                <input
                                                                                        type="checkbox"
                                                                                        class="form-check-input"
                                                                                        name="enable_BIND"
                                                                                        value="false">
                                                                                BIND
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-sm-4">
                                                                            <label class="form-check-label">
                                                                                <input
                                                                                        type="checkbox"
                                                                                        class="form-check-input"
                                                                                        name="enable_figeys"
                                                                                        value="false">
                                                                                figeys
                                                                            </label>
                                                                        </div>
                                                                        <div class="form-check col-sm-4">
                                                                            <label class="form-check-label">
                                                                                <input
                                                                                        type="checkbox"
                                                                                        class="form-check-input"
                                                                                        name="enable_HPRD"
                                                                                        value="false">
                                                                                HPRD
                                                                            </label>
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
                                                                Kinase Enrichment Analysis
                                                            </a>
                                                        </div>
                                                        <div id="kea-x2k-collapse" class="collapse" role="tabpanel"
                                                             aria-labelledby="kea-x2k-settings"
                                                             data-parent="#accordion">
                                                            <div class="card-body">
                                                                <div class="form-group" id="kea-x2k-kinase-db">
                                                                    <div class="row align-items-center">
                                                                        <label class="col-form-label col-sm-5">
                                                                            Kinome database
                                                                            <sup data-toggle="tooltip"
                                                                                 data-placement="top" container="body"
                                                                                 title="The database from which Kinase-target interaction data should be integrated.">
                                                                                <i class="fa fa-question-circle"></i>
                                                                            </sup>
                                                                        </label>
                                                                        <div class="col-sm-7">
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input-kea"
                                                                                           type="radio"
                                                                                           name="kinase interactions to include"
                                                                                           id="KEA"
                                                                                           value="kea 2018" checked>
                                                                                    KEA 2018
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input-kea"
                                                                                           type="radio"
                                                                                           name="kinase interactions to include"
                                                                                           id="ARCHS4"
                                                                                           value="ARCHS4">
                                                                                    ARCHS4
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input-kea"
                                                                                           type="radio"
                                                                                           name="kinase interactions to include"
                                                                                           id="iPTMnet"
                                                                                           value="iPTMnet">
                                                                                    iPTMnet
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input-kea"
                                                                                           type="radio"
                                                                                           name="kinase interactions to include"
                                                                                           id="NetworkIN"
                                                                                           value="NetworkIN">
                                                                                    NetworkIN
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input-kea"
                                                                                           type="radio"
                                                                                           name="kinase interactions to include"
                                                                                           id="Phospho.ELM"
                                                                                           value="Phospho.ELM">
                                                                                    Phospho.ELM
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input-kea"
                                                                                           type="radio"
                                                                                           name="kinase interactions to include"
                                                                                           id="Phosphopoint"
                                                                                           value="Phosphopoint">
                                                                                    Phosphopoint
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input-kea"
                                                                                           type="radio"
                                                                                           name="kinase interactions to include"
                                                                                           id="PhosphoPlus"
                                                                                           value="PhosphoPlus">
                                                                                    PhosphoPlus
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input-kea"
                                                                                           type="radio"
                                                                                           name="kinase interactions to include"
                                                                                           id="MINT"
                                                                                           value="MINT">
                                                                                    MINT
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
                                            href="https://www.ncbi.nlm.nih.gov/pubmed/20709693">Transcription Factor
                                        Enrichment Analysis (TFEA)</a>.
                                    </li>
                                    <li>Protein–protein interactions subnetwork that connects the enriched
                                        transcription factors with known protein-protein interactions using the <a
                                                href="https://www.ncbi.nlm.nih.gov/pubmed/17916244">Genes2Networks
                                            (G2N)</a> method.
                                    </li>
                                    <li>Ranked list of enriched kinases based on overlap between known
                                        kinase–substrate phosphorylation interactions and the proteins in the subnetwork
                                        created in step 2.
                                    </li>
                                    <li>Complete upstream pathway that connects the enriched transcription factors to
                                        kinases through known protein-protein interactions via <a
                                                href="https://www.ncbi.nlm.nih.gov/pubmed/22080467">the
                                            eXpression2Kinases (X2K) algorithm</a>.
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
            <!--</div>-->
            <div id="api">
                <h4>API</h4>
                <div class="row">
                    <div class="col-sm-12">
                        <div style="overflow-y: auto; width: 100%;">
                            <iframe src="https://nbviewer.jupyter.org/github/MaayanLab/x2k_web/blob/master/src/main/webapp/notebooks/x2k_api_notebook.ipynb?flush_cache=true"
                                    style="border: 1px solid lightgrey; width: 100%; border-radius: 3px; margin-top: 5px; height: 500px;"></iframe>
                        </div>
                    </div>
                </div>
            </div>

            <div id="case-studies">
                <h4>
                    <a href="http://www.lincsproject.org/LINCS/ljp">The LINCS Joint Project Canned Signatures</a>
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
                    <div id="ljp-table-wrapper" class="col-sm-12 my-3 table-responsive">
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
                                <th>Cell Line</th>
                                <th>Fetch Gene Set</th>
                            </tr>
                            </thead>
                            <tfoot>
                            <tr>
                                <th>Batch</th>
                                <th>Perturbation</th>
                                <th>Drug</th>
                                <th>Dose, μM</th>
                                <th>Time, hours</th>
                                <th>Cell Line</th>
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
                <%@ include file="/templates/downloads.jsp" %>
            </div>

            <div id="about">
                <h4>About</h4>
                <h5>Citations</h5>
                <a href="https://academic.oup.com/nar/article/46/W1/W171/5003452">Clarke DJB, Kuleshov MV, Schilder BM,
                    Torre D, Duffy ME, Keenan AB, Lachmann A, Feldmann AS, Gundersen GW, Silverstein MC, Wang Z, Ma'ayan
                    A. eXpression2Kinases (X2K) Web: linking expression signatures to upstream cell signaling networks.
                    Nucleic Acids Res. 2018 Jul 2;46(W1):W171-W179</a>
                <br/><br/><a href="https://www.ncbi.nlm.nih.gov/pubmed/22080467">Chen EY, Xu H, Gordonov S, Lim MP,
                Perkins MH, Ma'ayan A. Expression2Kinases: mRNA profiling linked
                to multiple upstream regulatory layers. Bioinformatics. 28:105 (2012)</a>
                </p>
                <h5>Affiliations</h5>
                <div><a href="http://icahn.mssm.edu/research/labs/maayan-laboratory" target="_blank">The Ma'ayan Lab</a>
                </div>
                <div><a href="http://icahn.mssm.edu/research/bioinformatics" target="_blank">Mount Sinai Center for
                    Bioinformatics</a></div>
                <div><a href="http://www.lincs-dcic.org/" target="_blank">BD2K-LINCS Data Coordination and Integration
                    Center (DCIC)</a></div>
                <div><a href="https://druggablegenome.net/KMC_ISMMS" target="_blank">NIH Illuminating the Druggable
                    Genome (IDG) Program</a></div>
                <div><a href="http://icahn.mssm.edu/" target="_blank">Icahn School of Medicine at Mount Sinai</a></div>
                <!-- <div><a href="http://www.lincsproject.org/">NIH LINCS program</a></div> -->
                <!-- <div><a href="https://commonfund.nih.gov/commons" target="_blank">NIH Big Data to Knowledge (BD2K)</a></div> -->
                <h5 class="mt-3">Contact</h5>
                <ul class="list-unstyled">
                    <li>
                        <p><a href="mailto:avi.maayan@mssm.edu">Avi Ma'ayan, PhD</a>
                            <br/>Professor, Department of Pharmacological Sciences
                            <br/>Director, Mount Sinai Center for Bioinformatics
                            <br/>Icahn School of Medicine at Mount Sinai
                            <br/>New York, NY 10029, USA</p>
                    </li>
                </ul>
                <h5 class="mt-3">Licensing</h5>
                <ul class="list-unstyled">
                    <li>
                        <p>X2K Web's tools and services are free for academic, non-profit use, but for commercial uses
                            please contact <a href="http://ip.mountsinai.org/">MSIP</a> for a license.</p>
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
