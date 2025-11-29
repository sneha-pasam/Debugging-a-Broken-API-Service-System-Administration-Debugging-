# Debug: Broken API Service (Terminal-Bench Task)

## Overview
This task provides a small Flask API that intentionally fails the `/health` endpoint due to environment misconfiguration.
Your goal is to diagnose and fix the containerized service so that tests pass.

## How to run locally (developer / reviewer)
1. Build image:
   docker build -t debug-broken-api:latest .
2. Run with docker-compose:
   docker-compose up --build -d
3. Run tests (inside host):
   ./run-tests.sh

## Notes for graders
- solution.sh contains the reference fix and SHOULD NOT be included in the Docker image.
- .dockerignore ensures solution.sh and tests are not baked into the image.
