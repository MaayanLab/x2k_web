<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.mssm.pharm.maayanlab.X2K.web.*" %>
<%@ page import="edu.mssm.pharm.maayanlab.X2K.enrichment.*" %>
<%@ page import="edu.mssm.pharm.maayanlab.ChEA.*" %>
<%@ page import="edu.mssm.pharm.maayanlab.Genes2Networks.*" %>
<%@ page import="edu.mssm.pharm.maayanlab.KEA.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>X2K Results</title>
    <link rel="stylesheet" href="css/main.css">
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="dist/cytoscape/jquery.qtip.min.css">

    <script src="dist/js/exportJson.js"></script>
    <script src="dist/js/network.js"></script>

	<script src="http://d3js.org/d3.v3.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
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