

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
