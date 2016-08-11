
<%@ page language="java" contentType="text/html; charset=US-ASCII"
         pageEncoding="US-ASCII"%>
<%@ page import="edu.mssm.pharm.maayanlab.X2K.web.*" %>
<%@ page import="edu.mssm.pharm.maayanlab.X2K.enrichment.*" %>
<%@ page import="edu.mssm.pharm.maayanlab.ChEA.*" %>
<%@ page import="edu.mssm.pharm.maayanlab.Genes2Networks.*" %>
<%@ page import="edu.mssm.pharm.maayanlab.KEA.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <title>X2K Results</title>
    <link rel="stylesheet" href="css/main.css">
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="cytoscape/jquery.qtip.min.css">
    <%--need this for the export_json function--%>
    <script src="js/exportJson.js"></script>
    <script src="js/network.js"></script>
    <!-- Go to www.addthis.com/dashboard to customize your tools -->
    <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-578e939ffe83e029"></script>

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="cytoscape/jquery.min.js"></script>
    <script src="cytoscape/cytoscape.min.js"></script>
    <script src="cytoscape/jquery.qtip.min.js"></script>
    <script src="cytoscape/cytoscape-qtip.js"></script>
    <script src="cytoscape/cola.v3.min.js"></script>
    <script src="cytoscape/cytoscape-cola.js"></script>
</head>




<body bgcolor=white>
<div id="everything">
    <script>
        json_file = ${json};
        console.log(json_file);
    </script>

    <div id="top_container">
        <a href="/X2K"><img id="logo" src="x2k_logo_v4.png" alt="HTML5 Icon" width="150" height="90"></a>



        <div id="download_buttons">
            Download results:
            <br>
            <a id ="exportNetwork" onclick="exportJson(this,json_file.type,network_string);"><button class="download_button">Download Network as JSON</button></a>
        </div>

        <div id="legend">
            Network legend:
            <ul class="no_bullet">
                <li class="legend"> <svg height="12" width="12"> <circle cx="6" cy="6" r="6" fill=#46494C /> </svg> Seed Protein</li>
                <li class="legend"> <svg height="12" width="12"> <circle cx="6" cy="6" r="6" fill=#00CC99 /> </svg> Inermediate Protein</li>
            </ul>
        </div>
        <div>
            <a href="/X2K"><button class="back_button">New X2K analysis</button></a>
        </div>

    </div>

    <div id="graph"></div>

    <div id="footer">
        <div class="container">
            <div id="affiliations">
                <h4>Affiliations</h4>
                <ul id="affiliations_list">
                    <li><a href="http://icahn.mssm.edu/research/labs/maayan-laboratory" target="_blank">The Ma'ayan
                        Lab</a></li>
                    <li><a href="http://www.lincs-dcic.org/" target="_blank">BD2K-LINCS Data Coordination and
                        Integration Center (DCIC)</a></li>
                    <li><a href="http://www.lincsproject.org/">NIH LINCS program</a></li>
                    <li><a href="http://bd2k.nih.gov/" target="_blank">NIH Big Data to Knowledge (BD2K)</a></li>
                    <li><a href="https://commonfund.nih.gov/idg/index" target="_blank">NIH Illuminating the Druggable
                        Genome (IDG) Program</a></li>
                    <li><a href="http://icahn.mssm.edu/" target="_blank">Icahn School of Medicine at Mount Sinai</a>
                    </li>
                </ul>
            </div>
            <div id="social_media">

                <!-- Go to www.addthis.com/dashboard to customize your tools -->
                <div id="social_buttons" class="addthis_sharing_toolbox"></div>

            </div>
        </div>
        <div class="clear"></div>
        <br>
        <div>
            <h4>Updated from</h4>
            <a href="http://www.ncbi.nlm.nih.gov/pubmed/22080467"> Chen EY, Xu H, Gordonov S, Lim MP, Perkins MH, Ma'ayan A. Expression2Kinases: mRNA Profiling Linked to Multiple Upstream Regulatory Layers. Bioinformatics. (2012) 28 (1): 105-111</a>
        </div>
    </div>


</div>
</body>
</html>