# PHASE_2_OBSERVABILITY.md (Network Diagram)

# Purpose

This document provides the network diagram for Phase 2.

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
                     ┌─────────┴─────────┐
                     │                   │
                     ▼                   ▼

                 Websites           Monitoring

                                         │
                                         ▼
                                  Node Exporter
                                         │
                                         ▼
                                   Prometheus
                                         │
                                         ▼
                                     Grafana
```

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

# Deliverables

* Node Exporter
* Prometheus
* Grafana
* Infrastructure Dashboards
* Resource Monitoring
* Historical Metrics

---

# Operational Outcome

Infrastructure becomes observable.

Problems can be detected before they become outages.

