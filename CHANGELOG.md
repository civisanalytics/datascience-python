# Change Log

All changes to this project will be documented in this file.

Version number changes (major.minor.micro) in this package denote the following:
- A micro version will increase if the only change in a release is incrementing micro versions (bugfix-only releases) on the packages contained in this image.
- A minor version will increase if one or more packages contained in the Docker image add new, backwards-compatible features, or if a new package is added to the Docker image.
- A major version will increase if there are any backwards-incompatible changes in any of the packages contained in this Docker image, or any other backwards-incompabile changes in the execution environment.

## [2.0.0]
### Added
- glmnet 2.0.0 (#16)
- joblib 0.11.0 (#19)
- tensorflow 1.0.0 (#15)
- xgboost 0.6a2 (#15)
- muffnn 1.0.0 (Civis deep learning library #16)
- pubnub 4.0.8 (Used by Civis API client v1.3 #16)
- requests-toolbelt 0.7.1 (Optional for Civis API client v1.3 #16)

### Changed
- Moved conda to version 4.3.11 (#11)
- Moved python to version 3.6.0 (#11)
- Various package version changes (#11, #13)
    - beautifulsoup4 4.5.1 --> 4.5.3
    - boto 2.43.0 --> 2.45.0
    - boto3 1.4.2 --> 1.4.3
    - cython 0.25.1 --> 0.25.2
    - matplotlib 1.5.3 --> 2.0.0
    - nltk 3.2.1 --> 3.2.2
    - numexpr 2.6.1 --> 2.6.2
    - numpy 1.11.3 --> 1.12.0
    - pandas 0.19.1 --> 0.19.2
    - pyyaml 3.11 --> 3.12
    - requests 2.12.1 --> 2.12.4
    - statsmodels 0.6.1 --> 0.8.0
- Upgrade `civis` to v1.3 (#16)
- Moved package install from the `datascience` environment to `root` (#8)
- Clean the conda cache and skip recommended package installs to reduce Docker image size (#18)

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
