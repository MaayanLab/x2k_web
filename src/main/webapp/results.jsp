<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Results</title>

	<script>
	    var json_file = ${json};
	</script>

    <script src="js/jquery-3.0.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.6/Chart.bundle.min.js"></script>
	<script src="http://d3js.org/d3.v3.min.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="http://www.w3schools.com/lib/w3data.js"></script>
	<script src="https://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>
	<script src="js/bargraph.js"></script>
	<script src="js/results.js"></script>
	<script src="js/network.js"></script>
	<script src="js/jquery.atooltip.pack.js"></script>


    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato:300,400,700">
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/results.css">
    <link rel="stylesheet" href="css/bargraph.css">
    <link rel="stylesheet" href="css/network.css">
    <link rel="stylesheet" href="css/atooltip.css">
    <link rel="stylesheet" href="css/jquery.dataTables.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="https://jqueryui.com/resources/demos/style.css">

</head>
<body>
<div id="page">
	<!-- header -->
    <%@ include file="templates/frame/header.html" %>
	<script>
		w3IncludeHTML();
	</script>

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
			<div id="x2k-desc">
				<p>Subnetwork of upstream transcription factors, intermediate proteins, and protein kinases.</p>
			</div>
			<ul>
				<li><a href="#x2k-network">Subnetwork</a></li>
			</ul>

			<!-- network -->
			<div id="x2k-network">
			</div>
			<div id="legend">
			  <ul class="no_bullet">
			    <li class="legend"><svg id="legend-dot" height="12" width="12"><circle cx="6" cy="6" r="6" fill="#1F77B4"/></svg>Transcription Factor</li>
			    <li class="legend"><svg id="legend-dot" height="12" width="12"><circle cx="6" cy="6" r="6" fill="#FF7F0E"/></svg>Intermediate protein</li>
			    <li class="legend"><svg id="legend-dot" height="12" width="12"><circle cx="6" cy="6" r="6" fill="#AEC7E8"/></svg>Kinase</li>
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

		<!-- chea -->
		<div id="tabs-chea" style="display: none">
			<div id="chea-desc">
				<p>Top ten most enriched transcription factors as determined by ChEA or ENCODE.</p>
			</div>
			<ul>
				<li><a href="#bargraph-chea">Bargraph</a></li>
				<li><a href="#chea-table-wrap">Table</a></li>
			</ul>

			<!-- bargraph -->
			<div id="bargraph-chea" class="bargraph">
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
<!-- 		        <a id="exportData" onclick="svgExport('#bargraph-chea', 'ChEA_bargraph', 'jpg'); return false;">
		            <button type="button" id="download-button">JPG</button>
		        </a>
		        <a id="exportData" onclick="svgExport('#bargraph-chea', 'ChEA_bargraph', 'png'); return false;">
		            <button type="button" id="download-button">PNG</button>
		        </a>
		        <a id="exportData" onclick="svgExport('#bargraph-chea', 'ChEA_bargraph', 'svg'); return false;">
		            <button type="button" id="download-button">SVG</button>
		        </a>	 -->	        
		    </div>		    
		</div>

		<!-- g2n -->
		<div id="tabs-g2n" style="display: none">
			<div id="g2n-desc">
			<p>Subnetwork that connects the transcription factors using known protein-protein interactions.</p>
			</div>
			<ul>
				<li><a href="#network-g2n">Subnetwork</a></li>
			</ul>

			<!-- network -->
			<div id="network-g2n"></div>
			<div id="legend">
				<ul class="no_bullet">
					<li class="legend"> <svg id="legend-dot" height="12" width="12"> <circle cx="6" cy="6" r="6" fill="#AEC7E8" /> </svg> Seed Protein</li>
					<li class="legend"> <svg id="legend-dot" height="12" width="12"> <circle cx="6" cy="6" r="6" fill="#1F77B4" /> </svg> Intermediate Protein</li>
				</ul>
			</div>			
		    <div id="download_buttons">
		        <a id="exportData" onclick="exportJson(this, 'G2N', json_file['G2N']);">
		            <button type="button" id="download-button">JSON</button>
		        </a>
<!-- 		        <a id="exportData" onclick="svgExport('#network-g2n', 'G2N_network', 'jpg'); return false;">
		            <button type="button" id="download-button">JPG</button>
		        </a>
		        <a id="exportData" onclick="svgExport('#network-g2n', 'G2N_network', 'png'); return false;">
		            <button type="button" id="download-button">PNG</button>
		        </a>
		        <a id="exportData" onclick="svgExport('#network-g2n', 'G2N_network', 'svg'); return false;">
		            <button type="button" id="download-button">SVG</button>
		        </a> -->
		    </div>			
		</div>

		<!-- kea -->
		<div id="tabs-kea" style="display: none">
			<div id="kea-desc">
				<p>Top ten most enriched protein kinases to regulate the subnetwork as determined by KEA.</p>
			</div>
			<ul>
				<li><a href="#bargraph-kea">Bargraph</a></li>
				<li><a href="#kea-table-wrap">Table</a></li>
			</ul>

			<!-- bargraph -->
			<div id="bargraph-kea" class="bargraph"></div>

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
<!-- 		        <a id="exportData" onclick="svgExport('#bargraph-kea', 'KEA_bargraph', 'jpg'); return false;">
		            <button type="button" id="download-button">JPG</button>
		        </a>
		        <a id="exportData" onclick="svgExport('#bargraph-kea', 'KEA_bargraph', 'png'); return false;">
		            <button type="button" id="download-button">PNG</button>
		        </a>
		        <a id="exportData" onclick="svgExport('#bargraph-kea', 'KEA_bargraph', 'svg'); return false;">
		            <button type="button" id="download-button">SVG</button> -->
		        </a>		        
		    </div>		    
		</div>
	</div>

	<div class="clear"></div>
    <%@ include file="templates/frame/footer.html" %>
    </div>
</body>
</html>