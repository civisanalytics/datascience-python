#!/bin/bash
python --version
pip install --upgrade pip-tools
pip-compile --output-file=requirements-full.txt --pip-args='--prefer-binary' --strip-extras --upgrade requirements-core.txt
