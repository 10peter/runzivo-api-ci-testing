import requests

BASE_URL = "http://127.0.0.1:5000"


def test_health_endpoint():
    response = requests.get(f"{BASE_URL}/health", timeout=5)

    assert response.status_code == 200
    assert response.json()["status"] == "healthy"


def test_status_endpoint():
    response = requests.get(f"{BASE_URL}/status", timeout=5)

    assert response.status_code == 200

    data = response.json()

    assert data["application"] == "runzivo-api"
    assert data["environment"] == "sandbox"
    assert data["status"] == "running"
