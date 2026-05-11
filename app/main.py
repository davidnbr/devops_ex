import datetime
import os
import secrets

from fastapi import FastAPI, Header, HTTPException
from jose import jwt
from pydantic import BaseModel, Field

JWT_SECRET: str = os.environ["JWT_SECRET"]
API_KEY: str = os.environ["API_KEY"]
ALGORITHM = "HS256"


class Body(BaseModel):
    model_config = {"populate_by_name": True}
    message: str
    to: str
    sender: str = Field(alias="from")
    timeToLiveSec: int


app = FastAPI()


def create_jwt(data: dict, seconds: int = 300) -> str:
    payload = data.copy()
    expire = datetime.datetime.now(datetime.timezone.utc) + datetime.timedelta(
        seconds=seconds
    )
    payload.update({"exp": expire})
    return jwt.encode(payload, JWT_SECRET, algorithm=ALGORITHM)


@app.post("/DevOps")
async def respond(body: Body, x_api_key: str = Header()) -> dict:
    if not secrets.compare_digest(x_api_key, API_KEY):
        raise HTTPException(status_code=403, detail="forbidden")

    token = create_jwt(body.model_dump(by_alias=True), body.timeToLiveSec)
    return {
        "message": f"Hello {body.sender} your message will be sent",
        "token": token,
    }
