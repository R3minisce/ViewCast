from schemas.topic import PTopicBase, PTopicFilesIDs
from database.models.models import Topic, Topic_file


async def get_topic(id_topic: int) -> Topic:
    try:
        obj = await Topic.get(id=id_topic).prefetch_related()
        obj.files_count = await obj.files_count()
        obj.files_ids = [i.id for i in await obj.files()]
        obj.files = await obj.files()
        return obj
    except:
        return None

async def get_topic_files(id_topic: int) -> Topic:
    obj = await Topic.get(id=id_topic).prefetch_related()
    obj.files = await obj.files()
    return obj


async def get_topics():
    objs = await Topic.all().prefetch_related().order_by('id')
    for obj in objs:
        obj.files_count = await obj.files_count()
        obj.files_ids = [i.id for i in await obj.files()]
    return objs


async def create_topic(topic: PTopicFilesIDs) -> Topic:
    topic_obj = PTopicBase(**topic.dict(exclude_unset=True))
    obj = await Topic.create(**topic_obj.dict(exclude_unset=True))
    for i, file in enumerate(topic.files_ids):
        await Topic_file.create(file_id=file, topic_id=obj.id, order=i+1)
    return await get_topic(obj.id)


async def update_topic(topic: Topic, id_topic: int) -> Topic:
    obj = await get_topic(id_topic)
    obj.name = topic.name
    await Topic_file.filter(topic_id=id_topic).delete()
    for i, file in enumerate(topic.files_ids):
        await Topic_file.create(file_id=file, topic_id=obj.id, order=i+1)
    return await get_topic(id_topic)


async def delete_topic(id_topic: int) -> dict[str, str]:
    await Topic.filter(id=id_topic).delete()
    return {"INFO": "Topic deleted"}
