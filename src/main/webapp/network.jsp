<%@ page language="java" contentType="text/html; charset=US-ASCII"
         pageEncoding="US-ASCII" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="edu.mssm.pharm.maayanlab.X2K.web.*" %>
<%@ page import="edu.mssm.pharm.maayanlab.X2K.enrichment.*" %>
<%@ page import="edu.mssm.pharm.maayanlab.ChEA.*" %>
<%@ page import="edu.mssm.pharm.maayanlab.Genes2Networks.*" %>
<%@ page import="edu.mssm.pharm.maayanlab.KEA.*" %>

<html>
<head>
    <title>X2K Results</title>
    <link rel="stylesheet" href="css/main.css">
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
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
<div id="page">

    <script>
        json_file = ${json};
        console.log(json_file);
    </script>

    <%@ include file="templates/frame/header.html" %>

    <div id="top_container">
        <div id="download_buttons">
            Download results:
            <br>
            <a id="exportNetwork" onclick="exportJson(this,json_file.type,network_string);">
                <button class="download_button">Download Network as JSON</button>
            </a>
            <br>
            <a id="exportTFs" onclick="exportJson(this,'top_ranked_tfs',tf_string);">
                <button class="download_button">Download TFs as CSV</button>
            </a>
            <br>
            <a id="exportKinases" onclick="exportJson(this,'top_ranked_kinases',kinase_string);">
                <button class="download_button">Download Kinases as CSV</button>
            </a>
        </div>

        <div id="legend">
            <ul class="no_bullet">

                <li class="legend">
                    <svg height="12" width="12">
                        <circle cx="6" cy="6" r="6" fill="#DD4484"/>
                    </svg>
                    Transcription Factor
                </li>
                                <li class="legend">
                    <svg height="12" width="12">
                        <circle cx="6" cy="6" r="6" fill="#C490D1"/>
                    </svg>
                    Intermediate protein                    
                </li>
                                <li class="legend">
                    <svg height="12" width="12">
                        <circle cx="6" cy="6" r="6" fill="#ABDAFC"/>
                    </svg>
                    Kinase
                </li>
            </ul>
        </div>

    </div>

    <div id="graph"></div>
	 <%@ include file="templates/frame/footer.html" %>


</div>
</body>
</html>