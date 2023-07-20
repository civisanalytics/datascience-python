#!/bin/bash
pip install -r requirements-core.txt
pip install piptools
pip-compile --output-file=requirements-full.txt --pip-args='--prefer-binary' requirements-core.txt
