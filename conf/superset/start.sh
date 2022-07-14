#!/bin/bash
echo "create-admin:"
superset fab create-admin --username admin --firstname Superset --lastname Admin --email admin@superset.com --password admin
echo "db upgrade:"
superset db upgrade
echo "init:"
superset init
echo "start:"
/usr/bin/run-server.sh