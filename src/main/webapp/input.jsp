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
		<!-- javascript imports -->
		<script src="js/jquery-3.0.0.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.6/Chart.bundle.min.js"></script>
		<script type="text/javascript" src="js/index.js"></script>
		<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-578e939ffe83e029"></script>
		<!-- load favicon -->
		<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
		<!-- css -->
		<link rel="stylesheet" href="css/main.css">
	</head>

	<body>
		<div id="everything">

			<!-- x2k_web logo image -->
			<a href="/X2K"><img id="logo" src="x2k_logo_v4.png" alt="HTML5 Icon" width="150" height="90"></a>

			<div id = top_bar>
				<div class="clear"></div>
				<h3 id="settings_text" class="top_bar_text">Settings</h3>
				<h3 id="info_text" class="top_bar_text">Information</h3>
				<div class="clear"></div>
			</div>

			<!-- the form that occupies most of the page, storing all settings -->
			<form id="settings_form" action="network" method="POST" enctype="multipart/form-data">
				
				<!-- tab selector -->
				<ul class="tab">
			        <li><a id="x2k_tab" href="#" class="settings tablinks" onclick="opentab(event, 'X2K Analysis')">X2K</a></li>
			        <li><a id="tf_tab" href="#" class="settings tablinks active" onclick="opentab(event, 'Transcription Factors')">ChEA</a></li>
					<li><a id="ppi_tab" href="#" class="settings tablinks" onclick="opentab(event, 'Protein Network')">Genes2Networks</a></li>
					<li><a id="kin_tab" href="#" class="settings tablinks" onclick="opentab(event, 'Kinases')">KEA</a></li>
			        <li><a id="downloads_tab" href="#" class="tablinks" onclick="opentab(event, 'Downloads')">Downloads</a></li>
			        <li><a id="about_tab" href="#" class="tablinks" onclick="opentab(event, 'About')">About</a></li>
			        <li><a id="stats_tab" href="#" class="tablinks" onclick="opentab(event, 'Statistics')">Statistics</a></li>
			        <li><a id="help_tab" href="#" class="tablinks" onclick="opentab(event, 'Help')">Help</a></li>
	    		</ul>

	    		<!-- tabs -->

	    		<div id="X2K Analysis" class="tabcontent">
			        Minimum number of proteins in network:
			        <input type="text" name="${X2K.MINIMUM_NETWORK_SIZE}" size="3" value="50"><br>
	    		</div>

	    		<div id="Downloads" class="tabcontent">

					Download the datasets used in X2K analysis:

			        <dl>
			            <dt>Transcription Factor Datasets</dt>
			            <dd><a href="datasets/ChEA2015.zip"> ChEA 2015 </a></dd>
			            <dd><a href="datasets/ENCODE2015.zip"> ENCODE 2015 </a></dd>
			            <dd><a href="datasets/Consensus.zip"> ChEA & ENCODE Consensus </a></dd>
			            <dd><a href="datasets/TransfacAndJaspar.zip"> Transfac & Jaspar </a></dd>
			        </dl>

			        <dl>
			            <dt>Protein-Protein Interaction Datasets</dt>
			            <dd><a href="datasets/Biocarta.sig"> Biocarta </a></dd>
			            <dd><a href="datasets/BioGrid.sig"> BioGrid </a></dd>
			            <dd><a href="datasets/DIP.sig"> DIP </a></dd>
			            <dd><a href="datasets/innateDB.sig"> innateDB </a></dd>
			            <dd><a href="datasets/IntAct.sig"> IntAct </a></dd>
			            <dd><a href="datasets/KEGG.sig"> KEGG </a></dd>
			            <dd><a href="datasets/MINT.sig"> MINT </a></dd>
			            <dd><a href="datasets/ppid.sig"> ppid </a></dd>
			            <dd><a href="datasets/SNAVI.sig"> SNAVI </a></dd>
			        </dl>

			        <dl>
			            <dt>Kinase Dataset</dt>
			            <dd><a href="datasets/KEA.zip"> KEA </a></dd>
			        </dl>
	    		</div>

			    <div id="Transcription Factors" class="tabcontent">
					Sort by:
					<input type="radio" name="${ChEA.SORT_BY}" value="${ChEA.PVALUE}"> p-value
					<input type="radio" name="${ChEA.SORT_BY}" value="${ChEA.RANK}"> rank
					<input type="radio" name="${ChEA.SORT_BY}" value="${ChEA.COMBINED_SCORE}" checked="checked"> combined score<br><br>
					Background organism:
					<input type="radio" name="${ChEA.INCLUDED_ORGANISMS}" value="${ChEA.MOUSE_ONLY}"> mouse
					<input type="radio" name="${ChEA.INCLUDED_ORGANISMS}" value="${ChEA.HUMAN_ONLY}"> human
					<input type="radio" name="${ChEA.INCLUDED_ORGANISMS}" value="${ChEA.BOTH}" checked="checked"> both<br><br>
					Transcription factor database:<br>
					<input type="radio" name="${ChEA.BACKGROUND_DATABASE}" value="${ChEA.CHEA_2015}" checked="checked"> ChEA 2015 <br>
					<input type="radio" name="${ChEA.BACKGROUND_DATABASE}" value="${ChEA.ENCODE_2015}"> ENCODE 2015 <br>
					<input type="radio" name="${ChEA.BACKGROUND_DATABASE}" value="${ChEA.CONSENSUS}"> ChEA & ENCODE Consensus <br>
					<input type="radio" name="${ChEA.BACKGROUND_DATABASE}" value="${ChEA.TRANS_JASP}"> Transfac & Jaspar<br>
			    </div>

			    <div id="Protein Network" class="tabcontent">
					<input type="text" name="${Genes2Networks.PATH_LENGTH}" size="5" value="2"> Path Length<br>
					<input type="text" name="${Genes2Networks.MINIMUM_NUMBER_OF_ARTICLES}" size="5" value="2"> Minimum Number of Articles<br>
					<input type="text" name="${Genes2Networks.MAXIMUM_NUMBER_OF_EDGES}" size="5" value="200"> Maximum Number of Edges per Node<br>
					<input type="text" name="${Genes2Networks.MAXIMUM_NUMBER_OF_INTERACTIONS}" size="5" value="100"> Maximum Number of Interactions per Article<br>

					<!-- experiment -i've been told this works even though its shady  -->

					<br>
					Use the following PPI Networks:
					<br>

					<input type="checkbox" name="${Genes2Networks.ENABLE_BIOCARTA}" value="true" checked> Biocarta
					<input type="hidden" name="${Genes2Networks.ENABLE_BIOCARTA}" value="false">

					<input type="checkbox" name="${Genes2Networks.ENABLE_BIOGRID}" value="true" checked> BioGRID
					<input type="hidden" name="${Genes2Networks.ENABLE_BIOGRID}" value="false">

					<input type="checkbox" name="${Genes2Networks.ENABLE_DIP}" value="true" checked> DIP
					<input type="hidden" name="${Genes2Networks.ENABLE_DIP}" value="false">

					<input type="checkbox" name="${Genes2Networks.ENABLE_INNATEDB}" value="true" checked> InnateDB
					<input type="hidden" name="${Genes2Networks.ENABLE_INNATEDB}" value="false">

					<br>

					<input type="checkbox" name="${Genes2Networks.ENABLE_INTACT}" value="true" checked> IntAct
					<input type="hidden" name="${Genes2Networks.ENABLE_INTACT}" value="false">

					<input type="checkbox" name="${Genes2Networks.ENABLE_KEGG}" value="true" checked> KEGG
					<input type="hidden" name="${Genes2Networks.ENABLE_KEGG}" value="false">

					<input type="checkbox" name="${Genes2Networks.ENABLE_MINT}" value="true" checked> MINT
					<input type="hidden" name="${Genes2Networks.ENABLE_MINT}" value="false">


					<input type="checkbox" name="${Genes2Networks.ENABLE_PPID}" value="true" checked> ppid
					<input type="hidden" name="${Genes2Networks.ENABLE_PPID}" value="false">

					<input type="checkbox" name="${Genes2Networks.ENABLE_SNAVI}" value="true" checked> SNAVI
					<input type="hidden" name="${Genes2Networks.ENABLE_SNAVI}" value="false">
			    </div>

			    <div id="Kinases" class="tabcontent">
					<input type="radio" name="${KEA.SORT_BY}" value="${KEA.PVALUE}" checked="checked"> p-value
					<input type="radio" name="${KEA.SORT_BY}" value="${KEA.RANK}"> rank
					<input type="radio" name="${KEA.SORT_BY}" value="${KEA.COMBINED_SCORE}" checked="checked"> combined score<br>
			    </div>

			    <div id="Statistics" class="tabcontent">
			        <div id="ChEA_stats">
			            <h3 class="stat_category">ChEA Datasets</h3>
			            <p>Histograms for each of the ChEA datasets depicting the number of nodes with certain
						   numbers of interactions per node in the Transcription Factor-Transcription Factor network.
						</p><br>
			        </div>
		            <div class="clear"></div>

			        <div id="G2N_stats">
			            <h3 class="stat_category">G2N Datasets</h3>
			            <p> Histograms for each of the Genes2Networks datasets depicting the number of nodes with certain
							numbers of interactions per node in the Protein-Protein Interaction Netowork. </p>
			        </div>
			        <div class="clear"></div>

			        <div id="KEA_stats">
			            <h3 class="stat_category">KEA Datasets</h3>
			            <p> Histograms for each of the KEA datasets depicting the number of nodes with certain
							numbers of interactions per node in the Kinase-Kinase network.</p>
			        </div>
			        <div class="clear"></div>
			    </div>

			    <div id="About" class="tabcontent">
					<p>
						X2K Web is an online tool used to infer upstream regulatory networks from differentially expressed genes.
						Combining the
						<a href="http://amp.pharm.mssm.edu/lib/chea.jsp">ChEA</a>,
						<a href="http://amp.pharm.mssm.edu/genes2networks/">Genes2Networks</a>, and
						<a href="http://amp.pharm.mssm.edu/lib/kea.jsp">KEA</a>
						apps together, X2K Web produces inferred networks of transcription factors, proteins, and kinases
						which take part in the upstream regulation of the inputted gene list. X2K web also allows users to
						analyze their differentially expressed gene lists using ChEA, G2N, and KEA individually. To read more about
						the concept of X2K, you can read about it <a href="http://www.maayanlab.net/X2K/">here</a>. To learn how to
						use X2K web, please click on the Help tab.
					</p>
			    </div>
			    
			    <div id="Help" class="tabcontent">
			        <p>
						X2K Web offers four different analysis options: ChEA, Genes2Networks, KEA, and the full X2K pipeline.
						Despite producing different analyses, their usage is relatively similar. All of them require 3 main steps:
						<ol>
							<li>
								<b>Input your gene list.</b> You can input your list of differentially expressed gene list either
								by copy pasting the genes into the "Input Genes as Text" box bellow. Make sure that it is formatted
								such that there is a single gene name per line with no other separators (e.g. no commas). Alternatively
								you can select a file from your computer using the "Choose File" button. In this case, make sure that
								the genes in that file follow the format of a single gene name per line with no additional separators.
							</li>
							<li>
								<b>Configure your settings.</b> Now, you can browse through the various settings in the blue settings
								tabs at the top of the page. If you want to run the full X2K pipeline, all of the settings tabs will
								be taken into account. However, if you want to run just ChEA, Genes2Networks, or KEA, then you should
								only configure the settings in that specific tab. It's OK if you change other ones, but they just won't
								be taken into account when the analysis is conducted.
							</li>
							<li>
								<b>Run the analysis.</b> Now that your gene list is inputted and your settings configured, you should
								be ready to actually run your analysis. Click the run button you want under "Analyze Inputs" and wait
								for the results page to load!
							</li>
						</ol>
					</p>
			    </div>

			    <br>

				<img id="loading_wheel" src="default.svg" style="display:none;">

			    <div id="pageBottom">
					<div id="textInput">
						<h4 class="stats_name" id="text_gene_input_title">Input Genes As Text</h4>
						<textarea rows="12" name = "textGenes" id="textGenes"></textarea><br>
						<input type="button" value="Sample Genelist" id="sampleGenes" onclick="return insertExample()">
					</div>
					<div id="fileInput">
						<h4 class="stats_name">Input Genes As File</h4>
						<input id="file_upload" type="file" name="geneList">
					</div>
		            <div id="runButtons">
		            	<h4 class="stats_name">Analyze Inputs</h4>
						<button type="submit" id="x2k_submit"> Run X2K</button>{all settings apply}
						<button type="submit" id="chea_submit"> Run ChEA</button>{only ChEA settings apply}<br>
						<button type="submit" id="g2n_submit"> Run G2N</button>{only G2N settings apply}<br>
						<button type="submit" id="kea_submit"> Run KEA</button>{only KEA settings apply}<br>
		            </div>


	        	</div>
			</form>

			<div class="clear"></div>

			<div id="descriptionText" class="description">
				Welcome to X2K Web! Input a gene list either by choosing a file from your computer or by pasting it directly
				into the input box. Then, customize your analysis through the settings tabs at the top of the page. Finally,
				run your desired analysis using the run buttons provided. For further information, click on the Help tab.
			</div>

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