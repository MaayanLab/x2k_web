<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Results</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <link rel="shortcut icon" href="static/favicon.ico" type="image/x-icon">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">

    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.0.9/js/all.js" integrity="sha384-8iPTk2s/jMVj81dnzb/iFR2sdA7u06vHJyyLlAd4snFpCl/SnyUjRrbdJsw1pGIl" crossorigin="anonymous"></script>
    <script src="https://d3js.org/d3.v4.min.js"></script>

    <!--Datatables-->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap4.css"/>
    <link rel="stylesheet" type="text/css"
          href="https://cdn.datatables.net/responsive/2.2.0/css/responsive.bootstrap4.css"/>


    <script type="text/javascript" src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.16/js/dataTables.bootstrap4.js"></script>
    <script type="text/javascript"
            src="https://cdn.datatables.net/responsive/2.2.0/js/dataTables.responsive.js"></script>

    <!--Datatables buttons-->
    <link rel="stylesheet" type="text/css"
          href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.min.css"/>
    <link rel="stylesheet" type="text/css"
          href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.bootstrap4.min.css"/>

    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.1/js/buttons.bootstrap4.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js"></script>

    <!--Own-->
    <link rel="stylesheet" href="dist/css/bargraph.css">
    <link rel="stylesheet" href="dist/css/network.css">
    <link rel="stylesheet" href="dist/css/atooltip.css">
    <link rel="stylesheet" href="dist/css/results.css">


    <script src="dist/js/bargraph.js"></script>
    <script src="dist/js/results.js"></script>
    <script src="dist/js/network.js"></script>
    <script src="dist/js/jquery.atooltip.pack.js"></script>
    <script> var json_file = ${json}; </script>

    <script>
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r;
            i[r] = i[r] || function () {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date();
            a = s.createElement(o), m = s.getElementsByTagName(o)[0];
            a.async = 1;
            a.src = g;
            m.parentNode.insertBefore(a, m)
        })(window, document, 'script',
            'https://www.google-analytics.com/analytics.js', 'ga');
        ga('create', 'UA-6277639-28', 'auto');
        ga('send', 'pageview');
    </script>

</head>
<body>
<!--Header-->
<nav class="navbar navbar-light bg-light justify-content-center navbar-expand-sm" id="x2k-navbar">
    <a class="navbar-brand" href="/X2K">
        <img id="logo" src="static/logo.png" height="50px" class="d-inline-block full-logo">
    </a>
    <!-- <button class="btn btn-primary lead">View Input Genes</button> -->
</nav>

<!--Body-->
<%@ include file="/templates/dashboard.jsp" %>

<!--Footer-->
<footer class="container-fluid" id="footer">
    <div class="row justify-content-center mt-2">
        <div class="col-sm-7" id="citations">
            <!--             <p>Please cite this paper if you are using X2K for your publication:
                            <a href="http://www.ncbi.nlm.nih.gov/pubmed/22080467"> Chen EY, Xu
                                H, Gordonov S, Lim MP, Perkins MH, Ma'ayan A. Expression2Kinases:
                                mRNA Profiling Linked to Multiple Upstream Regulatory Layers.
                                Bioinformatics. (2012) 28 (1): 105-111</a></p> -->
        </div>
    </div>
</footer>
</body>
</html>