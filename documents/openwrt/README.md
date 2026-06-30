# OpenWrt Router

## Overview

This directory contains the design, configuration, operation, and maintenance documentation for the OpenWrt router used within the homelab.

The router provides the network edge between the upstream home network and the homelab environment. It is responsible for secure network connectivity, wireless WAN access, firewall policy enforcement, remote administration through Tailscale, and routing traffic between the homelab and the internet.

The objective of this project is to build a secure, well-documented, enterprise-inspired network appliance using open-source software while following operational best practices.

---

# Objectives

This deployment was designed to achieve the following goals:

* Provide a lightweight x86 router platform.
* Use OpenWrt as the primary routing and firewall platform.
* Support wireless WAN connectivity using a USB Wi-Fi adapter.
* Provide secure remote administration using Tailscale.
* Maintain reproducible configuration through documentation.
* Follow the principle of least privilege.
* Minimise manual configuration wherever possible.
* Produce documentation suitable for long-term maintenance.

---

# Hardware

| Component        | Description                 |
| ---------------- | --------------------------- |
| Platform         | Dell Wyse 5070 Thin Client  |
| Architecture     | x86-64                      |
| Operating System | OpenWrt 25.x (APK-based)    |
| WAN Connectivity | USB Wi-Fi Adapter           |
| LAN Connectivity | Integrated Gigabit Ethernet |
| Switch           | TP-Link TL-SG1016D          |

---

# Current Features

## Networking

* Wireless WAN connectivity
* LAN routing
* DHCP server
* DNS forwarding
* NAT
* IPv4 networking

## Security

* Stateful firewall (fw4 / nftables)
* SSH administration
* Password authentication
* Tailscale remote access

## Package Management

* APK package manager
* Package repository management
* Online updates

---

# Planned Features

The following capabilities are planned for future implementation.

## Networking

* Multiple LAN segments
* VLAN support (where required)
* Static route optimisation

## Security

* DNS filtering
* Intrusion detection
* Network monitoring
* Traffic analysis

## Remote Access

* Tailscale subnet routing
* Remote administration of internal infrastructure
* Centralised access control

---

# Documentation

| Document                    | Description                          |
| --------------------------- | ------------------------------------ |
| 01-HARDWARE.md              | Hardware platform and specifications |
| 02-INSTALLATION.md          | Installation procedure               |
| 03-INITIAL-CONFIGURATION.md | First boot configuration             |
| 04-NETWORK-DESIGN.md        | Network architecture                 |
| 05-WIFI-CONFIGURATION.md    | Wireless WAN configuration           |
| 06-PACKAGE-MANAGEMENT.md    | APK package management               |
| 07-SSH.md                   | Secure Shell configuration           |
| 08-FIREWALL.md              | Firewall design and configuration    |
| 09-TAILSCALE.md             | Remote access configuration          |
| 10-SUBNET-ROUTING.md        | Tailscale subnet routing             |
| 11-BACKUP-RESTORE.md        | Backup and recovery                  |
| 12-UPGRADES.md              | Firmware and package upgrades        |
| 13-TROUBLESHOOTING.md       | Common issues and resolutions        |
| 14-COMMAND-REFERENCE.md     | Frequently used commands             |

---

# Repository Structure

```text
openwrt/
├── README.md
├── 01-HARDWARE.md
├── 02-INSTALLATION.md
├── 03-INITIAL-CONFIGURATION.md
├── 04-NETWORK-DESIGN.md
├── 05-WIFI-CONFIGURATION.md
├── 06-PACKAGE-MANAGEMENT.md
├── 07-SSH.md
├── 08-FIREWALL.md
├── 09-TAILSCALE.md
├── 10-SUBNET-ROUTING.md
├── 11-BACKUP-RESTORE.md
├── 12-UPGRADES.md
├── 13-TROUBLESHOOTING.md
└── 14-COMMAND-REFERENCE.md
```

---

# Network Overview

```text
                    Internet
                        │
                        │
              Home Router (Wi-Fi)
                        │
                Wireless WAN Client
                        │
                OpenWrt Router
                        │
                 Gigabit Ethernet
                        │
              TP-Link TL-SG1016D
                        │
        ┌───────────────┼────────────────┐
        │               │                │
    Ubuntu Server   Future Services   Management
```

---

# Design Principles

This deployment follows several guiding principles:

* Prefer open-source solutions where practical.
* Keep configurations simple and reproducible.
* Separate routing, firewall, and application responsibilities.
* Document every significant configuration change.
* Validate changes before deployment.
* Troubleshoot methodically using packet captures and system diagnostics.
* Minimise unnecessary packages and services.
* Design for maintainability rather than complexity.

---

# Security Principles

Security considerations include:

* Remote administration is performed through Tailscale.
* Firewall policy follows a default-deny model.
* Only required services are exposed.
* Administrative access is restricted.
* Configuration backups are created before significant changes.
* Sensitive information is excluded from this public repository.

---

# Lessons Learned

The implementation highlighted several important operational considerations:

* OpenWrt 25.x uses `apk` rather than `opkg`.
* Tailscale manages the `tailscale0` interface and it should not be recreated manually within the OpenWrt network configuration.
* Packet captures (`tcpdump`) are invaluable for isolating connectivity issues.
* Validating each networking layer independently is significantly more effective than making multiple configuration changes simultaneously.
* Firewall zones should be associated with the appropriate interfaces to ensure expected traffic flow.

---

# Disclaimer

This repository has been sanitised for public release.

Hostnames, IP addresses, credentials, authentication tokens, domains, certificates, and any environment-specific information have been removed or replaced with generic placeholders where appropriate.
