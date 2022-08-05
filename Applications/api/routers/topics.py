from typing import List
from fastapi import APIRouter, HTTPException, status

from database.models.models import Topic, Topic
from database.controllers import topics
from schemas.topic import PTopicBase, PTopicDB, PTopicFiles, PTopicFilesIDs


router = APIRouter(prefix="/topic", tags=["topics"])


async def verify_topic(id: int) -> Topic:
    obj = await topics.get_topic(id)
    if obj is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND)
    return obj


async def verify_topic_files(id: int) -> Topic:
    obj = await topics.get_topic_files(id)
    if obj is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND)
    return obj


@router.get("/", response_model=List[PTopicDB])
async def get_topics():
    return await topics.get_topics()


@router.get("/{id}", response_model=PTopicDB)
async def get_topic(id: int) -> Topic:
    return await verify_topic(id)


@router.get("/{id}/files", response_model=PTopicFiles)
async def get_topic_with_files(id: int) -> Topic:
    return await verify_topic(id)


@router.post("/", response_model=PTopicDB, status_code=status.HTTP_201_CREATED)
async def create_topic(topic: PTopicFilesIDs) -> Topic:
    return await topics.create_topic(topic)


@router.put("/{id}", response_model=PTopicDB, status_code=status.HTTP_200_OK)
async def update_topic(topic: PTopicFilesIDs, id: int) -> Topic:
    if await verify_topic(id):
        return await topics.update_topic(topic, id)


@router.delete("/{id}", status_code=status.HTTP_200_OK)
async def delete_topic(id: int) -> dict[str, str]:
    if await verify_topic(id):
        return await topics.delete_topic(id)
