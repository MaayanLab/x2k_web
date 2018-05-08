<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container-fluid" id="results-dashboard">
    <div class="row">
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
                <!--ChEA-->
        <div class="col-xl-6 d-flex align-items-stretch" id="chea">
            <div class="card w-100">
                <nav class="nav nav-tabs navbar-light bg-light dash-nav" role="tablist">

                    <!-- Title -->
                    <div data-toggle="modal" data-target="#dashboardFullModal" data-whatever="#chea-results" data-name="ChEA" data-modal-title="Transcription Factor Enrichment Analysis (TFEA)">
                        <button type="button" class="expand">
                            <i class="fas fa-expand-arrows-alt" title="Expand" aria-hidden="true"></i>
                            <i class="fas fa-download" title="Download"></i>
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
                        aria-controls="nav-chea-table">Table</a>

                    <!-- Info Popover -->
                    <button class="info-popover-button ml-auto"
                            data-toggle="popover"
                            data-html="true"
                            data-offset="50"
                            data-template='<div class="popover x2k-card-popover" role="tooltip"><div class="arrow"></div><h3 class="popover-header"></h3><div class="popover-body"></div></div>'
                            title="What is Transcription Factor Enrichment Analysis?"
                            data-placement="left"
                            data-content="<div>Transcription Factor Enrichment Analysis (TFEA) is the first step of the X2K pipeline. It <b>predicts transcription factors that are predicted to regulate the input gene list</b> by performing gene set enrichment analysis using different transcription factor gene set libraries, for example, integrated target genes for transcription factors as determined by ChIP-seq experiments (ChEA).</div><div class='mt-3'>A ranked list of the <b>top predicted transcription factors</b> is displayed as a bar graph or as a table. The results can be downloaded as a spreadsheet.</div><div class='mt-3'>The enriched transcription factors are  used as input for the next step of the X2K pipeline, the <b>protein-protein interaction expansion</b>.</div><div class='mt-3 text-muted font-italic'>Note: the results from the TFEA are computational predictions and experimentalists should consider this carefully before attempting to validate any of these predictions experimentally.</div>">
                        <i class="fa fa-question-circle fa-2x text-muted"></i>
                    </button>

                </nav>
                <div id="chea-results" class="card-body">
                    <div class="tab-content" style="display: block;" id="nav-tabContent-chea">
                        <div class="tab-pane fade show active" id="nav-chea-bar" role="tabpanel"
                                aria-labelledby="nav-chea-bar-tab">
                            <div id="bargraph-chea" class="bargraph">
                                <!-- <span style="font-size: 0.7rem;" class="my-auto mr-1 mt-2">Sort by:</span>
                                <div class="mt-0 btn-group btn-group-justified" role="group" aria-label="Sorting type">
                                    <input type="button" class="selected btn btn-outline-secondary btn-sm chea-chart-pvalue"
                                            value="P-value">
                                    <input type="button" class="btn btn-outline-secondary btn-sm chea-chart-zscore" value="Z-score">
                                    <input type="button" class="btn btn-outline-secondary btn-sm chea-chart-combinedScore"
                                            value="Combined score">
                                </div> -->
                                <svg xmlns="http://www.w3.org/2000/svg" version="1.1"
                                    class="chea-chart"
                                    width="100%" height="100%" viewBox="-20 0 1020 600"></svg>
                            </div>
                        </div>

                        <div class="tab-pane fade table-responsive" id="nav-chea-table"
                            role="tabpanel"
                                aria-labelledby="nav-chea-table-tab">
                            <table class="display table table-striped table-bordered table-sm"
                                cellspacing="0" id="chea-table"></table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--G2N-->
        <div class="col-xl-6 d-flex align-items-stretch" id="g2n">
            <div class="card w-100">
                <nav class="nav nav-tabs navbar-light bg-light dash-nav" role="tablist">

                    <!-- Title -->
                    <div data-toggle="modal" data-target="#dashboardFullModal" data-whatever="#network-g2n" data-name="G2N" data-modal-title="Protein-Protein Interaction Expansion">
                        <button type="button" class="expand">
                            <i class="fas fa-expand-arrows-alt" title="Expand" aria-hidden="true"></i>
                            <i class="fas fa-download" title="Download"></i>
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
                            data-content="<div>Protein-Protein Interaction Expansion is the second step of the X2K pipeline. In this step X2K <b>expands the list</b> of enriched transcription factors by identifying proteins that physically interact with these transcription factors using the Genes2Networks (G2N) algorithm. To achieve this, data from many Protein-Protein Interaction databases is integrated.</div><div class='mt-3'>A <b>subnetwork of connected transcription factors and their interacting proteins is visualized as a ball-and-stick diagram</b>. Transcription factors are the pink nodes, while the proteins that connect them  are in grey. The size of the nodes in the network is proportional to their degree.</div><div class='mt-3'>The proteins that were identified in the network expansion step are used as input for the final step of the X2K pipeline, the <b>Kinase Enrichment Analysis</b>.</div><div class='mt-3 text-muted font-italic'Note: the results from the network expansion step are computational predictions, experimentalists should consider this carefully before attempting to validate any of these predictions experimentally.>Note: the results from the network expansion step are computational predictions, experimentalists should consider this carefully before attempting to validate any of these predictions experimentally.</div>">
                        <i class="fa fa-question-circle fa-2x text-muted"></i>
                    </button>

                </nav>
                <div id="network-g2n" class="card-body h-100">
                    <svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="g2n-svg h-100 w-100"
                        preserveAspectRatio="xMinYMin">
                    </svg>
                </div>

            </div>
        </div>

        <!--KEA-->
        <div class="col-xl-6 d-flex align-items-stretch" id="kea">
            <div class="card w-100">
                <nav class="nav nav-tabs navbar-light bg-light dash-nav" role="tablist">

                    <!-- Title -->
                    <div data-toggle="modal" data-target="#dashboardFullModal" data-whatever="#kea-results" data-name="KEA" data-modal-title="Kinase Enrichment Analysis (KEA)">
                        <button type="button" class="expand">
                            <i class="fas fa-expand-arrows-alt" title="Expand" aria-hidden="true"></i>
                            <i class="fas fa-download" title="Download"></i>
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
                            data-content="<div>Kinase Enrichment Analysis (KEA) is the third and final step of the X2K pipeline. KEA <b>predicts the protein kinases that are likely the regulators of the expanded protein-protein interaction network</b> from the previous step. KEA performs enrichment analysis on the list of proteins from the subnetwork using gene set libraries from kinase-substrate interaction databases.</div><div class='mt-3'>A ranked list of the <b>top predicted kinases</b> is displayed as a bar graph and table. The results can be downloaded as a spreadsheet.</div><div class='mt-3'>The top kinases are displayed alongside the predicted transcription factors (Step 1) and expanded regulatory network (Step 2) in the <b>eXpression2Kinases network</b>.</div><div class='mt-3 text-muted font-italic'>Note: the results from the kinase enrichment analysis step are computational predictions, experimentalists should consider this carefully before attempting to validate any of these predictions experimentally.</div>">
                        <i class="fa fa-question-circle fa-2x text-muted"></i>
                    </button>

                </nav>

                <div id="kea-results" class="card-body">
                    <div class="tab-content" id="nav-tabContent-kea">
                        <div class="tab-pane fade show active" id="nav-kea-bar" role="tabpanel"
                                aria-labelledby="nav-kea-bar-tab">
                            <div id="bargraph-kea" class="bargraph">
                                <!-- <span style="font-size: 0.7rem;" class="my-auto mr-1 mt-2">Sort by:</span>
                                <div class="mt-0 btn-group btn-group-justified" role="group" aria-label="Sorting type">
                                    <input type="button" class="selected btn btn-outline-secondary btn-sm kea-chart-pvalue"
                                            value="P-value">
                                    <input type="button" class="btn btn-outline-secondary btn-sm kea-chart-zscore" value="Z-score">
                                    <input type="button" class="btn btn-outline-secondary btn-sm kea-chart-combinedScore"
                                            value="Combined score">
                                </div> -->

                                <svg xmlns="http://www.w3.org/2000/svg" version="1.1"
                                        class="kea-chart"
                                        width="100%" height="100%" viewBox="-20 0 1020 600"></svg>
                            </div>
                        </div>
                        <div class="tab-pane fade table-responsive" id="nav-kea-table"
                                role="tabpanel"
                                aria-labelledby="nav-kea-table-tab">
                            <table class="display table table-striped table-bordered table-sm"
                                cellspacing="0" id="kea-table"></table>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <!--X2K-->
        <div class="col-xl-6 d-flex align-items-stretch" id="x2k">
            <div class="card w-100">
                <nav class="nav nav-tabs navbar-light bg-light dash-nav" role="tablist">

                    <!-- Title -->
                    <div data-toggle="modal" data-target="#dashboardFullModal" data-whatever="#x2k-network" data-name="X2K" data-modal-title="eXpression2Kinases Network" class="cursor-pointer">
                        <button type="button" class="expand cursor-pointer">
                            <i class="fas fa-expand-arrows-alt" title="Expand" aria-hidden="true"></i>
                            <i class="fas fa-download" title="Download"></i>
                        </button>
                        <a class="navbar-brand d-inline-block" href="#"><b>Step 4.</b> eXpression2Kinases Network</a>
                    </div>

                    <!-- Info Popover -->
                    <button class="info-popover-button ml-auto"
                            data-toggle="popover"
                            data-html="true"
                            data-template='<div class="popover x2k-card-popover" role="tooltip"><div class="arrow"></div><h3 class="popover-header"></h3><div class="popover-body"></div></div>'
                            title="What is eXpression2Kinases?"
                            data-placement="left"
                            data-content="<div>The eXpression2Kinases (X2K) network displays the <b>inferred upstream regulatory network predicted to regulate the input list</b> of genes by integrating the results from the TFEA (Step 1), the network expansion (Step 2), and the kinase enrichment (Step 3).</div><div class='mt-3'>Pink nodes represent the <b>top transcription factors</b> predicted to regulate the expression of the input gene list; orange nodes represent proteins that <b>physically interact with the enriched transcription factors and connect them</b>. Blue nodes represent the <b>top predicted protein kinases</b> known to phosphorylate the proteins within the expanded subnetwork.</div><div class='mt-3'>Green network edges/links represent <b>kinase-substrate phosphorylation</b> interactions between kinases and their substrates, while grey network edges represent <b>physical protein-protein interactions</b>.</div><div class='mt-3 text-muted font-italic'>Note: this network is a results of computational predictions, experimentalists should consider this carefully before attempting to validate any of these predictions experimentally.</div>">
                        <i class="fa fa-question-circle fa-2x text-muted"></i>
                    </button>

                </nav>
                <div id="x2k-network" class="card-body h-100">
                    <svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="x2k-svg h-100 w-100" id="x2ksvg"
                        preserveAspectRatio="xMinYMin">
                    </svg>
                </div>
            </div>
        </div>
    </div>
</div>

<!--Modals-->
<div class="modal fade" id="dashboardFullModal" tabindex="-1" role="dialog"
        aria-labelledby="dashboardFullModalLabel"
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
                <span>Download results as:</span>
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
                    <button type="button" class="btn btn-outline-primary cytoscape-button">Cytoscape JSON</button>
                </a>
            </div>
        </div>
    </div>
</div>