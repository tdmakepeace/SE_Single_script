#!/bin/bash


cd /pensandotools/bob/
python3 -m venv .venv
. .venv/bin/activate
pip install -U pip
pip install -r requirements.txt
cd /pensandotools/bob/
echo "tool running cntl-C to cancel"
./bob brb --listen 9995 --config .penrc
$SHELL
