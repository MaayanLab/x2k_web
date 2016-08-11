<%--
  Created by IntelliJ IDEA.
  User: maayanlab
  Date: 7/27/16
  Time: 12:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Results</title>
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="css/main.css">
    <script type="text/javascript" src="js/chea_and_kea.js"></script>
    <script src="js/exportJson.js"></script>
    <script src="js/jquery-3.0.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.6/Chart.bundle.min.js"></script>
    <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-578e939ffe83e029"></script>
</head>
<body>

    <script>
        var json_file = ${json};
    </script>


    <div id="everything">
        <div id="top_container">
            <a href="/X2K"><img id="logo" src="x2k_logo_v4.png" alt="HTML5 Icon" width="150" height="90"></a>



            <div id="download_buttons">
                Download results:
                <br>
                <a id ="exportData" onclick="exportJson(this,json_file.type,JSON.stringify(json_file));"><button type="button">Download Data as CSV</button></a>
                <br>
            </div>

            <div id = pagetop_spacer></div>

            <div>
                <a href="/X2K"><button class="back_button">New X2K analysis</button></a>
            </div>

        </div>
        <div class="clear"></div>


        <ul class="tab">
            <li><a id="chart_tab" href="#" class="tablinks active" onclick="opentab(event, 'Chart')">Chart</a></li>
            <li><a id="table_tab" href="#" class="tablinks" onclick="opentab(event, 'Table')">Table</a></li>
        </ul>







        <div id="Chart" class ="tabcontent">
            <canvas id="chart_canvas"></canvas>
        </div>
        <div id="Table" class="tabcontent">

            <table id="data_table">
                <col width="400">
                <col width="90">
                <col width="90">
                <col width="90">
                <tr>
                    <th class="table_left">Name</th>
                    <th>P-Value</th>
                    <th>Z-Score</th>
                    <th>Combined Score</th>
                </tr>

            </table>

        </div>
        <script>document.getElementById("chart_tab").click();</script>

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
