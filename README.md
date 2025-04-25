```markdown
# 🌐 Static Website Deployment with Nginx and rsync

## 📘 Overview

The purpose of this project is to build a solid foundational understanding of:

- Setting up a remote Linux server
- Installing and configuring Nginx to serve a **static website**
- Using **rsync** to automate deployments of local files to the remote server

This project demonstrates how to serve a static site and keep it up-to-date using simple tools like Nginx and bash.

---

## ✅ Project Goals

By the end of this project, you should be able to:

- Set up and access a remote Linux server via SSH
- Install and configure Nginx
- Serve a basic HTML/CSS-based static website
- Use `rsync` to deploy the website from your local machine to the server
- Optionally, configure a domain name for your site

---

## 🖥️ Prerequisites

- A remote Linux server (e.g., Ubuntu 22.04 on DigitalOcean, AWS EC2, etc.)
- SSH access to the server
- A local Unix-like machine (Linux/macOS or WSL on Windows)
- Basic knowledge of HTML/CSS and the Linux command line

---

## 📂 Project Structure

```bash
nginx-static-site-deploy/
├── static-site/
│   ├── index.html         # HTML file for the webpage
│   ├── styles.css         # Styles for the webpage
│   └── assets/
│       └── image.jpg      # An image displayed on the site
├── deploy.sh              # Script to deploy the static site using rsync
└── README.md              # This documentation
```

---

## 🚀 Steps to Complete the Project

### 1. Provision a Remote Linux Server

You can use any cloud provider like:

- [DigitalOcean](https://www.digitalocean.com)
- [AWS EC2](https://aws.amazon.com/ec2/)
- [Hetzner](https://www.hetzner.com/)
- [Vultr](https://www.vultr.com/)

Once the server is created, ensure it is accessible via SSH:

```bash
ssh user@your.server.ip
```

---

### 2. Install and Configure Nginx

Login to the server:

```bash
ssh user@your.server.ip
```

Then, install Nginx:

```bash
sudo apt update
sudo apt install nginx -y
```

Allow HTTP traffic through the firewall:

```bash
sudo ufw allow 'Nginx Full'
```

---

### 3. Create a Simple Static Website

In your project’s `static-site/` directory, create the following:

#### `index.html`

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Static Site</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Welcome to My Static Site!</h1>
    <p>This site is served using Nginx and deployed with rsync.</p>
    <img src="assets/image.jpg" alt="Sample Image">
</body>
</html>
```

#### `styles.css`

```css
body {
    font-family: Arial, sans-serif;
    background-color: #f9f9f9;
    text-align: center;
    padding: 40px;
}

h1 {
    color: #007acc;
}
```

#### `assets/image.jpg`

Add any image you like in this folder and reference it in your HTML.

---

### 4. Configure Nginx to Serve the Static Site

On your server, create the directory for your static site:

```bash
sudo mkdir -p /var/www/html/static-site
```

You’ll use rsync later to push your site there.

Then edit the default Nginx site config:

```bash
sudo nano /etc/nginx/sites-available/default
```

Update it like this:

```nginx
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html/static-site;
    index index.html;

    server_name _;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

Test the config and reload:

```bash
sudo nginx -t
sudo systemctl reload nginx
```

---

### 5. Deploy the Static Site with `rsync`

Create the `deploy.sh` script in the root of your project:

#### `deploy.sh`

```bash
#!/bin/bash

# Configuration
USER=username               # <-- Replace with your SSH username
HOST=your.server.ip         # <-- Replace with your server's IP address
REMOTE_DIR=/var/www/html/static-site

# Deploy using rsync
echo "Deploying static site to $USER@$HOST..."
rsync -avz --delete ./static-site/ $USER@$HOST:$REMOTE_DIR
echo "Deployment complete!"
```

Make it executable:

```bash
chmod +x deploy.sh
```

Run the script to deploy:

```bash
./deploy.sh
```

---

### 6. Optional: Use a Domain Name

If you have a domain name, point its A record to your server’s IP address. Then update the `server_name` in the Nginx config:

```nginx
server_name yourdomain.com www.yourdomain.com;
```

Reload Nginx:

```bash
sudo systemctl reload nginx
```

Now your site is accessible via `http://yourdomain.com`.

---

## 🎉 Outcome

After completing this project:

- Your static site is live and accessible via your server’s IP or domain.
- You can update your site by editing local files and re-running `./deploy.sh`.
- You’ve learned the basics of:
  - Nginx configuration
  - Static site hosting
  - Remote file deployment with `rsync`

---

## 🛡️ Notes & Tips

- Keep your `deploy.sh` script private and never expose SSH credentials.
- Do **not** commit any private keys or secrets to this repo.
- If you're using a VPS, take regular snapshots or backups.

---

## 📚 References

- [Nginx Beginner Guide](https://nginx.org/en/docs/beginners_guide.html)
- [rsync Manual](https://linux.die.net/man/1/rsync)
- [DigitalOcean SSH Key Guide](https://www.digitalocean.com/docs/ssh/create-ssh-keys/)

---

