<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Hawaii Vara HF Winlink Gateway Network Graph - connected stations</title>

    <script
      type="text/javascript"
      src="vis-network.min.js"
    ></script>

    <style type="text/css">
      body {
	  background: white;
	  color: black;
	  font-family: Arial, sans-serif;
      }
      
      a {
	font-weight: bold;
	color:black;
      }

table { class="buttontable";
}
.buttontable {
  width: 80%;
}


      #mynetwork {
        width: 800px;
        height: 500px;
        border: 1px solid lightgray;
      }
    </style>
  </head>
  <body>
<center>
<table>
<tr><td colspan="3" bgcolor="lightblue" width="100%">
<h1><center>Hawaii Winlink VARA Network Graphs</center><h1>
<p>
<h2><center>Remote montoring of Hawaii Winlink VARA stations</center></h2>

<center>
<table width="800px">
<tr>
<td></td>
<td><button onclick="document.location='index.php'" style="width:100%">About</button></td>
<td><button onclick="document.location='varasyslog.php'"  style="width:100%" >VARA syslog  (today)</button></td>
<td><button onclick="document.location='varafmheard.php'" style="width:100%">VARA FM heard  (today)</button></td>
<td><button onclick="document.location='varafmconnected.php'" style="width:100%">VARA FM connected  (today)</button></td>
<td><button onclick="document.location='varahfconnected.php'" style="width:100%">VARA HF connected  (today)</button></td>
<td></td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td><button onclick="document.location='varafmheard5.php'" style="width:100%">VARA FM heard (5 days)</button></td>
<td><button onclick="document.location='varafmconnected5.php'" style="width:100%">VARA FM connected (5 days)</button></td>
<td><button onclick="document.location='varahfconnected5.php'" style="width:100%">VARA HF connected (5 days)</button></td>
<td></td>
</tr>
</table>

</center>

</td>
</tr>
<tr><td width="10%px"></td><td width="80%px"></td><td width="10%px"></td>
</tr><tr><td></td><td>





