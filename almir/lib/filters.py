from cgi import escape
import datetime

from webhelpers.date import distance_of_time_in_words, time_ago_in_words
from webhelpers.number import format_byte_size


def nl2br(text):
    return text.replace('\n', '<br />')


def filters(event):
    """Implement template filters for Chameleon"""
    event['escape_html'] = escape
    event['nl2br'] = nl2br
    event['float'] = float
    event['int'] = int
    event['bool'] = bool
    event['distance_of_time_in_words'] = distance_of_time_in_words
    event['time_ago_in_words'] = time_ago_in_words
    event['format_byte_size'] = format_byte_size
    event['now'] = datetime.datetime.now()
