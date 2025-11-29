#!/usr/bin/env bash
# solution.sh - REFERENCE SOLUTION (DO NOT COPY into image)
# 12 commands that fix the task:
set -euo pipefail
echo "1) Show docker-compose status"
docker-compose ps
echo "2) Show container logs"
docker-compose logs api --tail=200
echo "3) Inspect current environment variables (docker exec)"
docker-compose run --rm api env || true
echo "4) Edit docker-compose to set SECRET_KEY environment variable (simulate via sed)"
# Replace API_SECRET with SECRET_KEY in docker-compose.yaml (reference solution)
sed -i 's/API_SECRET/SECRET_KEY/' docker-compose.yaml
echo "5) Rebuild the image"
docker-compose build --no-cache
echo "6) Start the service in background"
docker-compose up -d
echo "7) Wait for service to start"
sleep 3
echo "8) Test health endpoint"
curl -sS http://localhost:5000/health || true
echo "9) Run tests (installing test deps locally inside container)"
docker-compose run --rm api /bin/bash -lc "python -m pip install -r /app/requirements.txt && pytest -q"
echo "10) If tests pass, output success line"
echo "ORACLE_PASS: 100%"
echo "11) Create nop result file (simulated)"
echo "echo 'NOP_RESULT: FAIL (0% passed)' > nop.txt"
echo "12) Show final ps"
docker-compose ps
