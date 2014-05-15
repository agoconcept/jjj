import unittest

import os
import subprocess


class TestGenericClient(unittest.TestCase):

    JSON_PATH = 'etc/'

    def setUp(self):
        None

    def test_json_lint(self):
        """
        Lint all the JSON files under the services directory
        """
        files = []
        for r, d, fs in os.walk(self.JSON_PATH):
            for f in fs:
                files.append(os.path.join(r, f))

        for f in files:
            return_code = subprocess.call('jsonlint %s' % f,
                                          shell=True)

            self.assertEqual(return_code, 0, 'File %s did not validate' % f)


if __name__ == '__main__':
    unittest.main()
