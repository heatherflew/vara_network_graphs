<?php
include("header.php");
?>

<?php

$datestr=shell_exec("date +'%A, %B %d, %Y (HST)'");
$datestr = str_replace("\n", "", $datestr);

?>


<h2>Recent VARA log entries for <?php echo $datestr; ?></h2>

<p>
Note: syslog entries are in UTC time, but the log displayed here spans from midnight to midnight (HST).
<p>

<?php
$datestr=shell_exec("date +%Y%m%d");
$datestr = str_replace("\n", "", $datestr);



$logdir="logs/syslog";

$output=null;
$retval=null;

if (!file_exists($logdir."syslog_".$datestr.".log")) {
   shell_exec ("touch $logdir/syslog_$datestr".".log");
   #gross hack but I want a file to make it look like things are working
}

echo "This page is automatically regenerated every 10 minutes - it was last updated at ";
echo shell_exec("ls -l $logdir/syslog_$datestr".".log --time-style='+%Y-%m-%d %H:%M:%S HST' | awk '{print $6, $7, $8}'");
echo "<br><p>";
exec("tac $logdir/syslog_$datestr".".log", $output, $retval);

#echo shell_exec("tac $logdir/syslog_$datestr.log");
$count= count($output);
#echo $retval;
#echo $count;
for ($i=0; $i < $count; $i++) {
    echo $output[$i]."<br>";
}
#var_dump($output);
#print($output);

?>




<?php
include("footer.php");
?>
