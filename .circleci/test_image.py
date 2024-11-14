#!/usr/bin/env python

import os
import re
import shutil
import subprocess
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
        """Ensure the main shell commands are available."""
        # A non-exhaustive list of commands -- we just test those we'd likely use.
        expected_cmds = "aws civis curl git pip python unzip uv wget".split()
        for cmd in expected_cmds:
            self.assertIsNotNone(shutil.which(cmd), f"{cmd} not found in PATH")

    def _test_shell_command(self, cmd: str):
        """Check if the shell command runs successfully in the image."""
        try:
            subprocess.check_call(cmd, shell=True)
        except subprocess.CalledProcessError as e:
            self.fail(
                f"apt-get test failed with return code {e.returncode}\n"
                f"stdout: {e.stdout}\n"
                f"stderr: {e.stderr}"
            )

    def test_apt_get(self):
        """Ensure that apt-get works in the image."""
        self._test_shell_command("apt-get update -y && apt-get install -y htop")

    def test_uv(self):
        """Ensure that uv works in the image."""
        self._test_shell_command("uv pip install python-iso639")


if __name__ == "__main__":
    unittest.main()
