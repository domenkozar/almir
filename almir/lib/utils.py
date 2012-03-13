

def timedelta_to_seconds(td):
    # http://docs.python.org/library/datetime.html?highlight=total_seconds#datetime.timedelta.total_seconds
    # to keep python2.6 support
    return (td.microseconds + (td.seconds + td.days * 24 * 3600) * 10 ** 6) / 10 ** 6
