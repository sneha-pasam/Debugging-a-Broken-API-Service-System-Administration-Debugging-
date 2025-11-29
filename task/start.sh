#!/usr/bin/env bash
# Start script used by Docker ENTRYPOINT
set -euo pipefail
export FLASK_APP=app.app
# Intentional wrong env var reference (API_SECRET vs SECRET_KEY) in app to create a bug candidate must fix
python -u -m flask run --host=0.0.0.0 --port=5000
