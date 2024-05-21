#!/usr/bin/env python

import os
import re
import unittest


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

        version_in_changelog = re.search(
            r"##\s+\[(\d+\.\d+\.\d+)]", open("CHANGELOG.md").read()
        ).groups()[0]
        self.assertEqual(version_in_changelog, version_in_env_var)

    def test_scipy_links_to_openblas(self):
        from scipy.linalg import _fblas  # noqa: F401

    def test_numpy_can_import(self):
        import numpy as np  # noqa: F401

    def test_civis_can_import(self):
        import civis  # noqa: F401


if __name__ == "__main__":
    unittest.main()
