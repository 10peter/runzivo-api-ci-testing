# Runzivo API CI Testing Environment

A hands-on DevOps project demonstrating automated API testing and Docker container lifecycle management using isolated Runzivo Sandboxes.

## Project Overview

This project simulates a lightweight Continuous Integration (CI) workflow. A Python Flask API is containerized with Docker, tested using Pytest, and managed through Bash automation inside a Runzivo sandbox.

The goal is to demonstrate how ephemeral development environments can support repeatable application testing without maintaining permanent infrastructure.

## Technologies Used

- **Runzivo Sandboxes:** Isolated Linux testing environment
- **Python & Flask:** REST API development
- **Docker:** Application containerization
- **Pytest:** Automated API testing
- **Bash:** CI workflow automation
- **Git & GitHub:** Version control and source code management

## Project Architecture

```text
Runzivo Sandbox
      |
      v
Bash CI Script (ci-test.sh)
      |
      v
Build Docker Image
      |
      v
Start Flask Container
      |
      v
Check API Health
      |
      v
Execute Pytest Tests
      |
      v
Generate Test Report
      |
      v
Remove Test Container
```

## API Endpoints

| Endpoint | Description |
|---|---|
| `/health` | Returns the application's health status |
| `/status` | Returns application and environment information |

## Project Structure

```text
api-ci-testing/
├── app.py
├── Dockerfile
├── requirements.txt
├── test_api.py
├── ci-test.sh
├── test-results.xml
├── .gitignore
└── README.md
```

## Running the Project

**Prerequisites:** Linux, Python 3, Docker Engine, and network access for downloading dependencies.

### 1. Clone the repository

```bash
git clone https://github.com/10peter/runzivo-api-ci-testing.git
cd runzivo-api-ci-testing
```

### 2. Create a Python virtual environment

```bash
python3 -m venv .venv
source .venv/bin/activate
```

### 3. Install testing dependencies

```bash
pip install pytest requests
```

### 4. Execute the automated CI workflow

```bash
chmod +x ci-test.sh
./ci-test.sh
```

The Bash script automatically builds the Docker image, starts the Flask container, performs health checks, executes automated tests, generates a test report, and removes the test container.

**Note:** The workflow uses Docker host networking because Docker's default bridge networking encountered an `iptables` limitation in the tested Runzivo sandbox. The script also uses `sudo docker`, so appropriate Docker permissions are required.

## Testing

The automated test suite validates:

- HTTP 200 response from the `/health` endpoint
- Correct application health status
- HTTP 200 response from the `/status` endpoint
- Expected application metadata

Test results are exported to `test-results.xml` in JUnit XML format.

## Key Engineering Learnings

- Provisioning isolated development environments
- Building and running Docker containers
- Troubleshooting Linux container networking issues
- Automating API tests with Pytest
- Writing Bash scripts for repeatable CI workflows
- Managing temporary infrastructure and cleanup

## Future Improvements

- Integrate GitHub Actions for automatic test execution
- Add negative testing and API failure scenarios
- Introduce code quality and security scanning
- Automate Runzivo sandbox provisioning and deletion
- Publish Docker images to a container registry

## Author

GitHub: [@10peter](https://github.com/10peter)
