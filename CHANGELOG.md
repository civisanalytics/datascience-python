# Change Log

All changes to this project will be documented in this file.

Version number changes (major.minor.micro) in this package denote the following:
- A micro version will increase if the only change in a release is incrementing micro versions (bugfix-only releases) on the packages contained in this image.
- A minor version will increase if one or more packages contained in the Docker image add new, backwards-compatible features, or if a new package is added to the Docker image.
- A major version will increase if there are any backwards-incompatible changes in any of the packages contained in this Docker image, or any other backwards-incompatible changes in the execution environment.

## [3.3.0] - 2017-10-30
### New packages
- civisml-extensions 0.1.5

## [3.2.0] - 2017-09-11
### Package Updates
- scikit-learn 0.18.2 -> 0.19.0
- civis 1.6.0 -> 1.6.2
- requests 2.14.2 -> 2.18.4
- urllib3 1.19 -> 1.22

## [3.1.0] - 2017-07-31
### New packages
- cloudpickle 0.3.1
- pyarrow 0.5.0 (from conda-forge)

### Python
- Update from v3.6.1 to v3.6.2

### Package Updates
- civis 1.5.2 -> 1.6.0
- cython 0.25.2 -> 0.26
- ipython 6.0.0 -> 6.1.0
- jinja2 2.8 -> 2.9.6
- numpy 1.12.1 -> 1.13.1
- pandas 0.20.1 -> 0.20.3
- pytest 3.0.5 -> 3.1.3
- seaborn 0.7.1 -> 0.8
- scipy 0.19.0 -> 0.19.1
- scikit-learn 0.18.1 -> 0.18.2
- pubnub 4.0.10 -> 4.0.12
- requests-toolbelt 0.7.1 -> 0.8.0
- tensorflow 1.1.0 -> 1.2.1

### Changed
- Install xgboost from conda-forge instead of from PyPI

### Fixes
- Use /tmp for joblib temporary files instead of /shm


## [3.0.1] - 2017-05-25
### Package Updates
- muffnn 1.1.1 -> 1.1.2

## [3.0.0] - 2017-05-17
### Package updates
- civis 1.4.0 -> 1.5.2
- ipython 5.1.0 -> 6.0.0
- matplotlib 2.0.0 -> 2.0.2
- pandas 0.19.2 -> 0.20.1
- requests 2.13.0 -> 2.14.2

## [2.2.0] - 2017-05-02
### Removed
- Remove pinned conda installs of `libgcc` and `libsodium`. This prevented use of the environment file in OS X, and they are dependencies automatically installed by conda in the Docker image build.

### Additions
- Explicitly added `botocore` v1.5.38. We had `botocore` installed before (it's a dependency of other AWS libraries), but we're now explicitly including the version number.

### Package updates
- python 3.6.0 -> 3.6.1
- awscli 1.11.60 -> 1.11.75
- boto 2.45.0 -> 2.46.1
- boto3 1.4.3 -> 1.4.4
- numpy 1.12.0 -> 1.12.1
- pubnub 4.0.8 -> 4.0.10
- requests 2.12.4 -> 2.13.0
- scipy 0.18.1 -> 0.19.0
- muffnn 1.0.0 -> 1.1.1
- tensorflow 1.0.0 -> 1.1.0

## [2.1.0] - 2017-03-17
### Changed
- Upgrade `civis` to v1.4.0 (#25)
- Changed name of environment in `environment.yml` file to `datascience` (but conda install is still `root`). (#26)
- Removed a few Docker layers. (#26)
- Cleared more of the `apt-get`, `pip` and `conda` caches. (#26)
- Added a test of the `numpy` install. (#26)

## [2.0.1] - 2017-03-10
### Fixed
- Update `awscli` to prevent pip conflict with `botocore`: awscli 1.11.27 --> 1.11.60 (#22)

## [2.0.0] - 2017-03-09
### API-breaking changes
- Removed `nltk` package
- Moved package install environment from "datascience" to the root environment
- Upgrade `matplotlib` to v2.0.0

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
    - numexpr 2.6.1 --> 2.6.2
    - numpy 1.11.3 --> 1.12.0
    - pandas 0.19.1 --> 0.19.2
    - pyyaml 3.11 --> 3.12
    - requests 2.12.1 --> 2.12.4
    - statsmodels 0.6.1 --> 0.8.0
- Upgrade `civis` to v1.3 (#16)
- Moved package install from the `datascience` environment to `root` (#8)
- Clean the conda cache and skip recommended package installs to reduce Docker image size (#18)

### Removed
- nltk 3.2.2 (#20)

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
