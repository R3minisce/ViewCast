from typing import List
from fastapi import APIRouter, HTTPException, status

from database.models.models import Event, Event
from database.controllers import events
from schemas.event import PEventBase, PEventDB, PEventFull


router = APIRouter(prefix="/event", tags=["events"])


async def verify_event(id: int, isFull: bool) -> Event:
    if isFull:
        obj = await events.get_event_full(id)
    else:
        obj = await events.get_event(id)
    if obj is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND)
    return obj


@router.get("/", response_model=List[PEventDB])
async def get_events():
    return await events.get_events()

@router.get("/user/{uuid}", response_model=List[PEventDB])
async def get_events_by_user(uuid: str):
    return await events.get_events_by_user(uuid)

@router.get("/available", response_model=List[PEventDB])
async def get_events_available():
    return await events.get_events_without_cast()

@router.get("/{id}/full", response_model=PEventFull)
async def get_event_full(id: int) -> Event:
    return await verify_event(id, True)


@router.get("/{id}", response_model=PEventDB)
async def get_event(id: int) -> Event:
    return await verify_event(id, False)


@router.post("/", response_model=PEventDB, status_code=status.HTTP_201_CREATED)
async def create_event(event: PEventBase) -> Event:
    return await events.create_event(event)


@router.put("/{id}", response_model=PEventDB, status_code=status.HTTP_200_OK)
async def update_event(event: PEventBase, id: int) -> Event:
    if await verify_event(id, False):
        return await events.update_event(event, id)


@router.delete("/{id}", status_code=status.HTTP_200_OK)
async def delete_event(id: int) -> dict[str, str]:
    if await verify_event(id, False):
        return await events.delete_event(id)
