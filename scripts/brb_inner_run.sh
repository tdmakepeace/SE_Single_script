#!/bin/bash

cd /pensandotools/Bigredbutton/
python3 -m venv .venv
. .venv/bin/activate
pip install -U pip
pip install -r requirements.txt
python3 bigredrest.py
