<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="edu.mssm.pharm.maayanlab.X2K.web.*"%>
<%@ page import="edu.mssm.pharm.maayanlab.X2K.enrichment.*"%>
<%@ page import="edu.mssm.pharm.maayanlab.ChEA.*"%>
<%@ page import="edu.mssm.pharm.maayanlab.Genes2Networks.*"%>
<%@ page import="edu.mssm.pharm.maayanlab.KEA.*"%>

<html lang="en">
<head>
    <title>X2K Web</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
    <script src="js/index.js"></script>
</head>

<body>
<!--Header-->
<div id="logo">
        <a href="/X2K"><img id="logo-png" class="img-fluid mx-auto" src="static/logo.png"/></a>
        <p id="x2k_title">A web interface for the Expression to Kinases application</p>
</div>

<!--Navbar-->
<nav class="nav nav-tabs justify-content-center" id="x2k-navbar" role="tablist">
    <a class="nav-item nav-link active" id="nav-x2k-tab" data-toggle="tab" href="#nav-x2k" role="tab"
       aria-controls="nav-x2k" aria-expanded="true">X2K</a>
    <a class="nav-item nav-link" id="nav-chea-tab" data-toggle="tab" href="#nav-chea" role="tab"
       aria-controls="nav-chea">ChEA</a>
    <a class="nav-item nav-link" id="nav-g2n-tab" data-toggle="tab" href="#nav-g2n" role="tab"
       aria-controls="nav-g2n">G2N</a>
    <a class="nav-item nav-link" id="nav-kea-tab" data-toggle="tab" href="#nav-kea" role="tab"
       aria-controls="nav-kea">KEA</a>
    <div class="dropdown">
        <a class="nav-item nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true"
           aria-expanded="false">
            Help
        </a>
        <div class="dropdown-menu">
            <a class="dropdown-item" id="nav-about-tab" href="#nav-about" role="tab" data-toggle="tab"
               aria-controls="nav-about">About</a>
            <a class="dropdown-item" id="nav-api-tab" href="#nav-api" role="tab" data-toggle="tab"
               aria-controls="nav-api">API</a>
            <a class="dropdown-item" id="nav-commandline-tab" href="#nav-commandline" role="tab" data-toggle="tab"
               aria-controls="nav-commandline">Download command line versions</a>
            <a class="dropdown-item" id="nav-datasets-tab" href="#nav-datasets" role="tab" data-toggle="tab"
               aria-controls="nav-datasets">Download datasets</a>
        </div>
    </div>
</nav>

