from typing import List
from fastapi import APIRouter, HTTPException, status, Request

from schemas.display import PDisplayBase, PDisplayDB
from database.models.models import Display
from database.controllers import displays

router = APIRouter(prefix="/display", tags=["displays"])


async def verify_display(id: int) -> Display:
    obj = await displays.get_display(id)
    if obj is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND)
    return obj


async def verify_display_by_name(name: str) -> Display:
    obj = await displays.get_display_by_name(name)
    if obj is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND)
    return obj


@router.get("/", response_model=List[PDisplayDB])
async def get_displays():
    return await displays.get_displays()

@router.get("/user/{uuid}", response_model=List[PDisplayDB])
async def get_displays_by_user(uuid: str):
    return await displays.get_displays_by_user(uuid)

@router.get("/available", response_model=List[PDisplayDB])
async def get_displays_without_group():
    return await displays.get_displays_without_group()


@router.get("/{id}", response_model=PDisplayDB)
async def get_display(id: int) -> Display:
    return await verify_display(id)

@router.get("/name/{name}", response_model=PDisplayDB)
async def get_display_by_name(name: str) -> Display:
    return await verify_display_by_name(name)


@router.post("/", response_model=PDisplayDB, status_code=status.HTTP_201_CREATED)
async def create_display(display: PDisplayBase) -> Display:
    return await displays.create_display(display)


@router.put("/{id}", response_model=PDisplayDB, status_code=status.HTTP_200_OK)
async def update_display(display: PDisplayBase, id: int) -> Display:
    if await verify_display(id):
        return await displays.update_display(display, id)


@router.delete("/{id}", status_code=status.HTTP_200_OK)
async def delete_display(id: int) -> dict[str, str]:
    if await verify_display(id):
        return await displays.delete_display(id)
