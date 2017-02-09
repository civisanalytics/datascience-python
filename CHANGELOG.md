# Change Log

All changes to this project will be documented in this file.

Version number changes (major.minor.micro) in this package denote the following:
- A micro version will increase if the only change in a release is incrementing micro versions (bugfix-only releases) on the packages contained in this image.
- A minor version will increase if one or more packages contained in the Docker image add new, backwards-compatible features, or if a new package is added to the Docker image.
- A major version will increase if there are any backwards-incompatible changes in any of the packages contained in this Docker image, or any other backwards-incompabile changes in the execution environment.

## [1.1.1] - 2017-02-09
### Fixed
- Add `source activate datascience` to `etc/profile` to ensure bash enjoys the datascience environment (#4)

## [1.1.0] - 2017-02-10
### Changed
- Add environment variables which record the image version number (#1)
- Upgraded civis library from v1.1.0 to v1.2.0

### Fixed
- Add `matplotlibrc` file which changes the backend default to "Agg" (#3)

## [1.0.0] - 2017-01-17

* Initial Release

