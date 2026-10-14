# Secure SSH Tunneling & Local Port Forwarding 🔒🌐

A hands-on networking and cybersecurity experiment focused on creating an encrypted tunnel between a local environment (WSL Ubuntu) and an isolated private service running inside an AWS EC2 cloud instance.

##  Project Overview
In real-world production environments, critical infrastructure like databases (MySQL, MongoDB) or admin panels are kept strictly **private** and bound to `127.0.0.1` so that hackers on the public internet cannot discover or attack them. 

The goal of this project was to learn how a developer can securely bypass these restrictions using **Local Port Forwarding (`-L`)** via an SSH tunnel, pulling the remote hidden service directly into a local laptop browser without opening any public firewall ports.

---

##  Infrastructure & Core Concepts Learned

### 1. Isolated Private Service Setup
* Deployed a lightweight, background **Python Web Server** inside the remote AWS Linux instance listening on port `8080`.
* Bound the service strictly to the loopback address (`--bind 127.0.0.1`). This ensured the service was completely invisible to the public internet, ignoring external requests to the server's Public IP or DuckDNS address.

### 2. Encryption Tunnel Creation (Port Forwarding)
* Opened a second local terminal instance on the laptop to establish the forwarding pipeline.
* Used the **`-L` (Local Forwarding)** flag to map an available local port on the laptop (e.g., `8888`) through an encrypted tunnel directly into the remote server's private port `8080`.
* Utilized the **`-N`** flag to keep the tunnel quietly listening in the background without opening an interactive shell session.

### 3. Verification & Traffic Inspection
* Probed the infrastructure path from the local terminal using network scanning utilities (`nc -zv`) to confirm open route availability.
* Successfully opened a local browser page (`http://localhost:8888`) on the laptop, securely rendering the isolated files hosted deep inside the AWS cloud environment.

---

## 📋 Commands Executed

```bash
# === REMOTE SIDE: Inside the AWS Linux Server ===
# Spin up a completely private python server in the background
python3 -m http.server 8080 --bind 127.0.0.1 &

# Verify the server is working and responding internally
curl http://127.0.0.1:8080

# === LOCAL SIDE: Inside the Laptop Ubuntu WSL Terminal ===
# Step A: Run a network probe to ensure Port 22 path is completely open
nc -zv YOUR_AWS_PUBLIC_IP 22

# Step B: Establish the secure Local Port Forwarding tunnel
ssh -i "pree-key.pem" -L 8888:127.0.0.1:8080 ubuntu@YOUR_AWS_PUBLIC_IP -N
```
