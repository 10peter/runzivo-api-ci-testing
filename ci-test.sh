
#!/usr/bin/env bash

set -Eeuo pipefail

IMAGE_NAME="runzivo-api:v1"
CONTAINER_NAME="runzivo-api"
REPORT_FILE="test-results.xml"

cleanup() {
    echo "Cleaning up test container..."
    sudo docker rm -f "$CONTAINER_NAME" >/dev/null 2>&1 || true
}

trap cleanup EXIT

echo "===== Starting Runzivo CI Testing ====="

# Step 1: Remove any existing test container
cleanup

# Step 2: Build the Docker image
echo "Building Docker image..."
sudo docker build --network=host -t "$IMAGE_NAME" .

# Step 3: Start the application container
echo "Starting Flask container..."
sudo docker run -d \
    --network=host \
    --name "$CONTAINER_NAME" \
    "$IMAGE_NAME"

# Step 4: Wait until the API is ready
echo "Waiting for API health check..."

READY=false

for attempt in {1..30}; do
    if curl --silent --fail \
        http://127.0.0.1:5000/health >/dev/null; then
        READY=true
        break
    fi
    sleep 1
done

if [ "$READY" != "true" ]; then
    echo "ERROR: API health check failed."
    sudo docker logs "$CONTAINER_NAME"
    exit 1
fi

echo "API is healthy."

# Step 5: Run automated tests and generate report
echo "Running Pytest..."
python -m pytest -v test_api.py \
    --junitxml="$REPORT_FILE"

echo "===== CI TESTING PASSED ====="
echo "Report saved to: $REPORT_FILE"

