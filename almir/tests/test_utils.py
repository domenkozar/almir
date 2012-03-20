import datetime

from almir.lib.utils import convert_timezone
from almir.tests.test_functional import AlmirTestCase


class TestUtils(AlmirTestCase):

    def test_timezone(self):
        self.assertEqual(convert_timezone(None), None)
        self.assertNotEqual(convert_timezone(datetime.datetime.now()).tzinfo, None)
