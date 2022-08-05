from typing import List
from schemas.display import PDisplayBase
from schemas.event import PEventBase
from schemas.file import PFileBase
from schemas.group import PGroupBase, PGroupOut
from tortoise.models import Model
from tortoise import fields
from tortoise.exceptions import NoValuesFetched

from schemas.topic import PTopicBase
from schemas.user import PUserBase


class Display(Model):
    id = fields.IntField(pk=True, generated=True, index=True)
    name = fields.CharField(max_length=255, unique=True, index=True)
    creation_time = fields.DatetimeField(auto_now_add=True)
    group: fields.ForeignKeyRelation["Group"] = fields.ForeignKeyField("models.Group",
                                                                       related_name="displays_list",
                                                                       null=True,
                                                                       on_delete=fields.SET_NULL,
                                                                       index=True)


class User(Model):
    id = fields.IntField(pk=True, generated=True, index=True)
    uuid = fields.CharField(max_length=36, unique=True, index=True)
    username = fields.CharField(max_length=25, unique=True, index=True)
    email = fields.CharField(max_length=255, unique=True, index=True)
    creation_time = fields.DatetimeField(auto_now_add=True)
    password = fields.CharField(max_length=255, index=True)
    disabled = fields.BooleanField(default=False)
    salt = fields.CharField(max_length=255)
    admin = fields.BooleanField(default=False)
    scopes = fields.CharField(max_length=255)
    groups_list: fields.ManyToManyRelation["Group"]

    async def groups(self) -> List[PGroupBase]:
        try:
            return await self.groups_list.all()
        except NoValuesFetched:
            return -1

    class PydanticMeta:
        computed = ("groups_list",)



class Group(Model):
    id = fields.IntField(pk=True, generated=True, index=True)
    name = fields.CharField(max_length=255, unique=True, index=True)
    description = fields.CharField(max_length=255)
    displays_list: fields.ReverseRelation[Display]
    stream: fields.ForeignKeyRelation["Stream"] = fields.ForeignKeyField("models.Stream",
                                                                       related_name="groups_list",
                                                                       null=True,
                                                                       on_delete=fields.SET_NULL,
                                                                       index=True)
    users_list: fields.ManyToManyRelation[User] = fields.ManyToManyField('models.User',
                                                                               related_name='groups_list',
                                                                               through='user_group')

    async def users(self) -> List[PUserBase]:
        try:
            return await self.users_list.all()
        except NoValuesFetched:
            return -1

    async def displays_count(self) -> int:
        try:
            return await self.displays_list.all().count()
        except NoValuesFetched:
            return -1

    async def displays(self) -> List[PDisplayBase]:
        try:
            return await self.displays_list.all()
        except NoValuesFetched:
            return -1

    class PydanticMeta:
        computed = ("displays_count", "displays_list", "users_list",)

class Event(Model):
    id = fields.IntField(pk=True, generated=True, index=True)
    name = fields.CharField(max_length=255, unique=True)
    specific_date = fields.CharField(max_length=255, null=True)
    start_hour =  fields.CharField(max_length=255)
    end_hour = fields.CharField(max_length=255)
    days = fields.CharField(null=True, max_length=7)
    timer = fields.IntField()
    stream: fields.ForeignKeyRelation["Stream"] = fields.ForeignKeyField("models.Stream",
                                                                       related_name="events_list",
                                                                       null=True,
                                                                       on_delete=fields.SET_NULL,
                                                                       index=True)
    topic: fields.ForeignKeyRelation["Topic"] = fields.ForeignKeyField("models.Topic",
                                                                       related_name="events_list",
                                                                       null=True,
                                                                       on_delete=fields.SET_NULL,
                                                                       index=True)



class Topic(Model):
    id = fields.IntField(pk=True, generated=True, index=True)
    name = fields.CharField(max_length=255, unique=True, index=True)
    events_list: fields.ReverseRelation[Event]
    files_list: fields.ReverseRelation["Topic_file"]

    async def events_count(self) -> int:
        try:
            return await self.events_list.all().count()
        except NoValuesFetched:
            return -1

    async def events(self) -> List[PEventBase]:
        try:
            return await self.events_list.all()
        except NoValuesFetched:
            return -1

    async def files(self) -> List[PFileBase]:
        try:
            topic_files = await Topic_file.filter(topic_id=self.id).order_by('order').prefetch_related()
            return [await File.get(id=file.file_id).prefetch_related() for file in topic_files]
        except NoValuesFetched:
            return -1
        
    async def files_count(self) -> int:
        try:
            return await self.files_list.all().count()
        except NoValuesFetched:
            return -1

    class PydanticMeta:
        computed = ("events_count", "events_list", "files_list", "files_count",)


class Stream(Model):
    id = fields.IntField(pk=True, generated=True, index=True)
    name = fields.CharField(max_length=255, unique=True, index=True)
    groups_list: fields.ReverseRelation[Group]
    events_list: fields.ReverseRelation[Event]

    async def groups_count(self) -> int:
        try:
            return await self.groups_list.all().count()
        except NoValuesFetched:
            return -1

    async def groups(self) -> List[PGroupOut]:
        try:
            objs = await self.groups_list.all().prefetch_related()
            for obj in objs:
                obj.displays_count = await obj.displays_count()
            return objs
        except NoValuesFetched:
            return -1

    async def events_count(self) -> int:
        try:
            return await self.events_list.all().count()
        except NoValuesFetched:
            return -1

    async def events(self) -> List[PEventBase]:
        try:
            return await self.events_list.all()
        except NoValuesFetched:
            return -1

    class PydanticMeta:
        computed = ("groups_count", "groups_list", "events_count", "events_list",)

class File(Model):
    id = fields.IntField(pk=True, generated=True, index=True)
    name = fields.CharField(max_length=255, unique=True, index=True)
    bytes = fields.BinaryField()
    type = fields.CharField(max_length=255)
    # topics_list: fields.ManyToManyRelation[Topic] = fields.ManyToManyField('models.Topic',
    #                                                                            related_name='files_list',
    #                                                                            through='topic_file')
    topics_list: fields.ReverseRelation["Topic_file"]

    async def topics(self) -> List[PTopicBase]:
        try:
            return await self.topics_list.filter(file=self.id).select_related("topic").all()
        except NoValuesFetched:
            return -1

    # class PydanticMeta:
    #     computed = ("topics_list",)
        
class Topic_file(Model):
    id = fields.IntField(pk=True, generated=True, index=True)
    file: fields.ForeignKeyRelation[File] = fields.ForeignKeyField("models.File",
                                                                       related_name="topics_list",
                                                                       null=False,
                                                                       on_delete=fields.CASCADE)
    topic: fields.ForeignKeyRelation[Topic] = fields.ForeignKeyField("models.Topic",
                                                                       related_name="files_list",
                                                                       null=False,
                                                                       on_delete=fields.CASCADE)
    order = fields.IntField(null=False)
