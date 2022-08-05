from fastapi import HTTPException, status
from uuid import uuid4

from database.models.models import User
from database.controllers import groups
from schemas.user import PUserPass, PUserScope, PUserStatus, PUserChangePass, PUserEdit
from services.dependencies import hash_password, setattrs


async def get_user(uuid: str) -> User:
    obj = await User.get(uuid=uuid).prefetch_related()
    obj.groups = await obj.groups()
    for group in obj.groups:
            group.displays_count = await group.displays_count()
    return obj

async def get_user_by_username(username: str) -> User:
    return await User.get(username=username)


async def get_users():
    objs = await User.all().prefetch_related()
    for obj in objs:
        obj.groups = await obj.groups()  
        for group in obj.groups:
            group.displays_count = await group.displays_count()
    return objs


async def create_user(user: PUserPass) -> User:
    uuid = str(uuid4())
    # usernew = PUserSalt(username=user.username, first_name=user.first_name,
    #                     last_name=user.last_name, email=user.email, salt="", password=user.password, uuid=uuid)
    usernew = PUserScope(username=user.username, salt="", password=user.password, uuid=uuid, scopes="user", groups_ids=user.groups_ids, admin=user.admin, email=user.email)
    usernew.password, usernew.salt = hash_password(user.password, None)
    
    obj = await User.create(**usernew.dict(exclude_unset=True))
    [await obj.groups_list.add(await groups.get_group(id)) for id in user.groups_ids]
    return await get_user(obj.uuid)


async def update_user(user: PUserEdit, uuid: str) -> User:
    await User.filter(uuid=uuid).update(admin=user.admin)
    obj = await get_user(uuid)
    await obj.groups_list.clear()
    [await obj.groups_list.add(await groups.get_group(id)) for id in user.groups_ids]
    return await get_user(uuid)

# Update d'origine
# async def update_user(user: PUserStatus, uuid: str) -> User:
#     await User.filter(uuid=uuid).update(**user.dict(exclude_unset=True))
#     return await get_user(uuid)


async def update_user_password(passwords: PUserChangePass, uuid: str) -> User:
    user_obj = await get_user(uuid)
    old_password, _ = hash_password(passwords.old_password,
                                    user_obj.salt.encode('utf-8'))
    if old_password != user_obj.password:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,
                            detail="Could not validate credentials")
    new_password, new_salt = hash_password(passwords.new_password, None)
    setattrs(user_obj, password=new_password, salt=new_salt)
    await user_obj.save()
    return {"INFO": "Password modified"}


async def update_token(uuid: str, jwt: str) -> User:
    user_obj = await get_user(uuid)
    setattrs(user_obj, tmp_jwt=jwt)
    await user_obj.save()
    return await get_user(uuid)


async def delete_user(uuid: str) -> dict[str, str]:
    await User.filter(uuid=uuid).delete()
    return {"INFO": "User deleted"}
