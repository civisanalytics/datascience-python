#!/usr/bin/env python

import os
import re
import shutil
import unittest


# Just use the stdlib's `unittest` rather than needing to install `pytest`.
class TestImage(unittest.TestCase):

    def test_version(self):
        version_in_env_var = os.getenv("VERSION")
        major = os.getenv("VERSION_MAJOR")
        minor = os.getenv("VERSION_MINOR")
        micro = os.getenv("VERSION_MICRO")
        self.assertTrue(major.isdigit())
        self.assertTrue(minor.isdigit())
        self.assertTrue(micro.isdigit())
        self.assertEqual(version_in_env_var, f"{major}.{minor}.{micro}")

        with open("CHANGELOG.md") as changelog:
            version_in_changelog = re.search(
                r"##\s+\[(\d+\.\d+\.\d+)]", changelog.read()
            ).groups()[0]
        self.assertEqual(version_in_changelog, version_in_env_var)

    def test_scipy_links_to_openblas(self):
        from scipy.linalg import _fblas  # noqa: F401

    def test_numpy_can_import(self):
        import numpy as np  # noqa: F401

    def test_sklearn_can_import(self):
        import sklearn  # noqa: F401

    def test_civis_can_import(self):
        import civis  # noqa: F401
        # civis-python uses lazy imports since v2.3.0,
        # so try to import the top-level modules.
        import civis.io  # noqa: F401
        import civis.parallel  # noqa: F401
        import civis.futures  # noqa: F401
        import civis.ml  # noqa: F401
        import civis.utils  # noqa: F401

    def test_shell_commands_available(self):
        # A non-exhaustive list of commands -- we just test those we'd likely use.
        expected_cmds = "aws civis curl git pip python wget unzip uv".split()
        for cmd in expected_cmds:
            self.assertIsNotNone(shutil.which(cmd), f"{cmd} not found in PATH")


if __name__ == "__main__":
    unittest.main()
