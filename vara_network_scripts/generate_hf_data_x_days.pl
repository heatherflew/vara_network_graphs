#!/usr/bin/perl

#    generates network graphs for HF stations, to be used with save_vara_log.sh
#    Copyright (C) 2024 Heather Flewelling, AH7RF_at_arrl.net

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.



$htmldir=$ARGV[1];
$days=$ARGV[0]-1;


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
$com="awk '{print \$4}' $filestr | sort | uniq  | grep \"H-\" | sed 's/H\-//'";
print "$com\n";

@gateways=`$com`;
# this gets the list of heard stations
$com="grep VARAHF $filestr  | grep Monitor | awk '{print \$4, \$7}'  | sort | uniq | grep -v signal";
@heard=`$com`;

# this gets the list of connected stations
#$com="grep VARAHF $logdir/syslog_$datestr.log  | grep 'VARA HF' | awk '{print \$4, \$5 }' | sort | uniq | sed 's\/VARAHF\\\[\/\/' | sed 's/\\\]//'" ;
$com="grep VARAHF $filestr  | grep ' S/N: ' | awk '{print \$4, \$5, \$7 }' | sort | uniq | sed 's\/VARAHF\\\[\/\/' | sed 's/\\\]//'" ;

#$com="grep VARAHF $filestr  | grep -v Monitor | grep ' S/N:' | awk '{test[\$4\" \"\$5]++;}!(\$4\" \"\$5 in max) {max[\$4\" \"\$5]=\$7}\$7>max[\$4\" \"\$5]{max[\$4\" \"\$5]=\$7}!(\$4\" \"\$5 in min) {min[\$4\" \"\$5]=\$7}\$7<min[\$4\" \"\$5]{min[\$4\" \"\$5]=\$7}END{for (i in test) print i,test[i], min[i], max[i]}' | sort | uniq | sed 's/VARAHF\\\[//' | sed 's/\\\]//'| sed 's/H\-//'";

# this gets the list of connected stations
#gets the stations connected (for winlink) by a gateway,  lists GATEWAY STATION NUM MIN MAX

$com="grep VARAHF $filestr | grep -v Monitor | grep ' S/N:' | grep ' Average' | grep -v ' via ' | awk '{test[\$4\" \"\$6]++;}!(\$4\" \"\$6 in max) {max[\$4\" \"\$6]=\$9}\$9>max[\$4\" \"\$6]{max[\$4\" \"\$6]=\$9}!(\$4\" \"\$6 in min) {min[\$4\" \"\$6]=\$9}\$9<min[\$4\" \"\$6]{min[\$4\" \"\$6]=\$9}END{for (i in test) print i,test[i], min[i], max[i]}' | sort | uniq | sed 's/VARAHF\\\[//' | sed 's/\\\]//' | sed 's/H-//' | grep -v 'Digi' | grep -v 'Ping' | grep -v 'Autotune' | grep -v 'Sending' ";
print "$com\n";




print $com;
@connected=`$com`;



foreach $gw (@gateways) {
    print "$gw";
}

print "heard\n";
foreach $hrd (@heard) {
    print "$hrd";
    
}

print "connected\n";
foreach $con (@connected) {
    print "$con";
}


print "\n";

if ($#gateways >= 0 ) {
    if ($#heard >= 0 ) {
	my %hrd_ids;
	#create nodes_heard
	$filename=$savedir."/".$datestr."_".$daysinfile."_hf_heard.js";
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
	foreach $hrd (@heard) {
	    chomp $hrd;
	    @hrdrows=split /\s+/,$hrd;
	    if (!exists ($hrd_id{$hrdrows[1]})) {
		print FH"{ id: $id, label: \"$hrdrows[1]\", group: 2 },\n";
		$hrd_id{$hrdrows[1]}=$id;
		$id++;
	    }
	}
	print FH "];\n";
	#create edges_heard
	print FH "var edges_heard = [\n";
	foreach $hrd (@heard) {
	    chomp $hrd;
	    @hrdrows=split /\s+/,$hrd;
	    if (exists($hrd_id{$hrdrows[0]}) && exists($hrd_id{$hrdrows[1]})) {
		print FH "{ from: $hrd_id{$hrdrows[0]}, to: $hrd_id{$hrdrows[1]} },\n";
	    } 
		
	}
	print FH "];\n";
	close(FH);

    } else {
    # figure out what to do if nothing heard
	
    }
    
    if ($#connected >= 0) {

	my %con_ids;
	#create nodes_heard
	$filename=$savedir."/".$datestr."_".$daysinfile."_hf_connect.js";
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
	    @conrows=split /\s+/,$con;
	    if (exists($con_id{$conrows[0]}) && exists($con_id{$conrows[1]})) {
#		print FH "{ from: $con_id{$conrows[0]}, to: $con_id{$conrows[1]} },\n";
#                print FH "{ from: $con_id{$conrows[0]}, to: $con_id{$conrows[1]}, title: 'Min S/N: $conrows[3] Max S/N: $conrows[4] Num Connections: $conrows[2]'  },\n";
                print FH "{ from: $con_id{$conrows[0]}, to: $con_id{$conrows[1]}, font: {multi: 'html'}, title: htmlTitle(\"<b>$conrows[1] connected to gateway $conrows[0]</b><br>Signal report from gateway $conrows[0]<p><br>Min S/N: $conrows[3] dB, Max S/N: $conrows[4] dB<br>Number of Connections: $conrows[2]\")  },\n";

	    } 
		
	}
	print FH "];\n";
	close(FH);

    } else {
	#figure out what to do if nothing connected
}

} else {

# do stuff if no reporting gateways



}



