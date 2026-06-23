# PHASE_1_FOUNDATION.md

# Phase 1 – Foundation

## Purpose

Phase 1 establishes secure ingress into the Homelab environment.

This phase introduces external connectivity, reverse proxy services, and web hosting.

---

# Objectives

The objectives of this phase are:

* Implement secure external access
* Deploy reverse proxy infrastructure
* Establish traffic routing
* Deploy initial web services
* Validate DNS and routing workflows

---

# Components

## Cloudflare Tunnel

Responsibilities:

* Secure inbound connectivity
* Eliminate inbound port forwarding
* Provide external access path

---

## Traefik

Responsibilities:

* Reverse proxy
* Service discovery
* HTTP routing
* Middleware management

---

## Nginx

Responsibilities:

* Website hosting
* Static content delivery
* Project hosting

---

# Service Flow

```text
Internet
    │
    ▼
Cloudflare
    │
    ▼
Cloudflare Tunnel
    │
    ▼
Traefik
    │
    ▼
Nginx Websites
```

---

# Services Introduced

## Proxy Stack

Components:

* Traefik
* Cloudflared

---

## HTTP Stack

Components:

* Portfolio Website
* Project Websites

---

# Operational Benefits

This phase introduces:

* Centralised routing
* Reduced attack surface
* Simplified service publication
* Consistent ingress architecture

---

# Success Criteria

Phase 1 is complete when:

* External traffic reaches Traefik
* Routing functions correctly
* Websites are accessible
* DNS resolution works
* Documentation is updated

---

# Skills Demonstrated

* Reverse Proxy Administration
* DNS Concepts
* Cloud Networking
* Docker Networking
* HTTP Routing
* Service Publication
