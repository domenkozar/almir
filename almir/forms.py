import colander

from almir.models import TYPES


class LogFilterSchema(colander.MappingSchema):
    job_id = colander.SchemaNode(colander.Integer())
    number_of_entries = colander.SchemaNode(colander.Integer(), default=50, validator=colander.Range(5, 1000))
    # TODO: time range


class LogJobSchema(colander.MappingSchema):
    client = colander.SchemaNode(colander.String())  # autocomplete clients
    type = colander.SchemaNode(colander.String(), validator=colander.OneOf(TYPES.values()))
    number_of_entries = colander.SchemaNode(colander.Integer(), default=50, validator=colander.Range(5, 1000))
    # TODO: time range


class LogClientSchema(colander.MappingSchema):
    client = colander.SchemaNode(colander.String())  # autocomplete clients
    type = colander.SchemaNode(colander.String(), validator=colander.OneOf(TYPES.values()))
    number_of_entries = colander.SchemaNode(colander.Integer(), default=50, validator=colander.Range(5, 1000))


class LogStorageSchema(colander.MappingSchema):
    search_message = colander.SchemaNode(colander.String())


class LogVolumeSchema(colander.MappingSchema):
    search_message = colander.SchemaNode(colander.String())


class LogPoolSchema(colander.MappingSchema):
    search_message = colander.SchemaNode(colander.String())


# TODO: do live filtering (ajax deform?)
# TODO: remember filter settings
