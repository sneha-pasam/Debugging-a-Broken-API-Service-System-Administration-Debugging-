# Navigate to project folder
cd "C:\Users\Sneha\Downloads\sneha_pasam_29-11-2025\task"

# Activate virtual environment
.\venv\Scripts\Activate.ps1

# Set environment variable
$env:SECRET_KEY="mysecret"

# Start Flask server in a separate process
Start-Process python .\app\app.py

# Give the server some time to start
Start-Sleep -Seconds 5

# Test endpoints
Write-Host "`nTesting /health endpoint:"
curl "http://127.0.0.1:5000/health"

Write-Host "`nTesting /echo endpoint:"
curl "http://127.0.0.1:5000/echo?msg=hello"
