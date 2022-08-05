from fastapi import APIRouter, HTTPException, status

from schemas.group import PGroupBase, PGroupDB, PGroupPost
from database.models.models import Group
from database.controllers import groups
from typing import List

router = APIRouter(prefix="/group", tags=["groups"])


async def verify_group(id: int) -> Group:
    obj = await groups.get_group(id)
    if obj is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND)
    return obj


@router.get("/", response_model=List[PGroupDB])
async def get_groups():
    return await groups.get_groups()

@router.get("/user/{uuid}", response_model=List[PGroupDB])
async def get_groups_by_user(uuid: str):
    return await groups.get_groups_by_user(uuid)

@router.get("/available", response_model=List[PGroupDB])
async def get_groups_available():
    return await groups.get_groups_available()


@router.get("/{id}", response_model=PGroupDB)
async def get_group(id: int) -> Group:
    return await verify_group(id)


@router.post("/", response_model=PGroupDB, status_code=status.HTTP_201_CREATED)
async def create_group(group: PGroupPost) -> Group:
    return await groups.create_group(group)


@router.put("/{id}", response_model=PGroupDB, status_code=status.HTTP_200_OK)
async def update_group(group: PGroupPost, id: int) -> Group:
    if await verify_group(id):
        return await groups.update_group(group, id)


@router.delete("/{id}", status_code=status.HTTP_200_OK)
async def delete_group(id: int) -> dict[str, str]:
    if await verify_group(id):
        return await groups.delete_group(id)
