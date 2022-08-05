from pydantic import BaseModel, Field
from typing import List, Optional
from schemas.event import PEventDB, PEventFull

from schemas.group import PGroupBase, PGroupOut


class PStreamBase(BaseModel):
    name: str = Field(..., min_length=3, max_length=255, regex="^.+$")

    class Config:
        orm_mode = True

class PStreamPost(PStreamBase):
    groups_ids: List[int]
    events_ids: List[int]
    
class PStreamDB(PStreamPost):
    id: int
    
class PStreamFull(PStreamBase):
    groups_ids: List[int]
    events_ids: List[int]
    events: List[PEventDB]
    groups: List[PGroupOut]
    id: int
    
class PStreamFuller(PStreamBase):
    groups_ids: List[int]
    events_ids: List[int]
    events: List[PEventFull]
    groups: List[PGroupOut]
    id: int