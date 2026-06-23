# PHASE_6_NAS_MEDIA.md (Network Diagram)

# Purpose

This document provides the network diagram for Phase 6.

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
             ┌────────────────────┼────────────────────┐
             │                    │                    │
             ▼                    ▼                    ▼

        Nextcloud              Plex            qBittorrent
             │                    │                    │
             └────────────────────┼────────────────────┘
                                  │
                                  ▼
                             NAS Storage
                                  │
                                  ▼
                         Backup Repository
```

---

# Backup Flow

```text
Services
    │
    ▼
 NAS Storage
    │
    ▼
Weekly Backup
    │
    ▼
Monthly Off-Site Backup
```

---

# Deliverables

* NAS Integration
* Plex
* qBittorrent
* Expanded Storage
* Long-Term Backup Storage

---

# Operational Outcome

The platform gains dedicated storage infrastructure, media services, and enhanced backup capacity.
