import os
from docutils.core import publish_parts

import pytz
from pyramid.threadlocal import get_current_registry


def convert_timezone(dt):
    timezone = get_current_registry().settings['timezone']
    return pytz.timezone(timezone).localize(dt)


def timedelta_to_seconds(td):
    # http://docs.python.org/library/datetime.html?highlight=total_seconds#datetime.timedelta.total_seconds
    # to keep python2.6 support
    return (td.microseconds + (td.seconds + td.days * 24 * 3600) * 10 ** 6) / 10 ** 6


def render_rst_section(filename):
    path = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'docs', 'source', filename)
    with open(path) as f:
        parts = publish_parts(f.read(), writer_name="html", settings_overrides={'initial_header_level': 2, 'doctitle_xform': False})
        return parts['html_body']
