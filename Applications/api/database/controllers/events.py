from database.controllers.topics import get_topic

from schemas.event import PEventBase
from database.models.models import Event, Stream, Topic, User


async def get_event(id_event: int) -> Event:
    return await Event.get(id=id_event)

async def get_event_full(id_event: int) -> Event:
    obj = await Event.get(id=id_event).prefetch_related()
    obj.topic = await get_topic(obj.topic_id)
    return obj
    

async def get_events():
    return await Event.all()

async def get_events_without_cast():
    return await Event.filter(stream=None).all()

async def get_events_by_user(uuid: str):
    events = []
    obj = await User.get(uuid=uuid).prefetch_related()
    streams = [group.stream_id for group in await obj.groups()]
    streams.remove(None)
    for stream in streams:
        events += await Event.filter(stream=stream).all()
    return events

async def create_event(event: PEventBase) -> Event:
    return await Event.create(**event.dict(exclude_unset=True))


async def update_event(event: PEventBase, id_event: int) -> Event:
    await Event.filter(id=id_event).update(**event.dict(exclude_unset=True))
    return await Event.get(id=id_event)


async def delete_event(id_event: int) -> dict[str, str]:
    await Event.filter(id=id_event).delete()
    return {"INFO": "Event deleted"}
