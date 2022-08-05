from schemas.display import PDisplayBase
from database.models.models import Display, User


async def get_display(id_display: int) -> Display:
    return await Display.get(id=id_display)


async def get_display_by_name(display_name: str) -> Display:
    return await Display.get(name=display_name)


async def get_displays_by_user(uuid: str):
    displays = []
    obj = await User.get(uuid=uuid).prefetch_related()
    obj.groups = await obj.groups()
    for group in obj.groups:
        displays += await group.displays()        
    return displays


async def get_displays():
    return await Display.all()


async def get_displays_without_group():
    return await Display.filter(group=None).all()


async def create_display(display: PDisplayBase) -> Display:
    return await Display.create(**display.dict(exclude_unset=True))


async def update_display(display: PDisplayBase, id_display: int) -> Display:
    await Display.filter(id=id_display).update(**display.dict(exclude_unset=True))
    return await Display.get(id=id_display)


async def delete_display(id_display: int) -> dict[str, str]:
    await Display.filter(id=id_display).delete()
    return {"INFO": "Display deleted"}
