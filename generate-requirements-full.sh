#!/bin/bash
# Run this script to update requirements-core.txt.
# It uses Docker to ensure that the environment matches what will be used in the production image.
set -e
docker compose run --rm pip-tools /bin/sh -c "apt-get update -y && apt-get install -y git && pip install --upgrade pip-tools && pip-compile --output-file=requirements-full.txt --pip-args='--prefer-binary' --strip-extras --upgrade requirements-core.txt"
