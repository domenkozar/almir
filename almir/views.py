import collections
import fcntl
import select
import os

from deform import Form
from sqlalchemy.sql.expression import desc
from sqlalchemy.sql.functions import sum, count

from almir.meta import DBSession, get_database_size
from almir.models import Job, Client, Log, Media, Storage, Pool
from almir.forms import *
from almir.lib.console_commands import CONSOLE_COMMANDS
from almir.lib.bconsole import BConsole
from almir.lib.utils import render_rst_section, nl2br


def dashboard(request):
    dbsession = DBSession()

    jobs = Job.get_last()
    running_jobs = Job.get_running()
    upcoming_jobs = Job.get_upcoming()

    # statistics
    num_clients = dbsession.query(count(Client.clientid)).scalar()
    num_jobs = dbsession.query(count(Job.jobid)).scalar()
    num_volumes = dbsession.query(count(Media.mediaid)).scalar()
    sum_volumes = Media.format_byte_size(dbsession.query(sum(Media.volbytes)).scalar() or 0)
    database_size = get_database_size(DBSession.bind)

    return locals()


def about(request):
    changelog = render_rst_section('changelog.rst')
    about = render_rst_section('about.rst')
    return locals()


def console(request):
    # TODO: do all checks if console is working
    permission_problem = False
    command_array = ','.join(['"%s"' % name for name in CONSOLE_COMMANDS.keys()])
    console_commands = CONSOLE_COMMANDS
    return locals()


def log(request):
    dbsession = DBSession()
    logs = dbsession.query(Log).order_by(desc(Log.time)).limit(50)
    form = Form(
        LogFilterSchema(),
        buttons=[],
        use_ajax=True,
        ajax_options="""
        {success:
            function (rtext, stext, xhr, form) {
                console.log(rtext);
            }
        }
        """,
    )
    # TODO: ajaxify results
    # TODO: remember form value (validate)
    # form.render(form.validate(request.POST.items()))
    # TODO: job id should be clickable
    # TODO: strip message begining
    # TODO: display daemon name column
    return locals()


# restful generic view
class MixinView(object):
    model = None
    form = None

    def __init__(self, request):
        self.request = request

    def list(self):
        d = self.model.objects_list()
        if self.form:
            d.update({'form': Form(self.form(), buttons=[])})
        return d

    def detail(self):
        id_ = self.request.matchdict['id']
        return self.model.object_detail(id_)


class JobView(MixinView):
    model = Job
    form = LogJobSchema


class ClientView(MixinView):
    model = Client
    form = LogClientSchema


class StorageView(MixinView):
    model = Storage
    form = LogStorageSchema


class VolumeView(MixinView):
    model = Media
    form = LogVolumeSchema


class PoolView(MixinView):
    model = Pool
    form = LogPoolSchema


bconsole_session = None
command_cache = collections.deque(maxlen=10)

def ajax_console_input(request):
    global bconsole_session
    # TODO: if status for client is requested, it might timeout after few seconds, but not 0.5
    # TODO: thread locking
    # TODO: implement session based on cookie
    # TODO: stderr?
    # TODO: config file could be set with buildout
    # TODO: tests
    # TODO: .messages
    # TODO: what to do on quit command?

    # if we have a session with no entered commands, just return last 10 commands
    if not request.POST['bconsole_command'] and bconsole_session is not None:
        return {"commands": list(command_cache)}

    # start bconsole session if it's not initialized
    if bconsole_session is None:
        bconsole_session = BConsole().start_process()

    if bconsole_session.poll():
        bconsole_session = None
        command_cache.clear()
        return {'error': 'Connection to director terminated. Refresh to reconnect.'}

    # send bconsole command
    if request.POST['bconsole_command']:
        bconsole_session.stdin.write(request.POST['bconsole_command'].strip()+'\n')

    # make stdout fileobject nonblockable
    fp = bconsole_session.stdout.fileno()
    flags = fcntl.fcntl(fp, fcntl.F_GETFL)
    fcntl.fcntl(fp, fcntl.F_SETFL, flags | os.O_NONBLOCK)

    output = ''

    while 1:
        # wait for data or timeout
        [i, o, e] = select.select([fp], [], [], 1)
        if i:
            # we have more data
            output += bconsole_session.stdout.read(1000)
        else:
            # we have a timeout
            output = nl2br(output)
            command_cache.append(output)

            return {
                "commands": [output]
            }
