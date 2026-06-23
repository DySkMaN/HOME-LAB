# PHASE_1_FOUNDATION.md (Network Diagram)

# Purpose

This document provides the network diagram for Phase 1.

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
               ┌───────────────┴───────────────┐
               │                               │
               ▼                               ▼

        Portfolio Site                 Project Sites

```

---

# Traffic Flow

1. Client accesses public URL.
2. Request reaches Cloudflare.
3. Cloudflare Tunnel forwards request.
4. Traefik evaluates routing rules.
5. Request reaches target website.

---

# Key Deliverables

* Cloudflare Tunnel
* Traefik
* Website hosting
* Secure ingress architecture
