#!/usr/bin/bash

#    grabs a copy of today's syslog, and runs scripts to parse into network graphs
#    Copyright (C) 2024 Heather Flewelling, AH7RF_at_arrl.net
#    This program is free software: you can redistribute it and/or modify
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

### You will have to edit these parameters ###
syslog=/var/log/syslog
varanetworkscriptsdir=/home/heather/varanetworkscripts
varanetworkhtmldir=/var/www/html/hawaiiares_page/heather/vara
###




echo "running cron job"
date 

logdir=$varanetworkhtmldir/logs/syslog


datestr=$(date +"%Y%m%d")


grep VARA $syslog > $logdir/syslog_$datestr.log

perl $varanetworkscriptsdir/generate_vhf_data_x_days.pl 1 $varanetworkhtmldir
perl $varanetworkscriptsdir/generate_hf_data_x_days.pl 1 $varanetworkhtmldir
perl $varanetworkscriptsdir/generate_vhf_data_x_days.pl 5 $varanetworkhtmldir
perl $varanetworkscriptsdir/generate_hf_data_x_days.pl 5 $varanetworkhtmldir

