# Matrix + Element Self-Hosted Messenger

Simple deployment of a **private Matrix messenger server** with:

- **Matrix Synapse** – the core server
- **Element** – modern web client
- **Nginx Proxy Manager** – SSL and reverse proxy management

This repository contains a ready-to-use configuration to quickly deploy your own **secure and federated Matrix server** using Docker.

---

# 📖 Full Installation Guides

Detailed step-by-step instructions are available here:

🇬🇧 English guide  
https://www.lifeblog.pro/eng/how-to-set-up-your-own-secure-messenger

🇷🇺 Русская версия  
https://www.lifeblog.pro/kak-razvernut-svoj-bezopasnyj-messendzher-matrix-element

The guides include:

- server preparation
- Docker installation
- Synapse configuration
- Nginx Proxy Manager setup
- SSL certificate automation
- federation testing
- user creation

---

# 🚀 Quick Overview

Basic installation workflow:

1. Clone the repository

```bash
git clone https://github.com/nikita-butakov/matrix_element.git
cd matrix_element
```

2. Edit the configuration

```bash
nano config.json
```

Replace `yourdomain.com` with your domain.

3. Generate Synapse configuration

```bash
docker run --rm -it \
  -e SYNAPSE_SERVER_NAME=yourdomain.com \
  -e SYNAPSE_REPORT_STATS=no \
  -v $(pwd)/synapse/data:/data \
  matrixdotorg/synapse:latest generate
```

4. Start services

```bash
docker compose up -d
```

5. Create the first user

```bash
docker compose exec synapse register_new_matrix_user \
-c /data/homeserver.yaml \
http://localhost:8008 \
-u admin \
-p strongpassword \
-a
```

---

# 🔐 Features

✔ Self-hosted Matrix server  
✔ End-to-end encryption (E2EE)  
✔ Federation with other Matrix servers  
✔ Web client included (Element)  
✔ Automatic SSL via Nginx Proxy Manager  
✔ Docker-based deployment  

---

# 🧩 Requirements

- VPS server (recommended **2GB RAM or more**)
- Debian / Ubuntu server
- Open ports:

```
80
81
443
22
8448
```

- Domain pointing to your server IP

---

# 📱 Clients

You can use the Element client on:

https://element.io/en/download

Available for:

- Web
- Android
- iOS
- Windows
- Linux
- macOS

---

# ⭐ If this project helped you

Consider giving the repository a star.
