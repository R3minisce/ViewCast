from typing import List
from pydantic import BaseModel, Field, StrictBytes

class PFileBase(BaseModel):
    name: str = Field(..., min_length=3, max_length=255, regex="^.+$")
    type: str = Field(..., min_length=2, max_length=255, regex="^.+$")
    bytes: bytes

    class Config:
        orm_mode = True

class PFileDB(PFileBase):
    id: int

