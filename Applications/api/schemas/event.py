from datetime import date, time
from pydantic import BaseModel
from typing import List, Optional

from schemas.topic import PTopicDB


class PEventBase(BaseModel):
    
    name: str
    start_hour: time
    end_hour: time
    days: Optional[str]
    specific_date: Optional[date]
    timer: int
    topic_id: Optional[int] = None

    class Config:
        orm_mode = True
        arbitrary_types_allowed = True

class PEventDB(PEventBase):
    id: int
    stream_id: Optional[int] = None
    
class PEventFull(PEventDB):
    topic: Optional[PTopicDB]
