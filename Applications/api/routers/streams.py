from typing import List
from fastapi import APIRouter, HTTPException, status

from schemas.stream import PStreamDB, PStreamFull, PStreamFuller, PStreamPost
from database.models.models import Stream
from database.controllers import streams


router = APIRouter(prefix="/stream", tags=["streams"])


async def verify_stream(id: int, isFull: bool) -> Stream:
    if isFull:
        obj = await streams.get_stream_full(id)
    else:
        obj = await streams.get_stream(id)
    if obj is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND)
    return obj


@router.get("/user/{uuid}", response_model=List[PStreamDB])
async def get_streams_by_user(uuid: str):
    return await streams.get_streams_by_user(uuid)


@router.get("/", response_model=List[PStreamDB])
async def get_streams():
    return await streams.get_streams()

@router.get("/{id}", response_model=PStreamFull)
async def get_stream(id: int) -> Stream:
    return await verify_stream(id, False)


@router.get("/{id}/full", response_model=PStreamFuller)
async def get_stream(id: int) -> Stream:
    return await verify_stream(id, True)


@router.post("/", response_model=PStreamDB, status_code=status.HTTP_201_CREATED)
async def create_stream(stream: PStreamPost) -> Stream:
    return await streams.create_stream(stream)


@router.put("/{id}", response_model=PStreamDB, status_code=status.HTTP_200_OK)
async def update_stream(stream: PStreamPost, id: int) -> Stream:
    if await verify_stream(id, False):
        return await streams.update_stream(stream, id)


@router.delete("/{id}", status_code=status.HTTP_200_OK)
async def delete_stream(id: int) -> dict[str, str]:
    if await verify_stream(id, False):
        return await streams.delete_stream(id)
