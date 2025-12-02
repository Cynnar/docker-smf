# Simple Machines Forum (SMF) Docker Image

A modern, lightweight, and self-updating Docker image for [Simple Machines Forum (SMF)](https://www.simplemachines.org/) running on **PHP 8.2** and **Apache**.

Since SMF does not provide an official Docker image, this repository automates the build process to ensure a secure, up-to-date environment for SMF 2.1.x.

## 🚀 Features

* **Base:** Official `php:8.2-apache` image.
* **Extensions:** Pre-installed dependencies required by SMF:
    * `gd` (Image processing)
    * `mysqli` (Database connection)
    * `fileinfo` (File uploads)
    * `zip` (Package manager)
* **Apache Config:** `mod_rewrite` enabled by default (for SEO URLs).
* **Auto-Install:** On the first run, if the volume is empty, the container automatically downloads and extracts the latest SMF 2.1.4 install package.

## 🐳 Quick Start (Docker Compose)

Create a `docker-compose.yml` file:

```yaml
version: '3'

services:
  app:
    image: your_dockerhub_username/smf:latest
    container_name: smf_forum
    restart: unless-stopped
    ports:
      - "8080:80"
    volumes:
      - ./html:/var/www/html
    environment:
      - SMF_VERSION=2-1-4
    networks:
      - smf-net

  db:
    image: mariadb:10.6
    container_name: smf_db
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: secure_root_password
      MYSQL_DATABASE: smf
      MYSQL_USER: smf_user
      MYSQL_PASSWORD: secure_user_password
    volumes:
      - ./db:/var/lib/mysql
    networks:
      - smf-net

networks:
  smf-net:

Then Run:

docker compose up -d