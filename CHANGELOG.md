# Change Log

All changes to this project will be documented in this file.

Version number changes (major.minor.micro) in this package denote the following:
- A micro version will increase if the only change in a release is incrementing micro versions (bugfix-only releases) on the packages contained in this image.
- A minor version will increase if one or more packages contained in the Docker image add new, backwards-compatible features, or if a new package is added to the Docker image.
- A major version will increase if there are any backwards-incompatible changes in any of the packages contained in this Docker image, or any other backwards-incompabile changes in the execution environment.

## [2.0.0]
### Changed
- Moved conda to version 4.3.11 (#11)
- Moved python to version 3.6.0 (#11)
- Moved conda to version 4.2.12 (#8)
- Moved package install from the `datascience` environment to `root` (#8)

## [1.1.0] - 2017-02-13
### Changed
- Add environment variables which record the image version number (#1)
- Upgraded civis library from v1.1.0 to v1.2.0 (#5)
- Various changes to packages to avoid installing MKL (#9)
- Pinned conda to 4.1.11 (#9)

### Fixed
- Changed location of `matplotlibrc` to always be found (#6)
- Add `matplotlibrc` file which changes the backend default to "Agg" (#3)
- Add `source activate datascience` to `etc/profile` to ensure bash enjoys the datascience environment (#4)

## [1.0.0] - 2017-01-17

* Initial Release
