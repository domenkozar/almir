import collections

from deform import Form, ValidationFailure
from sqlalchemy.sql.expression import desc
from sqlalchemy.sql.functions import sum, count
from sqlalchemy.orm import joinedload

from almir.meta import DBSession, get_database_size
from almir.models import Job, Client, Log, Media, Storage, Pool, Status
from almir.forms import JobSchema, MediaSchema, LogSchema
from almir.lib.console_commands import CONSOLE_COMMANDS
from almir.lib.bconsole import BConsole
from almir.lib.utils import render_rst_section


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


# restful generic view
class MixinView(object):
    model = None
    schema = None

    def __init__(self, request):
        self.request = request
        self.context = {
                        'appstruct': {},
        }

    def get_form(self):
        """Deals everything regarding forms for a request."""
        if not self.schema:
            return

        schema = self.schema()

        form = Form(schema.bind(**self.context),
                    buttons=[],
                    bootstrap_form_style='form-vertical')

        if self.request.query_string:
            controls = self.request.GET.items()

            try:
                self.context['appstruct'] = form.validate(controls)
                self.request.session[self.schema.__name__] = self.context['appstruct']
                self.request.session.save()
            except ValidationFailure, e:
                return e

        appstruct = self.request.session.get(self.schema.__name__, None)
        if appstruct:
            return form.render(appstruct)
        else:
            return form.render()

    def list(self):
        self.context['form'] = self.get_form()
        self.context['objects'] = self.model.get_list(appstruct=self.context['appstruct'])
        return self.context

    def detail(self):
        id_ = self.request.matchdict['id']
        self.context['object'] = self.model.get_one(id_)
        return self.context


class JobView(MixinView):
    model = Job
    schema = JobSchema

    def list(self):
        # TODO: cache this
        self.context['status_values'] = [('', '---')] + Status.get_values()
        return super(JobView, self).list()


class ClientView(MixinView):
    model = Client

    def detail(self):
        # TODO: get jobs as join/subquery on client
        super(ClientView, self).detail()
        id_ = self.request.matchdict['id']
        jobs = Job.query.filter(Job.clientid == int(id_))
        self.context['jobs'] = jobs.options(joinedload(Job.status)).order_by(desc(Job.schedtime)).limit(50)
        self.context['job_statistics'] = jobs.with_entities(count().label('num_jobs'), sum(Job.jobbytes).label('total_size_backups')).first(),
        self.context['last_successful_job'] = jobs.filter(Job.jobstatus == 'T').order_by(desc(Job.starttime)).first(),
        return self.context


class StorageView(MixinView):
    model = Storage


class VolumeView(MixinView):
    model = Media
    schema = MediaSchema

    def list(self):
        # UPSTREAM: we need to convert id to string, look at https://github.com/Pylons/deform/issues/81
        # TODO: cache
        self.context['storage_values'] = [('', '---')] + map(lambda x: (str(x[0]), x[1]), Storage.get_values())
        self.context['pool_values'] = [('', '---')] + map(lambda x: (str(x[0]), x[1]), Pool.get_values())
        return super(VolumeView, self).list()


class PoolView(MixinView):
    model = Pool


class LogView(MixinView):
    model = Log
    schema = LogSchema


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
