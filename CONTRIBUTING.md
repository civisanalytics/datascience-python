# Contributing to datascience-python

We welcome bug reports and pull requests from everyone!
This project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the
[Contributor Covenant](http://contributor-covenant.org) code of conduct.


## Getting Started

There are two ways to contribute:

### File an Issue

If you find a bug or think of a useful improvement,
file an issue in this GitHub repository. Make sure to
include details about what you think should be changed
and why. If you're reporting a bug, please provide
a minimum working example so that a maintainer can
reproduce the bug.

### Modify the Docker image

If you know exactly what needs to change, you can also
submit a pull request to propose the change.

1. Fork it ( https://github.com/civisanalytics/datascience-python/fork ).
2. Make sure you are able to build the Docker image locally (`docker build -t datascience-python:test .`)
3. Create a feature branch (`git checkout -b my-new-feature`).
4. Make your change.
5. Make sure the new image still builds correctly. Test that your change is present in the new build.
6. Commit your changes (`git commit -am 'Add some feature'`).
7. Push to the branch (`git push origin my-new-feature`).
8. Create a new pull request with details about your changes.
9. If the build fails, address any issues.

## Tips

- Don’t forget to add your change to the [CHANGELOG](CHANGELOG.md). See
  [Keep a CHANGELOG](http://keepachangelog.com/) for guidelines.

Thank you for taking the time to contribute!
