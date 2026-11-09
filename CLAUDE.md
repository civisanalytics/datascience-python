# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A Docker image (`civisanalytics/datascience-python`) that provides the standard Python execution environment for Civis Platform jobs. The image bundles a curated set of data science packages alongside the Civis Python API client.

**Adding new packages is intentionally discouraged.** The package set is minimal by design to avoid dependency conflicts.

## Build and test

```bash
# Build the production image
docker build -t datascience-python .

# Build and run tests (as CircleCI does)
docker build --target test -t datascience-python:test .
docker run datascience-python:test /test_image.py -vv
```

Tests live in `.circleci/test_image.py` and use stdlib `unittest`. They validate that version env vars match `CHANGELOG.md`, that key packages import correctly, and that required shell commands are available.

## Updating dependencies

1. Edit `requirements-core.txt` with new package versions
2. Regenerate the lock file:
   ```bash
   ./generate-requirements-full.sh
   ```
   This runs `uv pip compile` inside Docker (via `docker-compose.yml`) to ensure the compiled deps match the actual build environment.
3. `requirements-full.txt` is auto-generated — never edit it by hand.

The Python version (`BASE_IMAGE`) and the uv version (installer URL) are set in the `Dockerfile`, not in the requirements files. pip comes from the base image.

## Multi-stage Dockerfile

| Stage | Purpose |
|---|---|
| `uv-installed` | Base: system deps + uv package manager |
| `production` | Published image: installs from `requirements-full.txt` |
| `test` | Copies in test suite; used by CI |
| `update-deps` | Used by `generate-requirements-full.sh` to compile deps |

## Versioning and releases

Versions follow `MAJOR.MINOR.MICRO` set in the `ENV VERSION=...` lines of the Dockerfile. The top of `CHANGELOG.md` defines which bump a change needs; notably, a major-version bump of any core package requires a major image release. The test suite asserts this matches the latest entry in `CHANGELOG.md`, and `.github/workflows/release.yaml` additionally asserts it matches the release tag.

To release: bump the `ENV VERSION=...` lines and promote `CHANGELOG.md`'s `Unreleased` section, then create a GitHub release with a tag like `v8.5.0`. `.github/workflows/release.yaml` pushes `major`, `major.minor`, and `major.minor.micro` tags to DockerHub; `.github/workflows/latest.yaml` pushes `latest` on every merge to `master`.

## Other pipelines

Two CI systems run alongside the GitHub Actions workflows above, and neither publishes to DockerHub:

- `.circleci/config.yml` builds the `test` target and runs the test suite. It never pushes.
- `buildspec/*.yaml` are AWS CodeBuild specs that push to Civis's internal ECR FIPS registry.
