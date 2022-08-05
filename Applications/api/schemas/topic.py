from typing import List
from pydantic import BaseModel, Field

from schemas.file import PFileDB


class PTopicBase(BaseModel):
    name: str = Field(..., min_length=3, max_length=255, regex="^.+$")

    class Config:
        orm_mode = True

class PTopicDB(PTopicBase):
    id: int
    files_ids: List[int]

class PTopicFilesIDs(PTopicBase):
    files_ids: List[int]

class PTopicFiles(PTopicDB):
    files: List[PFileDB]