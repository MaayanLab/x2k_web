<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Results</title>

    <script type="text/javascript" src="js/chea_and_kea.js"></script>
    <script src="js/exportJson.js"></script>
    <script src="js/jquery-3.0.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.6/Chart.bundle.min.js"></script>
    <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-578e939ffe83e029"></script>

    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="css/main.css">
</head>
<body>

<script>
    var json_file = ${json};
</script>

<div id="page">

    <%@ include file="templates/frame/header.html" %>

    <div id="top_container">

        <div id="download_buttons">
            Download results:
            <br>
            <a id="exportData" onclick="exportJson(this,json_file.type,JSON.stringify(json_file));">
                <button type="button">Download Data as CSV</button>
            </a>
            <br>
        </div>

        <div id=pagetop_spacer></div>

    </div>
    <div class="clear"></div>


    <ul class="tab">
        <li><a id="chart_tab" href="#" class="tablinks active" onclick="opentab(event, 'Chart')">Chart</a></li>
        <li><a id="table_tab" href="#" class="tablinks" onclick="opentab(event, 'Table')">Table</a></li>
    </ul>


    <div id="Chart" class="tabcontent">
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
    
	<div class="clear"></div>
    <%@ include file="templates/frame/footer.html" %>


</div>

</body>
</html>
