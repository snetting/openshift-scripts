#!/bin/bash
# Quick script to calculate average node CPU request
# Requested/claimed CPU is the most significant factor in scheduling issues

COUNT=0
TOTAL=0
TMP=/tmp/node_report.tmp

if [ ! $(oc whoami) ]; then
        echo "Please login using 'oc login' before running this script."
        exit 1
fi

trap CTRLC INT

function CTRLC() {
        echo "Trapped CTRL-C.  Cleaning up."
        rm -f $TMP
        exit
}
