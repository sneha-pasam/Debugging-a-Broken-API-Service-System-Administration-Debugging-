#!/usr/bin/env bash
set -euo pipefail
echo "Installing test dependencies (inside CI / runner)"
python -m pip install -r requirements.txt
echo "Running tests..."
pytest -q
