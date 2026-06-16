# proxy/README.md

# Proxy Stack

## Purpose

The Proxy stack provides the central ingress layer for the homelab.

It is responsible for:

* Reverse proxying HTTP traffic
* Routing requests to containers in other stacks
* Publishing services through Cloudflare Tunnel
* Centralized middleware management
* Secure access to administrative services
* Providing a single entry point into the homelab

This stack should be deployed before all other stacks.

---

## Containers

### Traefik

Purpose:

* Reverse proxy
* Service discovery
* Request routing
* Middleware processing
* Dashboard

Image:

* Traefik v3

---

### Cloudflared

Purpose:

* Maintains an outbound connection to Cloudflare
* Publishes services without port forwarding
* Provides secure ingress

Image:

* cloudflare/cloudflared

---

## Dependencies

Required:

* Docker Engine
* Docker Compose
* Cloudflare Tunnel
* Cloudflare DNS

Optional:

* Cloudflare Access
* Tailscale

---

## Networks

### proxy

Shared external Docker network.

Used by:

* Traefik
* Cloudflared
* Websites
* Monitoring services
* Security services
* Future application stacks

Create manually:

```bash
docker network create proxy
```

---

## Volumes

### Traefik

Configuration:

```text
data/traefik
```

Dynamic configuration:

```text
data/traefik/dynamic
```

Logs:

```text
logs/traefik
```

---

### Cloudflared

Logs:

```text
logs/cloudflared
```

---

## Environment Variables

Examples only.

Global:

```env
DOMAIN=dylanskelly.com
TZ=Australia/Sydney
PROXY_NETWORK=proxy
RESTART_POLICY=unless-stopped
```

Stack:

```env
TRAEFIK_CONTAINER_NAME=traefik
CLOUDFLARED_CONTAINER_NAME=cloudflared

TRAEFIK_HTTP_PORT=80
TRAEFIK_DASHBOARD_HOST=<dashboard-hostname>
```

---

## Deployment

Validate:

```bash
cd stacks/proxy

docker compose \
  --env-file ../../.env \
  --env-file .env \
  config
```

Deploy:

```bash
docker compose \
  --env-file ../../.env \
  --env-file .env \
  up -d
```

Verify:

```bash
docker ps
```

---

## Validation

Check containers:

```bash
docker ps
```

Check Traefik:

```bash
curl http://localhost
```

Check logs:

```bash
docker logs traefik
docker logs cloudflared
```

---

## Updating

Pull images:

```bash
docker compose pull
```

Recreate containers:

```bash
docker compose up -d
```

Verify:

```bash
docker ps
```

---

## Future Improvements

Planned enhancements:

* Cloudflare Access protection
* HTTPS entrypoint
* Advanced middleware chains
* Internal service segregation
* Dashboard hardening
* Metrics integration
* Grafana monitoring

---

## Related Documentation

See:

```text
../../README.md
```
