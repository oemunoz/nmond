#!/bin/ksh

##################################################
# name: nmond.sh
# purpose: script that will start or stop the nmon daemon.
# oemnunoz@co.ibm.com
# version 0.3
##################################################
NMON_DIR="/administrador/nmon_data"
# Search for the default binary
if [ -x /usr/bin/nmon ];then
		NMON_BIN="/usr/bin/nmon"
else
		echo "I cant find nmon binary"
		exit 0
fi
# Create the directory
if [ ! -d $NMON_DIR ]; then
		mkdir $NMON_DIR
fi

# Init nmon
nmon_start() {
		echo "Starting NMON"
		$NMON_BIN -f -t -m $NMON_DIR
}

nmon_stop() {
		echo "killing nmon"
		PIDS=$(ps -fea | grep -v "grep" | grep 'nmon *-f -t -m' | awk '{ print $2 }')
		for PID in $PIDS; do
				kill $PID
		done
		/usr/bin/gzip $NMON_DIR/*.nmon
}

case "$1" in
start )
		nmon_start                      
		;;
stop )
		nmon_stop                       
		;;
restart )
		nmon_stop
		nmon_start                      
		;;
* )
								echo "Usage: $0 (start | stop | restart )"
								exit 1
esac
