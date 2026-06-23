# documents/network-diagrams/FINAL_ARCHITECTURE.md

# Final Architecture

## Purpose

This document provides a high-level view of the target-state architecture for the Homelab platform.

The design reflects the planned environment after completion of all build phases.

---

# Logical Architecture

```text
                                      Internet
                                          │
                                          ▼
                                  Cloudflare Network
                                          │
                                          ▼
                                  Cloudflare Tunnel
                                          │
                                          ▼
                                      Traefik
                                          │
       ┌──────────────────────────────────┼──────────────────────────────────┐
       │                                  │                                  │
       ▼                                  ▼                                  ▼

   Public Services                 Protected Services                 Internal Services

       │                                  │                                  │

       ▼                                  ▼                                  ▼

  Portfolio Website                  Nextcloud                        Grafana

  Project Websites                   Vaultwarden                      Prometheus

                                                                     Node Exporter

                                                                     VPN Management
```

---

# Infrastructure Architecture

```text
                                    Ubuntu Server
                                          │
                                          ▼

 ┌──────────────────────────────────────────────────────────────┐
 │                         Docker Engine                        │
 └──────────────────────────────────────────────────────────────┘

        │               │               │               │
        ▼               ▼               ▼               ▼

     Proxy           Security        Storage         Monitoring

   Traefik         Vaultwarden      Nextcloud         Grafana

 Cloudflared           VPN                            Prometheus

                                                      Node Exporter

        │
        ▼

      Media

      Plex

   qBittorrent
```

---

# Operational Components

## Backup Services

Responsibilities:

* Daily backups
* Weekly backups
* Monthly backups
* Recovery validation

---

## UPS Services

Responsibilities:

* Power monitoring
* Graceful shutdown
* Safe startup
* Power event protection

---

## Documentation Services

Responsibilities:

* Architecture
* Runbooks
* Standards
* Troubleshooting
* Service Documentation

---

# Service Exposure Model

## Public

Accessible without authentication.

Examples:

* Portfolio Website
* Demonstration Sites

---

## Protected Public

Accessible from the Internet with authentication.

Examples:

* Nextcloud
* Vaultwarden

---

## Internal Only

Administrative services.

Examples:

* Grafana
* Prometheus
* Traefik Dashboard
* VPN Management

---

# Monitoring Flow

```text
Node Exporter
      │
      ▼
 Prometheus
      │
      ▼
  Grafana
```

---

# Backup Flow

```text
Services
    │
    ▼
Daily Backup
    │
    ▼
Weekly Backup
    │
    ▼
Monthly Off-Site Backup
```

---

# Disaster Recovery Model

```text
Backup
    │
    ▼
Restore
    │
    ▼
Validation
    │
    ▼
Operational State
```

---

# Target Outcome

The completed platform demonstrates practical implementation of:

* Linux Administration
* Docker
* Reverse Proxy Technologies
* Cloud Networking
* Monitoring and Observability
* Identity and Access Management
* Backup and Recovery
* Technical Documentation
* Infrastructure Operations

while maintaining a strong focus on:

* Security
* Recoverability
* Maintainability
* Operational Excellence
