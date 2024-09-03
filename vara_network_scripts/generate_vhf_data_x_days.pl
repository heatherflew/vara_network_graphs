#!/usr/bin/perl

#    generates network graphs for HF stations, to be used with save_vara_log.sh
#    Copyright (C) 2024 Heather Flewelling, AH7RF_at_arrl.net
#    This program is free software: you can redistribute it and/or modify
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.


$days=$ARGV[0]-1;
$htmldir=$ARGV[1];

if ($days<0 || $days > 1000) {
$days=0;
}
$daysinfile=$days+1;
$datestr=`date +%Y%m%d`;
chomp $datestr;
$logdir= "$htmldir/logs/syslog";
$savedir= "$htmldir/logs/";

my @a=(0..$days);
$filestr="";
foreach $dy (@a) {
    chomp $dy;
    $dt=`date --date "now -$dy days" +%Y%m%d`;
chomp $dt;
    print $dt;
    if ( -e "$logdir/syslog_$dt.log") {
	$filestr=$filestr." $logdir/syslog_$dt.log";
    }
}

print $filestr;


# this gets the list of gateways
$com="awk '{print \$4}' $filestr | sort | uniq  | grep \"V-\" | sed 's/V-//'";
@gateways=`$com`;

#Heard consists of Ping, Monitor, and Autotune.

#gets the stations monitored by a gateway,  lists GATEWAY STATION NUM MIN MAX
$mon="grep VARAFM $filestr  | grep Monitor | grep -v '\\[' | awk '{test[\$4\" \"\$7]++;}!(\$4\" \"\$7 in max) {max[\$4\" \"\$7]=\$11}\$11>max[\$4\" \"\$7]{max[\$4\" \"\$7]=\$11}!(\$4\" \"\$7 in min) {min[\$4\" \"\$7]=\$11}\$11<min[\$4\" \"\$7]{min[\$4\" \"\$7]=\$11}END{for (i in test) print i,test[i], min[i], max[i]}' | grep -v signal | sed 's/V-//' | grep -v 'Digi'";

$mon="grep VARAFM $filestr  | grep Monitor | grep -v '\\[' | awk '{if (\$10 == \"S/N:\") test[\$4\" \"\$7]++;}!(\$4\" \"\$7 in max) {max[\$4\" \"\$7]=\$11}\$11>max[\$4\" \"\$7]{max[\$4\" \"\$7]=\$11}!(\$4\" \"\$7 in min) {min[\$4\" \"\$7]=\$11}\$11<min[\$4\" \"\$7]{min[\$4\" \"\$7]=\$11}END{for (i in test) print i,test[i], min[i], max[i]}' | grep -v signal | sed 's/V-//' | grep -v 'Digi'";
$mon="grep VARAFM $filestr  | grep Monitor | grep -v '\\[' | awk '{if (\$10 == \"S/N:\") {test[\$4\" \"\$7]++; if (!(\$4\" \"\$7 in max)) max[\$4\" \"\$7]=\$11; if (\$11>max[\$4\" \"\$7]) max[\$4\" \"\$7]=\$11; if (!(\$4\" \"\$7 in min)) min[\$4\" \"\$7]=\$11; if (\$11<min[\$4\" \"\$7]) min[\$4\" \"\$7]=\$11}}END{for (i in test) print i,test[i], min[i], max[i]}' | grep -v signal | sed 's/V-//' | grep -v 'Digi'";

#Excluding the digipeating thing
#$mon="grep VARAFM $filestr  | grep Monitor | grep -v '\\[' | awk '{test[\$4\" \"\$7]++;}!(\$4\" \"\$7 in max) {max[\$4\" \"\$7]=\$(NF-1)}\$(NF-1)>max[\$4\" \"\$7]{max[\$4\" \"\$7]=\$(NF-1)}!(\$4\" \"\$7 in min) {min[\$4\" \"\$7]=\$(NF-1)}\$(NF-1)<min[\$4\" \"\$7]{min[\$4\" \"\$7]=\$(NF-1)}END{for (i in test) print i,test[i], min[i], max[i]}' | grep -v signal | sed 's/V-//' | grep -v 'Digi'";
print "\n$mon\n";
@monitor=`$mon`;


