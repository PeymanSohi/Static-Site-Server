# Static Site Deployment with Nginx and rsync

## 📌 Project Goal
This project is designed to help me understand how to:
- Set up a basic web server using **Nginx**
- Serve a **static website**
- Use **rsync** to deploy updates to the remote server

---

## ✅ Requirements & Steps

### 1. Provision a Remote Linux Server
- Provider: _e.g., DigitalOcean / AWS EC2_
- OS: _Ubuntu 22.04_
- Ensured SSH access is working.

### 2. Installed Nginx
```bash
sudo apt update
sudo apt install nginx -y
