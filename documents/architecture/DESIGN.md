# DESIGN.md

## Purpose

This document describes the overall design philosophy, architecture, and objectives of the Homelab platform.

The environment is designed to simulate a small-to-medium enterprise infrastructure while remaining practical for home use.

The platform serves multiple purposes:

* Systems Administration practice
* Linux administration
* Docker and container orchestration
* Network design
* Security hardening
* Monitoring and observability
* Backup and disaster recovery
* Technical documentation
* Portfolio development

---

# Design Principles

The platform is built around the following principles:

## Simplicity

Services should be easy to understand, maintain, rebuild, and troubleshoot.

Complexity is introduced only when it provides a clear operational benefit.

---

## Recoverability

Every service should be rebuildable from:

* Documentation
* Configuration files
* Backups
* Version-controlled infrastructure

A complete platform loss should be recoverable using documented procedures.

---

## Security by Default

Services are classified as:

* Public
* Protected Public
* Internal Only

Administrative interfaces should not be directly exposed to the Internet.

---

## Documentation First

Every service includes:

* README.md
* README_INTERNAL.md
* TROUBLESHOOTING.md

Operational procedures are documented before production deployment.

---

## Infrastructure as Documentation

The repository itself acts as operational documentation.

Infrastructure decisions, troubleshooting history, architecture diagrams, and recovery procedures are stored alongside deployment files.

---

# Platform Architecture

The environment consists of several logical layers.

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
Traefik Reverse Proxy
    │
    ├── Public Services
    ├── Protected Services
    └── Internal Services
```

---

# Core Infrastructure

## Proxy Layer

Responsibilities:

* Traffic routing
* Service discovery
* TLS management
* Reverse proxy services

Components:

* Traefik
* Cloudflare Tunnel

---

## Web Layer

Responsibilities:

* Static websites
* Project hosting
* Portfolio content

Components:

* Nginx
* Public websites

---

## Monitoring Layer

Responsibilities:

* Metrics collection
* System monitoring
* Capacity planning

Components:

* Prometheus
* Node Exporter
* Grafana

---

## Security Layer

Responsibilities:

* Credential management
* Secure remote access

Components:

* Vaultwarden
* VPN Service

---

## Storage Layer

Responsibilities:

* File storage
* Collaboration
* Backup targets

Components:

* Nextcloud

Future:

* NAS integration

---

## Media Layer

Responsibilities:

* Media management
* Content delivery

Components:

* Plex
* qBittorrent

---

# Operational Services

## Backup Services

Planned backup model:

* Daily backups
* Weekly backups
* Monthly off-site backups

---

## UPS Integration

Planned functionality:

* Automated safe shutdown
* Service stop sequencing
* Graceful host shutdown
* Automated startup recovery

---

# Future Growth

The architecture is intentionally modular.

Additional services can be deployed without redesigning the platform.

Examples:

* CrowdSec
* Wazuh
* Loki
* Uptime Kuma
* Home Assistant
* Git repositories
* CI/CD platforms

---

# Outcome

The platform is designed to demonstrate practical skills in:

* Linux Administration
* Docker
* Networking
* Security
* Monitoring
* Backup and Recovery
* Technical Documentation
* Infrastructure Operations
