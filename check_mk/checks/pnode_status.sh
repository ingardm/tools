#!/usr/local/bin/bash
# Percona node status script
# To be used with nagios/check_mk to determine
# the node health of a Percona XtraDB Cluster node
# Originally written by Scott Larson of Wiredrive
# Modified by Kyle Gato <kyle.gato@gmail.com>

MYSQL=/usr/bin/mysql
USER="MYSQL_USER"
PASS="MYSQL_PASSWORD"

GREP="/bin/grep"
STATUS="ON"

# You may want to adjust the param below, replacing `hostname -i` with localhost
SERVER=`hostname -i`

if [[ -n "$SERVER" ]]; then

RESULTS=`$MYSQL --user=$USER --password=$PASS --host=$SERVER -e 'SHOW STATUS LIKE "wsrep_ready"'|$GREP $STATUS`
  if [[ -n "$RESULTS" ]]; then
        echo "0 Percona_Node_Status - OK - Node Synced"
  else
    	echo "2 Percona_Node_Status - CRITICAL - Node out of Sync"
  fi

else
  echo "You must supply a server name for the check."
  
fi
