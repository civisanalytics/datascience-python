#!/bin/bash
pip install pip-tools
pip-compile --output-file=requirements-full.txt --pip-args='--prefer-binary' requirements-core.txt
