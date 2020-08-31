#!/bin/sh

kubectl apply -f target/classes/META-INF/jkube/kubernetes.yml && kubectl patch deployment -n event attendance-assembly -p "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"date\":\"`date +'%s'`\"}}}}}"
