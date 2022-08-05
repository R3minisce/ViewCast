from typing import List
from fastapi import APIRouter, HTTPException, status

from database.models.models import File
from database.controllers import files
from schemas.file import PFileBase, PFileDB


router = APIRouter(prefix="/file", tags=["files"])


async def verify_file(id: int) -> File:
    obj = await files.get_file(id)
    if obj is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND)
    return obj


@router.get("/", response_model=List[PFileDB])
async def get_files():
    return await files.get_files()


@router.get("/{id}", response_model=PFileDB)
async def get_file(id: int) -> File:
    return await verify_file(id)


@router.post("/", response_model=PFileDB, status_code=status.HTTP_201_CREATED)
async def create_file(file: PFileBase) -> File:
    return await files.create_file(file)


@router.put("/{id}", response_model=PFileDB, status_code=status.HTTP_200_OK)
async def update_file(file: PFileBase, id: int) -> File:
    if await verify_file(id):
        return await files.update_file(file, id)


@router.delete("/{id}", status_code=status.HTTP_200_OK)
async def delete_file(id: int) -> dict[str, str]:
    if await verify_file(id):
        return await files.delete_file(id)
