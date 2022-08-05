from database.controllers.topics import get_topic

from schemas.stream import PStreamBase, PStreamPost
from database.models.models import Event, Group, Stream, Topic, User


async def get_stream(id_stream: int) -> Stream:
    obj = await Stream.get(id=id_stream).prefetch_related()
    obj.events_ids = [i.id for i in await obj.events()]
    obj.groups_ids = [j.id for j in await obj.groups()]
    obj.groups = await obj.groups()
    obj.events = await obj.events()
    return obj


async def get_stream_full(id_stream: int) -> Stream:
    obj = await Stream.get(id=id_stream).prefetch_related()
    obj.events_ids = [i.id for i in await obj.events()]
    obj.groups_ids = [j.id for j in await obj.groups()]
    obj.groups = await obj.groups()
    obj.events = await obj.events()
    for e in obj.events:
        if await get_topic(e.topic_id) is not None:
            e.topic = await get_topic(e.topic_id)
        else:
            e.topic = None
    return obj


async def get_streams_by_user(uuid: str):
    obj = await User.get(uuid=uuid).prefetch_related()
    streams = [group.stream_id for group in await obj.groups()]
    objs = await Stream.filter(id__in=streams).all().order_by('id').prefetch_related()
    for obj in objs:
        obj.events_ids = [i.id for i in await obj.events()]
        obj.groups_ids = [j.id for j in await obj.groups()]
    return objs

async def get_streams():
    objs = await Stream.all().order_by('id').prefetch_related()
    for obj in objs:
        obj.events_ids = [i.id for i in await obj.events()]
        obj.groups_ids = [j.id for j in await obj.groups()]
    return objs


async def create_stream(stream: PStreamPost) -> Stream:
    obj =  await Stream.create(name=stream.name)
    for event_id in stream.events_ids:
        await Event.filter(id=event_id).update(stream_id=obj.id)
    for group_id in stream.groups_ids:
        await Group.filter(id=group_id).update(stream_id=obj.id)
        
    return await get_stream(obj.id)


async def update_stream(stream: PStreamPost, id_stream: int) -> Stream:
    await Stream.filter(id=id_stream).update(name=stream.name)
    await Event.filter(stream_id=id_stream).update(stream_id=None)
    await Group.filter(stream_id=id_stream).update(stream_id=None)
    for event_id in stream.events_ids:
        await Event.filter(id=event_id).update(stream_id=id_stream)
    for group_id in stream.groups_ids:
        await Group.filter(id=group_id).update(stream_id=id_stream)
    return await get_stream(id_stream)


async def delete_stream(id_stream: int) -> dict[str, str]:
    await Stream.filter(id=id_stream).delete()
    return {"INFO": "Stream deleted"}
