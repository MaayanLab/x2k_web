<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Results</title>

	<script>
	    var json_file = ${json};
	</script>

    <script src="js/exportJson.js"></script>
    <script src="js/jquery-3.0.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.6/Chart.bundle.min.js"></script>

	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="http://www.w3schools.com/lib/w3data.js"></script>
	<script src="js/results.js"></script>


    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato:300,400,700">
    <link rel="stylesheet" href="css/results.css">
    <link rel="stylesheet" href="css/main.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="https://jqueryui.com/resources/demos/style.css">

</head>
<body>
	<!-- header -->
    <%@ include file="templates/frame/header.html" %>
	<script>
		w3IncludeHTML();
	</script>
	
	<div id=pagetop_spacer></div>

	<!-- buttons -->
	<div id="buttons-panel" style="float: left; width: 160px;">

		<div>
			<button type="button" id="x2k-button" class="selected">X2K</button>
		</div>
		<div>
			<button type="button" id="chea-button">ChEA</button>
		</div>
		<div>
			<button type="button" id="g2n-button">G2N</button>
		</div>
		<div>
			<button type="button" id="kea-button">KEA</button>
		</div>
	</div>

	<!-- results -->
	<div id="results">
		<!-- x2k -->
		<div id="tabs-x2k" style="display: block">
			<ul>
				<li><a href="#x2k-network">Network</a></li>
			</ul>

			<!-- network -->
			<div id="x2k-network">
			</div>
		    <div id="download_buttons">
		        <a id="exportData" onclick="exportJson(this,'results',JSON.stringify(json_file['X2K']));">
		            <button type="button" id="download-button">Download Data as CSV</button>
		        </a>
		    </div>			
		</div>

		<!-- chea -->
		<div id="tabs-chea" style="display: none">
			<ul>
				<li><a href="#bargraph-chea">Bargraph</a></li>
				<li><a href="#table-chea">Table</a></li>
			</ul>

			<!-- bargraph -->
			<div id="bargraph-chea">
			</div>

			<!-- table -->
		    <div id="chea" class="results-table">
			    <table border="1"  id="chea-table">
			    	<tr>
				    	<th>Term</th>
				    	<th>P-value</th>
				    	<th>Z-score</th>
				    	<th>Combined Score</th>
			    	</tr>
			    </table>
		    </div>
		    <div id="download_buttons">
		        <a id="exportData" onclick="exportJson(this,'results',JSON.stringify(json_file['ChEA']));">
		            <button type="button" id="download-button">Download Data as CSV</button>
		        </a>
		    </div>		    
		</div>

		<!-- g2n -->
		<div id="tabs-g2n" style="display: none">
			<ul>
				<li><a href="#network-g2n">Network</a></li>
			</ul>

			<!-- network -->
			<div id="network-g2n"></div>
		    <div id="download_buttons">
		        <a id="exportData" onclick="exportJson(this,'results',JSON.stringify(json_file['G2N']));">
		            <button type="button" id="download-button">Download Data as CSV</button>
		        </a>
		    </div>			
		</div>

		<!-- kea -->
		<div id="tabs-kea" style="display: none">	
			<ul>
				<li><a href="#bargraph-kea">Bargraph</a></li>
				<li><a href="#table-kea">Table</a></li>
			</ul>

			<!-- bargraph -->
			<div id="bargraph-kea"></div>

			<!-- table -->
		    <div id="kea" class="results-table">
			    <table border="1" id="kea-table">
			    	<tr>
				    	<th>Term</th>
				    	<th>P-value</th>
				    	<th>Z-score</th>
				    	<th>Combined Score</th>
			    	</tr>
			    </table>
		    </div>
		    <div id="download_buttons">
		        <a id="exportData" onclick="exportJson(this,'results',JSON.stringify(json_file['KEA']));">
		            <button type="button" id="download-button">Download Data as CSV</button>
		        </a>
		    </div>		    
		</div>
	</div>

	<div class="clear"></div>
    <%@ include file="templates/frame/footer.html" %>
    
</div>	
</body>
</html>