<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Vara FM Connected (5 day) - connected stations</title>

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

      #mynetwork {
        width: 600px;
        height: 400px;

      #mynetworkinfo {
        width: 600px;
        height: 420px;
        border: 1px solid lightgray;

      }
    </style>
  </head>
  <body>
<center>




</p>
<div id="mynetworkinfo"><div id="mynetwork"></div>
<table border=0; width=100%; style="color:darkgray; font-size:80%">
<tr><td align="left">Last updated: 
<?php
$datestr=shell_exec("date +%Y%m%d");
$datestr = str_replace("\n", "", $datestr);
$logdir="logs/syslog/";
echo shell_exec("ls -l $logdir/syslog_$datestr".".log --time-style='+%Y-%m-%d %H:%M:%S HST' | awk '{print $6, $7, $8}'");
?></td><td align="right">
GPL3.0 / <a href="https://github.com/heatherflew/vara_network_graphs" style="color:darkgray;" target="_blank">github</a>
</td></tr></table>
<script src="logs/<?php echo $datestr; ?>_5_vhf_connect.js"> </script> 


    <script type="text/javascript">
      // create an array with nodes
      var nodes = new vis.DataSet(nodes_connected);


      // create an array with edges
      var edges = new vis.DataSet(edges_connected);

      // create a network
      var container = document.getElementById("mynetwork");
      var data = {
        nodes: nodes,
        edges: edges,
      };
      var options = {};
      var network = new vis.Network(container, data, options);
    </script>
</body>
</html>
<!---
#    html that displays generated network graphs 
#    Copyright (C) 2024 Heather Flewelling, AH7RF_at_arrl.net
#    This program is free software: you can redistribute it and/or modify
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.
--->
