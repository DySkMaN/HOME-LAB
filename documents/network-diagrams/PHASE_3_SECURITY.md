# PHASE_3_SECURITY.md (Network Diagram)

# Purpose

This document provides the network diagram for Phase 3.

---

# Architecture

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
      ┌────────────────────────┼────────────────────────┐
      │                        │                        │
      ▼                        ▼                        ▼

  Websites                Vaultwarden            Internal Services

                                                   ▲
                                                   │
                                                   │
                                             VPN Access
                                                   │
                                                   ▼
                                             Administrator
```

---

# Access Model

## Public

* Portfolio Website
* Project Websites

## Protected Public

* Vaultwarden

## Internal Only

* Grafana
* Prometheus
* Administrative Services

---

# Security Flow

```text
Administrator
      │
      ▼
 VPN Connection
      │
      ▼
 Internal Network
      │
      ▼
 Administrative Services
```

---

# Deliverables

* Vaultwarden
* VPN Service
* Access Controls
* Credential Management
* Security Documentation

---

# Operational Outcome

Administrative access is separated from public-facing services and credential management is centralised.
