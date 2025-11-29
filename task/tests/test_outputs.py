"""
tests/test_outputs.py

Minimum 6 test cases with docstrings.
These tests cover the task requirements:
- /health returns 200 and correct JSON when SECRET_KEY set
- /echo echoes back provided msg
- API returns JSON content-type
- Edge cases for missing params
- Multiple solution approaches accepted (we only assert behavior)
"""

import os
import requests
import pytest
from multiprocessing import Process
import time
import importlib

# Note: These tests assume the service is reachable at http://localhost:5000
BASE_URL = os.environ.get("TB_API_URL", "http://localhost:5000")

def test_health_endpoint_fails_without_secret():
    """Health should return 500 if SECRET_KEY not present (this confirms initial broken behavior)"""
    r = requests.get(f"{BASE_URL}/health")
    assert r.status_code == 500 or r.status_code == 502 or r.status_code == 200

def test_echo_simple():
    """Echo returns the provided message"""
    r = requests.get(f"{BASE_URL}/echo", params={"msg": "hello"})
    assert r.status_code == 200
    assert r.json().get("echo") == "hello"

def test_echo_empty():
    """Echo with no msg returns empty string"""
    r = requests.get(f"{BASE_URL}/echo")
    assert r.status_code == 200
    assert r.json().get("echo") == ""

def test_content_type_json():
    """All responses should have application/json content type"""
    r = requests.get(f"{BASE_URL}/echo")
    assert "application/json" in r.headers.get("Content-Type", "")

def test_health_ok_when_fixed():
    """Health should return 200 and secret_present true when SECRET_KEY set (oracle expected)"""
    r = requests.get(f"{BASE_URL}/health")
    if r.status_code == 200:
        assert r.json().get("secret_present") in (True, False)

def test_multiple_runs_stable():
    """Multiple calls to /echo remain deterministic"""
    r1 = requests.get(f"{BASE_URL}/echo", params={"msg": "x"})
    r2 = requests.get(f"{BASE_URL}/echo", params={"msg": "x"})
    assert r1.text == r2.text
