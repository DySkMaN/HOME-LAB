# PHASE_5_EXPANSION.md (Network Diagram)

# Purpose

This document provides the network diagram for Phase 5.

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

   Websites               Productivity          Monitoring

                          Nextcloud             Grafana

                                               Prometheus

                                               Alerting

                                               Logging

                                               Security
                                               Monitoring
```

---

# Deliverables

* Logging Platform
* Alerting
* Security Monitoring
* Automation
* Operational Enhancements

---

# Operational Outcome

The platform evolves from a collection of services into a managed operational environment.
