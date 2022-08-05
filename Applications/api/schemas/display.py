from datetime import datetime
from pydantic import BaseModel, Field
from typing import Optional


class PDisplayBase(BaseModel):
    name: str = Field(..., min_length=3, max_length=255, regex="^.+$")
    group_id: Optional[int] = None

class PDisplayDB(PDisplayBase):
    id: int
    creation_time: datetime
