import datetime
from fastapi import FastAPI, Header, HTTPException
from pydantic import BaseModel, Field
from jose import jwt

JWT_SECRET = "supersecret"
ALGORITHM = "HS256"


class Body(BaseModel):
    model_config = {"populate_by_name": True}
    message: str
    to: str
    sender: str = Field(alias="from")
    timeToLiveSec: int


app = FastAPI()


def create_jwt(data: dict, seconds: int = 300):
    payload = data.copy()
    expire = datetime.datetime.now(datetime.timezone.utc) + datetime.timedelta(
        seconds=seconds
    )
    payload.update({"exp": expire})
    return jwt.encode(payload, JWT_SECRET, algorithm=ALGORITHM)


@app.post("/DevOps")
async def respond(body: Body, x_api_key: str = Header()):
    if x_api_key != "1":
        raise HTTPException(status_code=403, detail="forbidden")
    data = body.model_dump(by_alias=True)

    token = create_jwt(data, data["timeToLiveSec"])
    return {
        "message": f"Hello {data["from"]} your message will be sent",
        "token": token,
    }
