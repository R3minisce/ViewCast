from datetime import datetime
from pydantic import Field, BaseModel
from typing import List

from config.parameters import PASSWORD_POLICY, EMAIL_POLICY
from schemas.group import PGroupOut

class PUserBase(BaseModel):
    username: str = Field(..., min_length=5, max_length=20, regex="^.+$")
    # first_name: str = Field(..., min_length=2, max_length=20, regex="^.+$")
    # last_name: str = Field(..., min_length=2, max_length=20, regex="^.+$")
    email: str = Field(..., regex=EMAIL_POLICY)

    class Config:
        orm_mode = True

class PUserDB(PUserBase):
    uuid: str
    creation_time: datetime
    admin: bool


class PUserOut(PUserDB):
    groups: List[PGroupOut]


class PUserPass(PUserBase):
    password: str = Field(..., regex=PASSWORD_POLICY)
    admin: bool
    groups_ids: List[int]
    
class PUserCurrent(PUserBase):
    admin: bool
    uuid: str


class PUserSalt(PUserPass):
    salt: str
    uuid: str

class PUserScope(PUserSalt):
    scopes: str


class PUserStatus(PUserBase):
    disabled: bool = Field("False")

class PUserEdit(BaseModel):
    admin: bool
    groups_ids: List[int]

class PUserChangePass(BaseModel):
    new_password: str = Field(regex=PASSWORD_POLICY)
    old_password: str = Field(regex=PASSWORD_POLICY)
