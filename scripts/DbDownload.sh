#!/bin/bash

ora="date +%Y-%m-%d-%H:%M:%S"
echo `${ora}` "Inizio processo di DbDownload.sh"
HOME_DIR=.
# DP_DIR=/export/indice/dp
# EXPORT_DIR=$DP_DIR/export

BIN_DIR=./bin



# Elapsed time.  Usage:
#
#   t=$(timer)
#   ... # do something
#   printf 'Elapsed time: %s\n' $(timer $t)
#      ===> Elapsed time: 0:01:12
#
#
#####################################################################
# If called with no arguments a new timer is returned.
# If called with arguments the first is used as a timer
# value and the elapsed time is returned in the form HH:MM:SS.
#
function timer()
{
    if [[ $# -eq 0 ]]; then
        echo $(date '+%s')
    else
        local  stime=$1
        etime=$(date '+%s')
        if [[ -z "$stime" ]]; then stime=$etime; fi

        dt=$((etime - stime))
        ds=$((dt % 60))
        dm=$(((dt / 60) % 60))
        dh=$((dt / 3600))
        printf '%d:%02d:%02d' $dh $dm $ds
    fi
}
     

tmr=$(timer)

#java -Xmx256m -classpath ../:classes12.jar it.finsiel.offlineExport.DbDownload downloadIND.prova.txt
# /opt/java/jdk1.6.0_31/bin/java -Xmx256m -classpath $BIN_DIR:$BIN_DIR/ojdbc6.jar it.finsiel.offlineExport.DbDownload downloadIND.prova.txt
# java -classpath $BIN_DIR:$BIN_DIR/jdbcDrivers/mysql-connector-java-8.0.13.jar DbDownload scripts/DbDownload.con

java -classpath $BIN_DIR:$BIN_DIR/jdbcDrivers/mysql-connector-java-8.0.13.jar DbDownload scripts/DbDownload_env.con

echo `${ora}` "Fine processo di DbDownload.sh" 
 
echo
echo Elapsed time $(timer $tmr)
