from webhelpers.date import distance_of_time_in_words, time_ago_in_words
from webhelpers.number import format_byte_size


def yesno(text):
    return 'Yes' if text else 'No'


def nl2br(text):
    return text.replace('\n', '<br />')


# TODO: configure those with jinja filters
def filters(event):
    """Implement template filters for Chameleon"""
    event['nl2br'] = nl2br
    event['yesno'] = yesno
    event['float'] = float
    event['distance_of_time_in_words'] = distance_of_time_in_words
    event['time_ago_in_words'] = time_ago_in_words
    event['format_byte_size'] = format_byte_size
