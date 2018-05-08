<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Results</title>
    <%@ include file="/templates/head.jsp" %>

    <link rel="stylesheet" href="dist/css/results.css">

    <script src="dist/js/bargraph.js"></script>
    <script src="dist/js/network.js"></script>
    <script src="dist/js/results.js"></script>

    <script> var json_file = ${json}; </script>
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
<div class="px-5 bg-light">
    <%@ include file="/templates/dashboard.jsp" %>
</div>