#gets the stations pinged by a gateway,  lists GATEWAY STATION NUM MIN MAX
$ping="grep VARAFM $filestr  | grep 'Ping received' | grep -v '\\[' |  awk '{test[\$4\" \"\$9]++;}!(\$4\" \"\$9 in max) {max[\$4\" \"\$9]=\$11}\$11>max[\$4\" \"\$9]{max[\$4\" \"\$9]=\$11}!(\$4\" \"\$9 in min) {min[\$4\" \"\$9]=\$11}\$11<min[\$4\" \"\$9]{min[\$4\" \"\$9]=\$11}END{for (i in test) print i, test[i], min[i], max[i]}'  | grep -v signal | sed 's/V-//' | grep -v 'Digi'";
@ping=`$ping\n`;
print "\n$ping\n";


#gets the stations autotuned by a gateway,  lists GATEWAY STATION NUM MIN MAX
$auto="grep VARAFM $filestr  | grep 'Sending Autotune Response' | grep -v '\\[' | awk '{test[\$4\" \"\$10]++;}!(\$4\" \"\$10 in max) {max[\$4\" \"\$10]=\$13}\$13>max[\$4\" \"\$10]{max[\$4\" \"\$10]=\$13}!(\$4\" \"\$10 in min) {min[\$4\" \"\$10]=\$13}\$13<min[\$4\" \"\$10]{min[\$4\" \"\$10]=\$13}END{for (i in test) print i, test[i], min[i], max[i]}' | grep -v signal | sed 's/V-//' | grep -v 'Digi'";
print "\n$auto\n";
@auto=`$auto`;

# this gets the list of heard stations
$com="grep VARAFM $filestr  | grep Monitor | grep -v '\\[' | awk '{print \$4, \$7}'  | sort | uniq | grep -v signal | sed 's/V-//' | grep -v 'Digi'";
print "\n$com\n";
@heard=`$com`;

### This isn't working right, I need to make a list of callsigns that are heard or connected?



# this gets the list of connected stations
#gets the stations connected (for winlink) by a gateway,  lists GATEWAY STATION NUM MIN MAX
$com="grep VARAFM $filestr  | grep ' S/N:' | awk '{print \$4, \$5, \$7}' | sort | uniq | sed 's\/VARAFM\\\[\/\/' | sed 's/\\\]//'" ;
$com="grep VARAFM $filestr | grep -v Monitor | grep ' S/N:' | grep ' connected' | grep -v ' via ' | awk '{test[\$4\" \"\$6]++;}!(\$4\" \"\$6 in max) {max[\$4\" \"\$6]=\$9}\$9>max[\$4\" \"\$6]{max[\$4\" \"\$6]=\$9}!(\$4\" \"\$6 in min) {min[\$4\" \"\$6]=\$9}\$9<min[\$4\" \"\$6]{min[\$4\" \"\$6]=\$9}END{for (i in test) print i,test[i], min[i], max[i]}' | sort | uniq | sed 's/VARAFM\\\[//' | sed 's/\\\]//' | sed 's/V-//' | grep -v 'Digi' | grep -v 'Ping' | grep -v 'Autotune' | grep -v 'Sending' ";


print $com;
@connected=`$com`;


## Now, what I think I want to do is make a list of of GATEWAY STATION for each of:

## Stations heard (this is just what's in Monitor)

## Stations connected (Ping / Autotune / Connected) - confusingly Connected is there twice.


foreach $gw (@gateways) {
    print "$gw";
}

print "heard\n";
foreach $hrd (@heard) {
    print "$hrd";
}

