import uvicorn
import os

from fastapi.middleware.httpsredirect import HTTPSRedirectMiddleware
from fastapi.middleware.trustedhost import TrustedHostMiddleware
from tortoise.contrib.fastapi import register_tortoise
from fastapi.middleware.cors import CORSMiddleware
from fastapi import FastAPI, Request
from tortoise import Tortoise
from sqlalchemy import create_engine

abspath = os.path.abspath(__file__)
dname = os.path.dirname(abspath)
os.chdir(dname)

from routers import users, perms, displays, groups, streams, events, topics, files
from config.parameters import (
    ALLOWED_HOSTS,
    CREATE_DB_URL, 
    ORIGINS, 
    MODEL_PATHS, 
    KEY_FILE, 
    CERT_FILE, 
    API_PORT, 
    API_IP, 
    ALLOWED_METHODS, 
    ALLOWED_HOSTS,
    DB_URL
)


app = FastAPI()


"""
# Database Initialisation
"""

engine = create_engine(CREATE_DB_URL)
engine.execute('CREATE SCHEMA IF NOT EXISTS viewcast')

Tortoise.init_models(MODEL_PATHS, 'models')
register_tortoise(
    app,
    db_url=DB_URL,
    modules={"models": MODEL_PATHS},
    generate_schemas=True,
    add_exception_handlers=True,
)


"""
# API & Routers Initialisation
"""
app.include_router(displays.router)
app.include_router(groups.router)
app.include_router(streams.router)
app.include_router(events.router)
app.include_router(topics.router)
app.include_router(files.router)
app.include_router(users.router)
app.include_router(perms.router)


@app.get("/")
def root():
    return {"Welcome": 
            "You can access API documentation through /docs"}


"""
# Middleware Initialisation
"""
#app.add_middleware(HTTPSRedirectMiddleware)
# app.add_middleware(
#     TrustedHostMiddleware,
#     allowed_hosts=ALLOWED_HOSTS,
#)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=ALLOWED_METHODS,
    allow_headers=["*"],
)

@app.middleware("http")
async def request_validator(request: Request, call_next):
    # We can filter either request or response 
    # before there are processed by the routers
    response = await call_next(request)
    return response


"""
# Main
"""
if __name__ == "__main__":
    uvicorn.run("main:app", host=API_IP, 
                            port=API_PORT, 
                            reload=True,
                            # ssl_keyfile= KEY_FILE,
                            # ssl_certfile= CERT_FILE
                            )
