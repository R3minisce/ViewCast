from schemas.display import PDisplayBase

from schemas.group import PGroupBase, PGroupPost
from database.models.models import Display, Group, User
from database.controllers import displays


async def get_group(id_group: int) -> Group:
    obj = await Group.get(id=id_group).prefetch_related()
    obj.displays_count = await obj.displays_count()
    obj.displays = await obj.displays()
    return obj

async def get_groups_available():
    objs = await Group.filter(stream=None).all().prefetch_related()
    for obj in objs:
        obj.displays_count = await obj.displays_count()
        obj.displays = await obj.displays()
    return objs

async def get_groups():
    objs = await Group.all().prefetch_related()
    for obj in objs:
        obj.displays_count = await obj.displays_count()
        obj.displays = await obj.displays()
    return objs


async def get_groups_by_user(uuid: str):
    obj = await User.get(uuid=uuid).prefetch_related()
    obj.groups = await obj.groups()
    for group in obj.groups:
        group.displays = await group.displays()        
    return obj.groups


async def create_group(group: PGroupPost) -> Group:  
    obj = await Group.create(name=group.name, description=group.description)
    for display_id in group.displays_ids:
        display = await Display.filter(id=display_id).first()
        await displays.update_display(PDisplayBase(name=display.name, group_id=obj.id), display.id)
    return await get_group(obj.id)


async def update_group(group: PGroupPost, id_group: int) -> Group:
    await Group.filter(id=id_group).update(name=group.name, description=group.description)
    await Display.filter(group_id=id_group).update(group_id=None)
    for display_id in group.displays_ids:
        display = await Display.filter(id=display_id).first()
        await displays.update_display(PDisplayBase(name=display.name, group_id=id_group), display.id)
    return await get_group(id_group)


async def delete_group(id_group: int) -> dict[str, str]:
    await Display.filter(group_id=id_group).update(group_id=None)
    await Group.filter(id=id_group).delete()
    return {"INFO": "Group deleted"}