print "ping\n";
foreach $hrd (@ping) {
    print "$hrd";
}
print "monitor\n";
foreach $hrd (@monitor) {
    print "$hrd";
}
print "auto\n";
foreach $hrd (@auto) {
    print "$hrd";
}

print "connected\n";
foreach $con (@connected) {
    print "$con";
}


print "\n";

if ($#gateways >= 0 ) {
    if ($#ping || $#auto || $#monitor >= 0 ) {
	my %hrd_ids;
	my %hrd_ping;
	my %hrd_auto;
	my %hrd_monitor;
	#create nodes_heard
	$filename=$savedir."/".$datestr."_".$daysinfile."_vhf_heard.js";
	print "$filename\n";
	open(FH, '>', $filename) or die $!;
	print FH "function htmlTitle(html) {
  const container = document.createElement(\"div\");
  container.innerHTML = html;
  return container;
}
\n";
	print FH "var nodes_heard = [\n";
	$id=1;
	foreach $gw (@gateways) {
	    chomp $gw;
	    print FH "{ id: $id, label: \"$gw\", group: 1 },\n";
	    $hrd_id{$gw}=$id;
	    $id++;
	}
	#do this blog for each of @monitor, @ping, and @auto tune:
	foreach $hrd (@monitor) {
	    chomp $hrd;
	    @hrdrows=split /\s+/,$hrd;
	    if (!exists ($hrd_monitor{$hrdrows[0]." ".$hrdrows[1]})) {
		$hrd_monitor{$hrdrows[0]." ".$hrdrows[1]}=$hrd;
	    }
	    if (!exists ($hrd_id{$hrdrows[1]})) {
		print FH"{ id: $id, label: \"$hrdrows[1]\", group: 2 },\n";
		$hrd_id{$hrdrows[1]}=$id;
		$id++;
	    }
	}
	foreach $hrd (@ping) {
	    chomp $hrd;
	    @hrdrows=split /\s+/,$hrd;
	    if (!exists ($hrd_ping{$hrdrows[0]." ".$hrdrows[1]})) {
		$hrd_ping{$hrdrows[0]." ".$hrdrows[1]}=$hrd;
	    }
	    if (!exists ($hrd_id{$hrdrows[1]})) {
		print FH"{ id: $id, label: \"$hrdrows[1]\", group: 2 },\n";
		$hrd_id{$hrdrows[1]}=$id;
		$id++;
	    }
	}
	foreach $hrd (@auto) {
	    chomp $hrd;
	    @hrdrows=split /\s+/,$hrd;
	    if (!exists ($hrd_auto{$hrdrows[0]." ".$hrdrows[1]})) {
		$hrd_auto{$hrdrows[0]." ".$hrdrows[1]}=$hrd;
	    }
	    if (!exists ($hrd_id{$hrdrows[1]})) {
		print FH"{ id: $id, label: \"$hrdrows[1]\", group: 2 },\n";
		$hrd_id{$hrdrows[1]}=$id;
		$id++;
	    }
	}
	print FH "];\n";
	#create edges_heard
	print FH "var edges_heard = [\n";
	# this isn't quite right and needs to be reworked...
	foreach $hrd (@heard) {
	    chomp $hrd;
	    @hrdrows=split /\s+/,$hrd;
	    if (exists($hrd_id{$hrdrows[0]}) && exists($hrd_id{$hrdrows[1]})) {
#		print FH "{ from: $hrd_id{$hrdrows[0]}, to: $hrd_id{$hrdrows[1]} },\n";
		$hrdstuff="";
		
		if (exists($hrd_ping{$hrdrows[0]." ".$hrdrows[1]})) {
		    @pingstuff=split /\s+/,$hrd_ping{$hrdrows[0]." ".$hrdrows[1]};
		    $hrdstuff.="<p>Ping Report<br>Min S/N: $pingstuff[3] dB,  Max S/N: $pingstuff[4] dB<br>Number of Pings: $pingstuff[2] <br> ";
		}
		if (exists($hrd_auto{$hrdrows[0]." ".$hrdrows[1]})) {
		    @autostuff=split /\s+/,$hrd_auto{$hrdrows[0]." ".$hrdrows[1]};
		    $hrdstuff.="<p>Autotune Report (best)<br>Min S/N: $autostuff[3] dB,  Max S/N: $autostuff[4] dB<br>Number of  Autotunes: $autostuff[2] <br>";
		}
		if (exists($hrd_monitor{$hrdrows[0]." ".$hrdrows[1]})) {
		    @monitorstuff=split /\s+/,$hrd_monitor{$hrdrows[0]." ".$hrdrows[1]};
		    $hrdstuff.="<p>Monitor Report<br>Min S/N: $monitorstuff[3] dB, Max S/N: $monitorstuff[4] dB<br>Number Heard: $monitorstuff[2] <br>";

		}
		print FH "{ from: $hrd_id{$hrdrows[0]}, to: $hrd_id{$hrdrows[1]}, font: {multi: 'html'}, title: htmlTitle(\"<b>$hrdrows[1] heard by gateway $hrdrows[0]</b><br>Signal report from gateway $hrdrows[0]   $hrdstuff\")  },\n";

	    } 
		
	}
	print FH "];\n";
	close(FH);

    } else {
    # figure out what to do if nothing heard
	$filename=$savedir."/".$datestr."_".$daysinfile."_vhf_heard.js";
	print "$filename\n";
	open(FH, '>', $filename) or die $!;
	print FH "function htmlTitle(html) {
  const container = document.createElement(\"div\");
  container.innerHTML = html;
  return container;
}
\n";

	print FH "var nodes_heard = [{ id: 1, label: \"no data\", group: 1 }]\n";
	print FH "var edges_heard = []\n";
	close(FH);
    }
    
    if ($#connected >= 0) {

	my %con_ids;
	#create nodes_heard
	$filename=$savedir."/".$datestr."_".$daysinfile."_vhf_connect.js";
	print "$filename\n";
	open(FH, '>', $filename) or die $!;
	print FH "function htmlTitle(html) {
  const container = document.createElement(\"div\");
  container.innerHTML = html;
  return container;
}
\n";
	print FH "var nodes_connected = [\n";
	$id=1;
	foreach $gw (@gateways) {
	    chomp $gw;
	    print FH "{ id: $id, label: \"$gw\", group: 1 },\n";
	    $con_id{$gw}=$id;
	    $id++;
	}
	foreach $con (@connected) {
	    chomp $con;
	    @conrows=split /\s+/,$con;
	    if (!exists ($con_id{$conrows[1]})) {
		print FH"{ id: $id, label: \"$conrows[1]\", group: 2 },\n";
		$con_id{$conrows[1]}=$id;
		$id++;
	    }
	}
	print FH "];\n";
	#create edges_connected
	print FH "var edges_connected = [\n";
	foreach $con (@connected) {
	    chomp $con;
	    print $con;
	    @conrows=split /\s+/,$con;
	    if (exists($con_id{$conrows[0]}) && exists($con_id{$conrows[1]})) {
		print FH "{ from: $con_id{$conrows[0]}, to: $con_id{$conrows[1]}, font: {multi: 'html'}, title: htmlTitle(\"<b>$conrows[1] connected to gateway $conrows[0]</b><br>Signal report from gateway $conrows[0]        <p><br>Min S/N: $conrows[3] dB, Max S/N: $conrows[4] dB<br>Number of Connections: $conrows[2]\")  },\n";
	    } 
		
	}
	print FH "];\n";
	close(FH);

    } else {
	$filename=$savedir."/".$datestr."_".$daysinfile."_vhf_connect.js";
	print "$filename\n";
	open(FH, '>', $filename) or die $!;
	print FH "var nodes_connected = [{ id: 1, label: \"no data\", group: 1 },]\n";
	print FH "var edges_connected = []\n";
	close(FH);

	#figure out what to do if nothing connected
}

} else {

# do stuff if no reporting gateways



}



