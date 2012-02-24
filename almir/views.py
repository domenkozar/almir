from datetime import datetime

from deform import Form
from sqlalchemy.sql.expression import desc
from sqlalchemy.sql.functions import sum, count

from almir.meta import DBSession
from almir.models import Job, Client, Log, Media, Storage, Pool
from almir.forms import *
from almir.lib.bconsole import BConsole
from almir.lib.filters import nl2br


def dashboard(request):
    dbsession = DBSession()
    jobs = dbsession.query(Job).order_by(desc(Job.schedtime)).limit(5)

    # statistics
    num_clients = dbsession.query(Client).count()
    num_jobs = dbsession.query(Job).count()
    num_media = dbsession.query(Media).count()
    sum_volumes = dbsession.query(sum(Media.volbytes)).scalar()
    now = datetime.now()
    return locals()


def about(request):
    return locals()


def console(request):
    permission_problem = False
    return locals()


def console_ajax(request):
    b = BConsole()
    stdout, stderr = b.run_command(request.POST['bconsole_command'].strip())
    return {
        "stdout": nl2br(stdout),
        "stderr": nl2br(stderr),
    }


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
    # TODO: pass request to models

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

    # TODO: file.lstat http://old.nabble.com/The-File.LStat-field-td940366.html


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
