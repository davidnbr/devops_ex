from fastapi.testclient import TestClient
from jose import jwt

from app.main import ALGORITHM, JWT_SECRET, app, create_jwt

client = TestClient(app)


def test_devops_endpoint_accepts_valid_api_key_and_jwt() -> None:
    request_token = create_jwt({"sub": "test-client"})

    response = client.post(
        "/DevOps/",
        headers={
            "X-Parse-REST-API-Key": "test-api-key",
            "X-JWT-Kwy": request_token,
        },
        json={
            "message": "deploy",
            "to": "team",
            "from": "David",
            "timeToLiveSec": 300,
        },
    )

    assert response.status_code == 200
    payload = response.json()
    assert payload["message"] == "Hello David your message will be sent"

    decoded_token = jwt.decode(payload["token"], JWT_SECRET, algorithms=[ALGORITHM])
    assert decoded_token["message"] == "deploy"
    assert decoded_token["from"] == "David"


def test_devops_endpoint_rejects_invalid_api_key() -> None:
    response = client.post(
        "/DevOps/",
        headers={
            "X-Parse-REST-API-Key": "wrong-api-key",
            "X-JWT-Kwy": create_jwt({"sub": "test-client"}),
        },
        json={
            "message": "deploy",
            "to": "team",
            "from": "David",
            "timeToLiveSec": 300,
        },
    )

    assert response.status_code == 403
    assert response.json() == {"detail": "ERROR"}
