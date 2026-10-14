#!/bin/bash

# ====================================================================
# DevOps Automation Script: Spin up isolated internal server on AWS
# ====================================================================

PORT="8080"
BIND_IP="127.0.0.1"

echo "🔒 Starting an isolated private service on Port $PORT..."

# Run the python module server in the background using the '&' operator
python3 -m http.server $PORT --bind $BIND_IP &

echo "✅ Service successfully pushed to the background!"
echo "📡 Use 'curl http://127.0.0.1:$PORT' internally to verify status."
