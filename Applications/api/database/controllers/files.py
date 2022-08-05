from schemas.file import PFileBase
from database.models.models import File


async def get_file(id_file: int) -> File:
    obj = await File.get(id=id_file).prefetch_related()
    obj.topics = await obj.topics()
    return obj


async def get_files():
    return await File.all()


async def create_file(file: PFileBase) -> File:
    return await File.create(**file.dict(exclude_unset=True))


async def update_file(file: PFileBase, id_file: int) -> File:
    await File.filter(id=id_file).update(**file.dict(exclude_unset=True))
    return await File.get(id=id_file)


async def delete_file(id_file: int) -> dict[str, str]:
    await File.filter(id=id_file).delete()
    return {"INFO": "File deleted"}
