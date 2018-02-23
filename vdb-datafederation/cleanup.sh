#!/usr/bin/sh

oc delete deploymentconfigs vdb-service
oc delete buildconfig vdb-service-s2i
oc delete route vdb-service-odata
oc delete service vdb-service-odata
oc delete service vdb-service-jdbc
oc delete is vdb-service

