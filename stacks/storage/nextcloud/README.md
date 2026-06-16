# Nextcloud Stack

## Purpose

This stack provides self-hosted cloud storage, file sharing, synchronisation, collaboration, and personal data management services.

The deployment is designed for operation behind Traefik and Cloudflare Tunnel, providing secure remote access without directly exposing services to the internet.

Key capabilities:

* File storage and synchronisation
* WebDAV support
* Mobile and desktop client support
* User and group management
* Calendar and contacts
* File sharing
* Background job processing
* Reverse proxy integration through Traefik

---

## Containers

| Container       | Purpose                      |
| --------------- | ---------------------------- |
| nextcloud       | Main Nextcloud application   |
| nextcloud-db    | PostgreSQL database          |
| nextcloud-redis | Redis cache and file locking |
| nextcloud-cron  | Scheduled background jobs    |

---

## Dependencies

This stack depends on:

* Docker Engine
* Docker Compose
* PostgreSQL
* Redis
* Traefik reverse proxy
* Cloudflare Tunnel
* Shared proxy Docker network

---

## Networks

### proxy

Shared reverse proxy network used by Traefik.

### nextcloud_internal

Private internal network used for communication between:

* Nextcloud
* PostgreSQL
* Redis
* Cron

Database and Redis are not externally accessible.

---

## Volumes

### Application Data

Stores:

* Nextcloud application
* Configuration
* Installed apps

### Database Data

Stores:

* PostgreSQL database

### Redis Data

Stores:

* Redis persistence

### User Data

Stores:

* Uploaded files
* User content
* Shares
* Metadata

---

## Environment Variables

### General

```env
TZ=Australia/Sydney
RESTART_POLICY=unless-stopped
```

### Nextcloud

```env
NEXTCLOUD_CONTAINER_NAME=nextcloud
NEXTCLOUD_HOST=cloud.example.com
NEXTCLOUD_ADMIN_USER=admin
```

### Database

```env
NEXTCLOUD_DB_NAME=nextcloud
NEXTCLOUD_DB_USER=nextcloud
```

### Containers

```env
NEXTCLOUD_DB_CONTAINER_NAME=nextcloud-db
NEXTCLOUD_REDIS_CONTAINER_NAME=nextcloud-redis
NEXTCLOUD_CRON_CONTAINER_NAME=nextcloud-cron
```

---

## Deployment

Validate configuration:

```bash
docker compose \
  --env-file ../../../.env \
  --env-file .env \
  config
```

Deploy:

```bash
docker compose \
  --env-file ../../../.env \
  --env-file .env \
  up -d
```

---

## Validation

Verify containers:

```bash
docker ps
```

Check logs:

```bash
docker logs nextcloud
docker logs nextcloud-db
docker logs nextcloud-redis
```

Verify routing:

```bash
curl -I https://cloud.example.com
```

Verify background jobs:

```bash
docker exec -u www-data nextcloud php occ background:cron
```

---

## Updating

Pull updated images:

```bash
docker compose pull
```

Recreate containers:

```bash
docker compose up -d
```

Check status:

```bash
docker ps
```

Review application health:

```bash
docker exec -u www-data nextcloud php occ status
```

---

## Future Improvements

* Cloudflare Access integration
* Nextcloud Office
* External storage integration
* Automated backup validation
* Monitoring integration
* Alerting integration
* MFA enforcement
* SMTP notifications
* Automated disaster recovery testing

---

## Related Documentation

* ../../README.md
* Proxy Stack Documentation
* Monitoring Stack Documentation
* Backup Procedures
* Disaster Recovery Procedures
