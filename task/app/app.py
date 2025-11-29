from flask import Flask, jsonify, request
import os

app = Flask(__name__)

# Bug: expects SECRET_KEY but docker-compose sets API_SECRET.
# Also, a deliberate logic bug: health route raises exception when SECRET_KEY missing.
SECRET_KEY = os.environ.get("SECRET_KEY")

@app.route("/health")
def health():
    # If secret key not set, raise a server error (intentional for task)
    if not SECRET_KEY:
        raise RuntimeError("Missing SECRET_KEY")
    return jsonify({"status": "ok", "secret_present": True})

@app.route("/echo")
def echo():
    msg = request.args.get("msg", "")
    return jsonify({"echo": msg})


if __name__ == "__main__":
    # Runs on port 5000 and listens on all interfaces
    app.run(host="0.0.0.0", port=5000, debug=True)
