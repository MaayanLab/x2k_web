<html>
<head>
    <title>Results</title>

	<script>
	    var json_file = ${json};
	</script>

    <script src="js/exportJson.js"></script>
    <script src="js/jquery-3.0.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.6/Chart.bundle.min.js"></script>
    <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-578e939ffe83e029"></script>
	<script type="text/javascript" src="js/results.js"></script>

    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/results.css">
</head>
<body>

<div id="page">

    <%@ include file="templates/frame/header.html" %>

    <div id="top_container">

        <div id="download_buttons">
            Download results:
            <br>
            <a id="exportData" onclick="exportJson(this,'results',JSON.stringify(json_file));">
                <button type="button">Download Data as CSV</button>
            </a>
            <br>
        </div>

        <div id=pagetop_spacer></div>

    </div>

    <!-- ChEA -->
    <div id='chea' class='results_table'>
	    <table border='1'  id='chea-table'>
	    	<tr>
		    	<th>Term</th>
		    	<th>P-value</th>
		    	<th>Z-score</th>
		    	<th>Combined Score</th>
	    	</tr>
	    </table>
    </div>
    <!-- KEA -->
    <div id='kea' class='results_table'>
	    <table border='1' id='kea-table'>
	    	<tr>
		    	<th>Term</th>
		    	<th>P-value</th>
		    	<th>Z-score</th>
		    	<th>Combined Score</th>
	    	</tr>
	    </table>
    </div>
	<div class="clear"></div>
    <%@ include file="templates/frame/footer.html" %>
    
</div>
</body>
</html>