#!/bin/bash

cd /pensandotools/pentools/
python3 -m venv .venv
. .venv/bin/activate
pip install -U pip
pip install -r requirements.txt
echo """ """
./pentools --help
./pentools fw dss --host localhost -d 1 -f 1 --tne 1
$SHELL



