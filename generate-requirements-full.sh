#!/bin/bash
# Run this script to update requirements-core.txt.
# It uses Docker to ensure that the environment matches what will be used in the production image.
set -e
docker compose run --rm update-deps /bin/sh -c "uv pip compile --output-file=requirements-full.txt --upgrade requirements-core.txt"
