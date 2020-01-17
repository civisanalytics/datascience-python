# Change Log

All changes to this project will be documented in this file.

Version number changes (major.minor.micro) in this package denote the following:
- A micro version will increase if the only change in a release is incrementing micro versions (bugfix-only releases) on the packages contained in this image.
- A minor version will increase if one or more packages contained in the Docker image add new, backwards-compatible features, or if a new package is added to the Docker image.
- A major version will increase if there are any backwards-incompatible changes in any of the packages contained in this Docker image, or any other backwards-incompatible changes in the execution environment.

## Unreleased
### Changed
- Python 3.7.1 -> 3.7.6
- Conda 4.6.8 -> 4.8.1

### Package Updates
- openblas 0.3.5 -> 0.3.6 (#68, #70)
- civis 1.9.4 -> 1.12.0 (#74, same for packages below)
- civisml-extensions 0.1.10 -> 0.2.1
- cloudpickle 0.8.0 -> 1.2.2
- joblib 0.11.0 -> 0.14.1
- muffnn 2.2.0 -> 2.3.0
- nomkl 1.0 -> 3.0
- numpy 1.16.2 -> 1.17.3
- pandas 0.24.1 -> 0.25.3
- pyarrow 0.12.1 -> 0.15.1
- scipy 1.2.0 -> 1.4.1
- scikit-learn 0.19.2 -> 0.22.1

### Added
- added buildspecs for autobuilding and pushing Docker image to Amazon ECR (#69)

## [5.0.0] - 2019-03-12
### Changed
- Ubuntu 14.04 -> 18.04 (#67)
- python 3.6.4 -> 3.7.1
- conda 4.3.30 -> 4.6.8

### New Packages
- explicitly installs click=6.7

### Package Updates
- awscli 1.15.4 -> 1.16.121
- beautifulsoup4 4.5.3 -> 4.7.1
- botocore 1.10.4 -> 1.12.111
- boto 2.46.1 -> 2.49.0
- boto3 1.7.4 -> 1.9.111
- bqplot 0.10.2 -> 0.11.5
- cloudpickle 0.5.2 -> 0.8.0
- cython 0.27.3 -> 0.29.6
- dask 0.17.2 -> 1.1.4
- ipython 6.1.0 -> 7.3.0
- ipywidgets 7.1.0 -> 7.4.2
- jinja2 2.9.6 -> 2.10
- jsonschema 2.5.1 -> 3.0.1
- libtiff 4.0.6 -> 4.0.10
- libxml2 2.9.2 -> 2.9.8
- matplotlib 2.2.2 -> 3.0.3
- notebook 5.4.1 -> 5.7.5
- numexpr 2.6.2 -> 2.6.9
- numpy 1.13.3 -> 1.16.2
- openblas 0.2.20 -> 0.3.5
- pandas 0.22.0 -> 0.24.1
- patsy 0.4.1 -> 0.5.1
- psycopg2 2.6.2 -> 2.7.7
- pyarrow 0.8.0 -> 0.12.1
- pytest 3.1.3 -> 4.3.0
- pyyaml 3.12 -> 3.13
- requests 2.18.4 -> 2.21.0
- s3fs 0.1.2 -> 0.2.0
- seaborn 0.8 -> 0.9.0
- scipy 1.0.1 -> 1.2.0
- scikit-learn 0.19.1 -> 0.19.2
- statsmodels 0.8.0 -> 0.9.0
- urllib3 1.22 -> 1.24.1
- xgboost 0.6a2 -> 0.81
- civis 1.9.0 -> 1.9.4
- civisml-extensions 0.1.8 -> 0.1.10
- dropbox 7.1.1 -> 9.3.0
- glmnet 2.0.0 -> 2.1.1
- muffnn 2.1.0 -> 2.2.0
- pubnub 4.0.13 -> 4.1.2
- requests-toolbelt 0.8.0 -> 0.9.1
- tensorflow 1.7.0 -> 1.13.1

### Maintenance
- Update CircleCI config to v2 (#62).
- Test that tensorflow imports successfully (#67).

## [4.2.0] - 2018-04-26
### Package Updates
- civis 1.8.1 -> 1.9.0
- civisml-extensions 0.1.6 -> 0.1.8
- muffnn 2.0.0 -> 2.1.0

- dask 0.15.4 (pip) -> 0.17.2 (conda)
- tensorflow 1.4.1 -> 1.7.0
- ipython 6.1.0 -> 6.3.1
- matplotlib 2.1.0 -> 2.2.2
- notebook 5.2.2 -> 5.4.1
- scipy 1.0.0 -> 1.0.1
- urllib3 1.22 (pip) -> 1.22 (conda)

## [4.1.0] - 2018-04-19
### Added
- Added a link in the README directing users who may be reading documentation on DockerHub to instead go to GitHub (#56).

### Package Updates
- awscli 1.11.75 (from pip) -> 1.15.4 (from conda)
- botocore 1.5.38 -> 1.10.4
- boto3 1.5.11 -> 1.7.4

## [4.0.1] - 2018-02-01
### Package Updates
- civis 1.8.0 -> 1.8.1

## [4.0.0] - 2018-01-23
### New packages
- bqplot 0.10.2
- feather-format 0.4.0

### Changed
- Updated Python version from 3.6.2 to 3.6.4.

### Package Updates
- civis 1.7.1 -> 1.8.0
- civisml-extensions 0.1.5 -> 0.1.6
- muffnn 1.2.0 -> 2.0.0
- cloudpickle 0.5.1 -> 0.5.2
- dask 0.15.4 -> 0.16.1
- ftputil 3.3.1 -> 3.4
- tensorflow 1.4.0 -> 1.4.1
- boto3 1.4.5 -> 1.5.11
- cython 0.26 -> 0.27.3
- openblas 0.2.19 -> 0.2.20
- pandas 0.21.0 -> 0.22.0
- pyarrow 0.7.1 -> 0.8.0
- scipy 0.19.1 -> 1.0.0
- ipywidgets 7.0.0 -> 7.1.0
- notebook 5.2.0 -> 5.2.2

### Fixed
- Enabled widgetsnbextension so that ipywidgets works.
- Suppress irrelevant warning from tensorflow v1.4

## [3.3.0] - 2017-11-17
### Package Updates
- civis 1.6.2 -> 1.7.1

### New packages
- civisml-extensions 0.1.5
- dask 0.15.4
- s3fs 0.1.2

### Changed
- Moved conda to version 4.3.30

### Package Updates
- boto3 1.4.4 -> 1.4.5
- matplotlib 2.0.2 -> 2.1.0
- numpy 1.13.1 -> 1.13.3
- pandas 0.20.3 -> 0.21.0
- pyarrow 0.5.0 -> 0.7.1
- scikit-learn 0.19.0 -> 0.19.1
- cloudpickle 0.3.1 -> 0.5.1
- muffnn 1.1.2 -> 1.2.0
- pubnub 4.0.12 -> 4.0.13
- tensorflow 1.2.1 -> 1.4.0

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
