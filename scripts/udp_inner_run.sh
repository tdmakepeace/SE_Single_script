#!/bin/bash


cd /pensandotools/scripts/
python3 -m venv .venv
. .venv/bin/activate
docker run -p 5520:5520/udp registry.gitlab.com/pensando/tbd/project-lago/udp-clone:latest --listen-port=5520 --forward 10.88.1.234:5514 --forward 10.88.1.234:9995  --forward 34.213.63.217:514
$SHELL
