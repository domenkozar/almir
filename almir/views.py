import collections
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

    if not request.POST['bconsole_command'] and bconsole_session is not None:
        return {"commands": list(command_cache)}

    b = BConsole()
    bconsole_session, response = b.send_command_by_polling(request.POST['bconsole_command'], bconsole_session)

    if 'error' in response:
        command_cache.clear()

    if 'commands' in response:
        command_cache.extend(response['commands'])
    return response


def httpexception(context, request):
    request.response.status_int = context.code
    return {'context': context}


def datatables(request):
    q = request.GET
    iDisplayStart = q.get('iDisplayStart')
    iDisplayLength = q.get('iDisplayLength')
    iColumns = q.get('iColumns')
    sSearch = q.get('sSearch')
    bRegex = q.get('bRegex')
    bSearchable_ = q.get('bSearchable_')
    sSearch_ = q.get('sSearch_')
    bSortable_ = q.get('bSortable_')
    iSortingCols = q.get('iSortingCols')
    iSortCol_ = q.get('iSortCol_')
    sSortDir_ = q.get('sSortDir_')
    mDataProp_ = q.get('mDataProp_')
    sEcho = q.get('sEcho')

    return {
            'sEcho': str(int(sEcho)),  # to be sure it's an integer
    }