<!--Body-->
<div class="tab-content container-fluid" id="nav-tabContent">
    <!--X2K-->
    <div class="tab-pane fade show active" id="nav-x2k" role="tabpanel" aria-labelledby="nav-x2k-tab">
        <div class="row justify-content-center">
            <div id="x2k" class="col-sm-7 text-left">
                <form>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-6 my-3">
                                <label for="genelist">Gene list</label>
                                <textarea class="form-control form-control-sm" id="genelist" rows="3"></textarea>

                                <!--Buttons-->
                                <div class="my-3">
                                    <button type="submit" class="btn btn-outline-primary btn-sm" >Submit</button>
                                </div>

                                <!--Settings-->
                                <div id="settings-accordion" role="tablist" class="my-1">
                                    <div class="card">
                                        <div class="card-header py-1 border-0  bg-white" role="tab" id="settings-acc">
                                            <a data-toggle="collapse" href="#settings" aria-expanded="true" aria-controls="settings">
                                                Settings
                                            </a>
                                        </div>

                                        <div id="settings" class="collapse" role="tabpanel" aria-labelledby="settings-acc" data-parent="#accordion">
                                            <div class="card-body">
                                                <div id="accordion" role="tablist">

                                                    <!--X2K-->
                                                    <div class="card my-1">
                                                        <div class="card-header py-1 border-0" role="tab" id="x2k-settings">
                                                            <a data-toggle="collapse" href="#x2k-collapse" aria-expanded="true" aria-controls="x2k-collapse">
                                                                X2K
                                                            </a>
                                                        </div>
                                                        <div id="x2k-collapse" class="collapse" role="tabpanel" aria-labelledby="x2k-settings" data-parent="#accordion">
                                                            <div class="card-body">
                                                                <div class="form-group row align-items-center">
                                                                    <label for="min_network_size" class="col-form-label col-sm-9">Minimum number of proteins in subnetwork</label>
                                                                    <div class="col-sm-3">
                                                                        <input class="form-control form-control-sm" type="text" value="50" id="min_network_size">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group row align-items-center">
                                                                    <label for="number_of_results" class="col-form-label col-sm-9">Number of results</label>
                                                                    <div class="col-sm-3">
                                                                        <input class="form-control form-control-sm" type="text" value="10" id="number_of_results">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!--ChEA-->
                                                    <div class="card my-1">
                                                        <div class="card-header py-1 border-0" role="tab" id="chea-settings">
                                                            <a class="collapsed" data-toggle="collapse" href="#chea-collapse" aria-expanded="false" aria-controls="chea-collapse">
                                                                ChEA
                                                            </a>
                                                        </div>
                                                        <div id="chea-collapse" class="collapse" role="tabpanel" aria-labelledby="chea-settings" data-parent="#accordion">
                                                            <div class="card-body">
                                                                <div class="form-group" id="chea-sorting">
                                                                    <div class="row align-items-center">
                                                                        <label class="col-form-label col-sm-5">Sort by</label>
                                                                        <div class="col-sm-7">
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="radio" name="cheaSorting" id="chea-pvalue" value="p-value" checked>
                                                                                    p-value
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="radio" name="cheaSorting" id="chea-rank" value="rank">
                                                                                    rank
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="radio" name="cheaSorting" id="chea-combscore" value="combined score">
                                                                                    combined score
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <hr/>
                                                                <div class="form-group" id="chea-species">
                                                                    <div class="row align-items-center">
                                                                        <label class="col-form-label col-sm-5">Background organism</label>
                                                                        <div class="col-sm-7">
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="radio" name="cheaSpecies" id="chea-human" value="human">
                                                                                    human
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="radio" name="cheaSpecies" id="chea-mouse" value="mouse">
                                                                                    mouse
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="radio" name="cheaSpecies" id="chea-both" value="both" checked>
                                                                                    both
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <hr/>
                                                                <div class="form-group" id="chea-tfdb">
                                                                    <div class="row align-items-center">
                                                                        <label class="col-form-label col-sm-5">Transcription factor database</label>
                                                                        <div class="col-sm-7">
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="radio" name="cheaTFdb" id="chea2015" value="ChEA 2015" checked>
                                                                                    ChEA 2015
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="radio" name="cheaTFdb" id="encode2015" value="ENCODE 2015">
                                                                                    ENCODE 2015
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="radio" name="cheaTFdb" id="chea-encode" value="ChEA & ENCODE Consensus">
                                                                                    ChEA & ENCODE Consensus
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="radio" name="cheaTFdb" id="transfac-jaspar" value="Transfac and Jaspar">
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
                                                        <div class="card-header py-1 border-0" role="tab" id="g2n-settings">
                                                            <a class="collapsed" data-toggle="collapse" href="#g2n-collapse" aria-expanded="false" aria-controls="g2n-collapse">
                                                                G2N
                                                            </a>
                                                        </div>
                                                        <div id="g2n-collapse" class="collapse" role="tabpanel" aria-labelledby="g2n-settings" data-parent="#accordion">
                                                            <div class="card-body">

                                                                <div class="form-group row align-items-center">
                                                                    <label for="path_length" class="col-form-label col-sm-9">Path length</label>
                                                                    <div class="col-sm-3">
                                                                        <input class="form-control form-control-sm" type="text" value="2" id="path_length">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group row align-items-center">
                                                                    <label for="min_number_of_articles_supporting_interaction" class="col-form-label col-sm-9">Minimum number of articles</label>
                                                                    <div class="col-sm-3">
                                                                        <input class="form-control form-control-sm" type="text" value="2" id="min_number_of_articles_supporting_interaction">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group row align-items-center">
                                                                    <label for="max_number_of_interactions_per_protein" class="col-form-label col-sm-9">Maximum number of interactions per protein</label>
                                                                    <div class="col-sm-3">
                                                                        <input class="form-control form-control-sm" type="text" value="200" id="max_number_of_interactions_per_protein">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group row align-items-center">
                                                                    <label for="max_number_of_interactions_per_article" class="col-form-label col-sm-9">Maximum number of interactions per article</label>
                                                                    <div class="col-sm-3">
                                                                        <input class="form-control form-control-sm" type="text" value="100" id="max_number_of_interactions_per_article">
                                                                    </div>
                                                                </div>
                                                                <hr/>
                                                                <div class="form-group" id="g2n-ppi">
                                                                    <label>PPI Networks</label>
                                                                    <div class="row">
                                                                        <div class="col-sm-4">
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="checkbox" name="enable_Biocarta" value="true" checked>
                                                                                    Biocarta
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="checkbox" name="enable_BioGRID" value="true" checked>
                                                                                    BioGRID
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="checkbox" name="enable_BioPlex" value="true" checked>
                                                                                    BioPlex
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="checkbox" name="enable_DIP" value="true" checked>
                                                                                    DIP
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-sm-4">
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="checkbox" name="enable_huMAP" value="true" checked>
                                                                                    huMAP
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="checkbox" name="enable_InnateDB" value="true" checked>
                                                                                    InnateDB
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="checkbox" name="enable_IntAct" value="true" checked>
                                                                                    IntAct
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="checkbox" name="enable_KEGG" value="true" checked>
                                                                                    KEGG
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-sm-4">
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="checkbox" name="enable_MINT" value="true" checked>
                                                                                    MINT
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="checkbox" name="enable_ppid" value="true" checked>
                                                                                    ppid
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="checkbox" name="enable_SNAVI" value="true" checked>
                                                                                    SNAVI
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
                                                        <div class="card-header py-1 border-0" role="tab" id="kea-settings">
                                                            <a class="collapsed" data-toggle="collapse" href="#kea-collapse" aria-expanded="false" aria-controls="kea-collapse">
                                                                KEA
                                                            </a>
                                                        </div>
                                                        <div id="kea-collapse" class="collapse" role="tabpanel" aria-labelledby="kea-settings" data-parent="#accordion">
                                                            <div class="card-body">
                                                                <div class="form-group">
                                                                    <div class="row align-items-center">
                                                                        <label class="col-form-label col-sm-5">Sort by</label>
                                                                        <div class="col-sm-7" id="kea-sorting">
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="radio" name="keaSorting" id="kea-pvalue" value="p-value" checked>
                                                                                    p-value
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="radio" name="keaSorting" id="kea-rank" value="rank">
                                                                                    rank
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="radio" name="keaSorting" id="kea-combscore" value="combined score">
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
                                <p>
                                    X2K Web infers upstream regulatory networks from differentially expressed genes.
                                    It integrates ChIP-Seq/Chip data, position weight matrices, proteinâprotein
                                    interactions and kinaseâsubstrate phosphorylation data from ChEA, KEA and G2N apps.
                                </p>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
        </div>
    </div>
    <!--ChEA-->
    <div class="tab-pane fade" id="nav-chea" role="tabpanel" aria-labelledby="nav-chea-tab">
        <div class="row justify-content-center">
            <div id="chea" class="col-sm-7 text-left">
                <%@ include file="chea.html"%>
            </div>
        </div>
    </div>
    <!--G2N-->
    <div class="tab-pane fade" id="nav-g2n" role="tabpanel" aria-labelledby="nav-g2n-tab">
        <div class="row justify-content-center">
            <div id="g2n" class="col-sm-7 text-left">
                <%@ include file="g2n.html"%>
            </div>
        </div>
    </div>
    <!--KEA-->
    <div class="tab-pane fade" id="nav-kea" role="tabpanel" aria-labelledby="nav-kea-tab">
        <div class="row justify-content-center">
            <div id="kea" class="col-sm-7 text-left">
                <%@ include file="kea.html"%>
            </div>
        </div>
    </div>

    <!--Help-->
    <div class="tab-pane fade" id="nav-about" role="tabpanel" aria-labelledby="nav-about-tab">
        <div class="row justify-content-center">
            <div id="about" class="col-sm-7 text-left my-5">
                <p>
                    X2K Web is an online tool used to infer upstream regulatory
                    networks from differentially expressed genes. Combining the <a
                        href="http://amp.pharm.mssm.edu/Enrichr">ChEA</a>, Genes2Networks,
                    and <a href="http://www.maayanlab.net/KEA2/">KEA</a> apps
                    together, X2K Web produces inferred networks of transcription
                    factors, proteins, and kinases which take part in the upstream
                    regulation of the inputted gene list. X2K web also allows users to
                    analyze their differentially expressed gene lists using ChEA, G2N,
                    and KEA individually. To read more about the concept of X2K, you
                    can read about it <a href="http://www.maayanlab.net/X2K/">here</a>.
                </p>

                <h4>Instructional Video</h4>

                <iframe width="560" height="315" src="https://www.youtube.com/embed/ipchvqQhdpc" frameborder="0"
                        allowfullscreen></iframe>
            </div>
        </div>
    </div>

    <!--API-->
    <div class="tab-pane fade" id="nav-api" role="tabpanel" aria-labelledby="nav-api-tab">
        <div class="row justify-content-center">
            <div id="api" class="col-sm-7 text-left my-5">
                <p>API</p>
            </div>
        </div>
    </div>

    <!--Commandline-->
    <div class="tab-pane fade" id="nav-commandline" role="tabpanel" aria-labelledby="nav-commandline-tab">
        <div class="row justify-content-center">
            <div id="commandline" class="col-sm-7 text-left my-5">
                You can download command line standalone versions of the X2K tools in JAR format.
                Command near each download link suggests usage:
                <p>
                    <a href=http://www.maayanlab.net/X2K/download/install_X2K.jar>X2K with source code (61.3 MB)</a>
                    <code>java -jar X2K.jar genelist output.xml</code>
                </p>
                <p>
                    <a href=http://www.maayanlab.net/X2K/download/X2K-1.5-SNAPSHOT-jar-with-dependencies.jar>X2Konly
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
        </div>
    </div>
    <!--Datasets-->
    <div class="tab-pane fade" id="nav-datasets" role="tabpanel" aria-labelledby="nav-datasets-tab">
        <div class="row justify-content-center">
            <div id="datasets" class="col-sm-7 text-left my-5">
                <div class="row">
                    <div class="col-sm-4">
                        <h5>Protein-Protein Interaction</h5>
                        <p><a href="datasets/Biocarta.sig"> Biocarta </a></p>
                        <p><a href="datasets/BioGrid.sig"> BioGrid </a></p>
                        <p><a href="datasets/BioPlex.sig"> BioPlex </a></p>
                        <p><a href="datasets/DIP.sig"> DIP </a></p>
                        <p><a href="datasets/huMAP.sig"> huMAP </a></p>
                        <p><a href="datasets/innateDB.sig"> innateDB </a></p>
                        <p><a href="datasets/IntAct.sig"> IntAct </a></p>
                        <p><a href="datasets/KEGG.sig"> KEGG </a></p>
                        <p><a href="datasets/MINT.sig"> MINT </a></p>
                        <p><a href="datasets/ppid.sig"> ppid </a>
                        <p><a href="datasets/SNAVI.sig"> SNAVI </a></p>
                    </div>

                    <div class="col-sm-4">
                        <h5>Transcriptional Regulation</h5>
                        <p><a href="datasets/ChEA2015.zip"> ChEA 2015 </a></p>
                        <p><a href="datasets/ENCODE2015.zip"> ENCODE 2015 </a></p>
                        <p><a href="datasets/Consensus.zip"> ChEA & ENCODE Consensus </a></p>
                        <p><a href="datasets/TransfacAndJaspar.zip"> TRANSFAC & JASPAR </a></p>
                    </div>

                    <div class="col-sm-4">
                        <h5>Kinome Regulation</h5>
                        <p><a href="datasets/KEA.zip"> KEA 2015 </a></p>
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