# 04 – Network Configuration

## Purpose

This document defines the network architecture, interface configuration, routing strategy and design decisions for the OpenWrt router.

It serves as the authoritative reference for how the router integrates with the homelab infrastructure and provides guidance for future expansion while maintaining a secure and reproducible configuration.

This document intentionally focuses on network architecture rather than service-specific configuration. Wireless configuration, firewall policy, SSH and Tailscale are documented separately.

---

# Scope

This document covers:

* Physical topology
* Logical topology
* Interface assignments
* IP addressing
* Routing
* DNS
* DHCP
* Design decisions
* Validation procedures
* Troubleshooting
* Future improvements

---

# Design Objectives

The network has been designed around the following principles:

* Maintain a clear separation between upstream and downstream networks.
* Keep the architecture simple and easy to troubleshoot.
* Minimise unnecessary complexity during the initial deployment.
* Support secure remote administration.
* Provide a foundation for future expansion.
* Follow enterprise networking concepts while remaining practical for a homelab environment.

---

# Physical Topology

The OpenWrt router connects to the existing residential network over Wi-Fi and provides a dedicated wired LAN for the homelab.

```text
                     Internet
                         │
                         │
              Residential Router
                   (Wireless LAN)
                         │
                  Wi-Fi Client (WAN)
                         │
              ┌─────────────────────┐
              │      OpenWrt        │
              │   Dell Wyse 5070    │
              └─────────────────────┘
                         │
                  Gigabit Ethernet
                         │
                TP-Link TL-SG1016D
                         │
        ┌────────────────┼────────────────┐
        │                │                │
  Ubuntu Server     Future Services    Management
```

The OpenWrt router acts as the network edge for the homelab while remaining independent from the residential router.

---

# Logical Topology

The current deployment consists of three logical network interfaces.

| Interface | Function              | Status      |
| --------- | --------------------- | ----------- |
| WAN       | Internet connectivity | Operational |
| LAN       | Homelab network       | Operational |
| Tailscale | Remote administration | Operational |

Future deployments may introduce additional logical networks for:

* Infrastructure management
* Guest access
* Internet of Things (IoT)
* Development and testing
* Security research

These networks are intentionally deferred until a clear operational requirement exists.

---

# Interface Assignment

| Interface  | Description                                                   |
| ---------- | ------------------------------------------------------------- |
| WAN        | Wireless client connected to the upstream residential network |
| LAN        | Bridged Ethernet interface serving the homelab                |
| tailscale0 | Virtual interface created and managed by Tailscale            |

The `tailscale0` interface is created automatically by Tailscale and must not be manually recreated within the OpenWrt network configuration.

---

# Network Addressing Strategy

The addressing scheme follows standard private IPv4 addressing.

| Network                           | Purpose                   |
| --------------------------------- | ------------------------- |
| Private IPv4 Subnet               | Homelab LAN               |
| DHCP Client                       | Upstream WAN              |
| Carrier Grade NAT (100.64.0.0/10) | Tailscale overlay network |

Actual production addressing has been intentionally omitted from this public documentation.

---

# Routing Strategy

The router maintains a straightforward routing model.

## WAN

The WAN interface receives its configuration dynamically from the upstream network.

Responsibilities include:

* Default route
* Internet connectivity
* DNS reachability

---

## LAN

The LAN provides:

* Internal routing
* DHCP services
* Default gateway for homelab devices

---

## Remote Administration

Tailscale provides encrypted remote access without exposing administrative services directly to the internet.

Future plans include enabling subnet routing to provide secure access to internal infrastructure from authorised Tailscale clients.

---

# DNS Strategy

DNS resolution is forwarded upstream.

Current objectives:

* Reliable name resolution
* Low administrative overhead
* Standards compliance

Future enhancements may include:

* Local DNS records
* DNS filtering
* Split DNS
* DNS-over-HTTPS
* DNS-over-TLS

---

# DHCP Strategy

Dynamic addressing is used during the initial deployment.

Future enhancements may include:

* Static reservations
* Device naming
* Lease optimisation
* Infrastructure reservations

As the homelab grows, infrastructure devices should transition to static addressing or DHCP reservations to simplify administration.

