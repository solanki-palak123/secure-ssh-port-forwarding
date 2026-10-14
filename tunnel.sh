#!/bin/bash

# DevOps Automation Script: Secure Local Port Forwarding SSH Tunnel
# ====================================================================

# Configuration Variables
KEY_FILE="pree-key.pem"
AWS_USER="ubuntu"
AWS_PUBLIC_IP="13.238.217.87"
LOCAL_LISTEN_PORT="8888"
REMOTE_PRIVATE_PORT="8080"

echo "====================================================="
echo "Initiating Secure Encrypted SSH Tunnel to AWS..."
echo "Mapping local port $LOCAL_LISTEN_PORT -> AWS private port $REMOTE_PRIVATE_PORT"
echo "====================================================="

# Execute the local port forwarding tunnel command
ssh -i "$KEY_FILE" -L ${LOCAL_LISTEN_PORT}:127.0.0.1:${REMOTE_PRIVATE_PORT} ${AWS_USER}@${AWS_PUBLIC_IP} -N
