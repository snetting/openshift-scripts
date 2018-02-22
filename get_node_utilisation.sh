#/bin/bash

printf "%-12s      %-25s  %-4s  %-15s %-20s %-18s %-8s \n" "NODE" "STATE" "PODS" "CPU Req" "CPU Lim" "Memory Req" "Memory Lim"
oc get nodes --show-labels | grep user  | while read NODE STAT crap

do
  printf "%-12s   %-25s  %-5s "  $(echo $NODE | cut -f1 -d. ) $STAT $(oadm manage-node --list-pods $NODE 2> /dev/null | sed '/^NAME.*/d' | wc -l)
  printf "%-7s %-7s %-7s %-12s %-12s %-5s %-12s %-5s\n" $(oc describe node $NODE | grep -a2 "CPU Requests" | tail -1)
done
