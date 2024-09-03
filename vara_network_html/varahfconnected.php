<?php
include("header.php");
?>

    <script
      type="text/javascript"
      src="vis-network.min.js"
    ></script>

<center>
    <h2>Winlink Network Graph for VARA HF gatways + stations connected</h2>


<iframe src="varahfconnected_simple.php" style="border:none;" width=640px height=460px></iframe>



<p>This page is updated every 10 minutes, and displays information about gateway traffic since midnight. In this graph, blue represents gateways, and yellow represents stations. Lines connect when a gateway hears a station. This is an interactive graph!</p>





<?php
include("footer.php");
?>
