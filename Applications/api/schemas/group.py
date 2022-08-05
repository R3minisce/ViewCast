from pydantic import BaseModel, Field
from typing import List, Optional

from schemas.display import PDisplayDB


class PGroupBase(BaseModel):
    name: str = Field(..., min_length=3, max_length=255, regex="^.+$")
    description: Optional[str] = Field("none", max_length=255, regex="^.+$")

    class Config:
        orm_mode = True

class PGroupDB(PGroupBase):
    id: int
    displays: List[PDisplayDB]
    stream_id: Optional[int] = None
    
    class Config:
        orm_mode = True
        
class PGroupOut(PGroupBase):
    id: int
    displays_count: int

class PGroupPost(PGroupBase):
    displays_ids: List[int]
    