---

# Design Decisions

## Why OpenWrt?

OpenWrt provides:

* A lightweight operating system.
* Long-term community support.
* Flexible package management.
* Full Linux tooling.
* Excellent hardware compatibility.
* Enterprise networking features.

Alternative platforms such as pfSense and OPNsense were considered; however, OpenWrt better aligned with the project's goals of simplicity, low resource usage and strong wireless support.

---

## Why a Wireless WAN?

The homelab does not have a dedicated Ethernet connection to the upstream router.

Using a supported USB Wi-Fi adapter allows the router to:

* Maintain logical separation from the residential network.
* Avoid additional cabling.
* Remain portable.
* Preserve a dedicated wired LAN for downstream devices.

The trade-off is a dependency on wireless signal quality and upstream access point availability.

---

## Why a Dedicated LAN?

Separating the homelab from the residential network provides:

* Easier troubleshooting.
* Independent addressing.
* Cleaner routing.
* Improved security.
* Greater flexibility for future segmentation.

---

## Why Tailscale?

Traditional VPN solutions require inbound port forwarding and additional configuration.

Tailscale provides:

* Encrypted remote access.
* Automatic NAT traversal.
* Simple client deployment.
* Centralised identity management.
* Reduced administrative overhead.

The overlay network integrates well with OpenWrt while avoiding unnecessary exposure of management services.

---

## Why No VLANs?

Although VLANs are widely used in enterprise environments, they are intentionally not deployed during the initial build.

Current requirements do not justify the additional operational complexity.

VLANs will be introduced only when they provide measurable security, management or operational benefits.

This approach follows the principle of implementing the simplest solution that satisfies current requirements.

---

# Configuration Validation

Following any network change, validate the configuration.

## Interfaces

```sh
ip addr
```

Confirm:

* LAN interface present
* WAN interface operational
* Tailscale interface operational

---

## Routing

```sh
ip route
```

Verify:

* Default route
* LAN route
* Tailscale route

---

## Internet Connectivity

```sh
ping 1.1.1.1
```

Expected result:

Successful ICMP replies.

---

## DNS

```sh
ping openwrt.org
```

Expected result:

Successful hostname resolution.

---

## Interface Configuration

```sh
uci show network
```

Review interface assignments and configuration.

---

# Troubleshooting

## No Internet Connectivity

Verify:

* WAN association
* Default route
* DNS
* Firewall
* Wireless signal quality

---

## LAN Cannot Reach Internet

Inspect:

* DHCP configuration
* Default gateway
* NAT
* Routing table

---

## Tailscale Connectivity Issues

Verify:

* Tailscale service status
* Authentication
* Firewall zone assignment
* Interface creation

Refer to **09 – Tailscale** for detailed diagnostics.

---

## Incorrect Routing

Inspect:

```sh
ip route
```

Look for:

* Missing default gateway
* Duplicate routes
* Incorrect interface assignment

---

# Security Considerations

Network configuration follows a default-deny philosophy.

Security objectives include:

* Minimise exposed services.
* Separate trusted and untrusted networks.
* Encrypt remote administration.
* Avoid unnecessary forwarding.
* Document all interface assignments.

---

# Lessons Learned

The deployment highlighted several important operational lessons.

* Network problems are most effectively diagnosed one layer at a time.
* Packet captures provide definitive evidence of traffic flow.
* OpenWrt and Tailscale each have clearly defined responsibilities and should not manage the same interface.
* Simple network designs are significantly easier to maintain and troubleshoot.
* Incremental validation reduces deployment risk.

---

# Future Roadmap

Potential future enhancements include:

* VLAN segmentation
* IPv6 deployment
* DNS filtering
* High availability
* Dynamic routing
* Network monitoring
* Configuration automation
* Infrastructure-as-Code
* Configuration version control
* Centralised logging

Future changes will be implemented only where they provide measurable operational value.

---

# References

* OpenWrt User Guide
* OpenWrt Network Configuration Documentation
* Linux Networking Documentation
* nftables Documentation
* Tailscale Documentation
* RFC 1918 – Address Allocation for Private Internets
* RFC 6598 – Shared Address Space for Carrier-Grade NAT
