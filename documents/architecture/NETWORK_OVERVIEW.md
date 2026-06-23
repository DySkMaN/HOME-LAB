# NETWORK_OVERVIEW.md

## Purpose

This document describes the logical network architecture used throughout the Homelab environment.

The design separates external access, service routing, application traffic, and management functions.

---

# High-Level Traffic Flow

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
    ├── HTTP Services
    ├── Monitoring Services
    ├── Security Services
    ├── Storage Services
    └── Media Services
```

---

# Service Categories

## Public Services

Services intended for public access.

Examples:

* Portfolio Website
* Project Demonstration Sites

---

## Protected Public Services

Internet-accessible services requiring authentication.

Examples:

* Nextcloud
* Vaultwarden

---

## Internal Services

Restricted administrative services.

Examples:

* Grafana
* Prometheus
* Traefik Dashboard
* VPN Management Interfaces

---

# Docker Network Design

The environment uses dedicated Docker networks to separate service communication.

## Proxy Network

Purpose:

Shared routing network used by Traefik.

Connected services:

* Traefik
* Cloudflare Tunnel
* Websites
* Nextcloud
* Vaultwarden
* Grafana
* Plex

---

## Monitoring Network

Purpose:

Monitoring traffic only.

Connected services:

* Grafana
* Prometheus
* Node Exporter

---

## Application Networks

Application-specific networks isolate backend communication.

Examples:

* Storage services
* Database services
* Media services

---

# Remote Access

Remote administration is performed using secure encrypted channels.

Examples:

* VPN
* Tailscale
* SSH

Administrative services are not intended for unrestricted public exposure.

---

# DNS and Routing

External DNS records point to Cloudflare.

Cloudflare Tunnel forwards requests to Traefik.

Traefik performs host-based routing to the appropriate backend service.

---

# Monitoring Traffic

Monitoring services collect:

* CPU metrics
* Memory metrics
* Disk metrics
* Container metrics
* Network metrics

Traffic remains internal to the monitoring network.

---

# Future Network Expansion

Planned additions include:

* Dedicated NAS segment
* Separate management VLAN
* Wireless infrastructure management
* Guest network isolation
* IoT segmentation

---

# Design Goals

The network architecture is designed to provide:

* Security
* Simplicity
* Scalability
* Service isolation
* Easy troubleshooting
* Clear traffic visibility
