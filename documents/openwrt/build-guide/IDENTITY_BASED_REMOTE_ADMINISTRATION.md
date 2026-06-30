# 09 – Identity-Based Remote Administration

## Purpose

This document defines the secure administrative access model for the OpenWrt router using Tailscale.

Its objective is to ensure that administrative access to the router is encrypted, identity-aware and independent of the public internet. The router itself is the subject of this document—access to downstream devices is covered separately in **10 – Secure Network Gateway**.

---

# Scope

This document covers:

* Administrative access philosophy
* Why Tailscale was selected
* Tailscale installation
* Device authentication
* Identity management
* Key expiry
* Firewall integration
* Secure Shell (SSH)
* Validation
* Troubleshooting
* Security considerations

---

# Administrative Philosophy

The router is critical infrastructure.

Administrative access must satisfy the following principles:

* No public management interfaces.
* Identity-based authentication.
* Encrypted communication.
* Minimal attack surface.
* Least privilege.
* Recoverability through local console access.

---

# Why Tailscale?

Tailscale was selected because it provides:

* WireGuard-based encryption.
* Automatic NAT traversal.
* Identity-aware access control.
* Minimal operational overhead.
* Cross-platform client support.
* No inbound port forwarding.

Alternative technologies such as traditional WireGuard, OpenVPN and IPsec were evaluated but required additional infrastructure or ongoing peer management that was unnecessary for this deployment.

---

# Architecture

```text
Administrator
      │
      ▼
Tailscale Client
      │
Encrypted Tunnel
      │
      ▼
OpenWrt Router
      │
Dropbear SSH
```

The communication path terminates at the router.

No downstream services are involved.

---

# Installation

Install the package:

```sh
apk add tailscale
```

Start the daemon:

```sh
service tailscale start
```

Authenticate the router:

```sh
tailscale up
```

Complete authentication using the URL presented by the CLI.

---

# Identity Management

Each router becomes an authenticated node within the Tailnet.

Administrative permissions are granted according to:

* User identity.
* Tailnet membership.
* ACL policies.
* Device approval.

Authentication decisions are made by the identity provider rather than by source IP addresses.

---

# Key Management

Infrastructure devices should have key expiry disabled.

Reasons include:

* Continuous availability.
* Reduced maintenance.
* Predictable remote access.
* Fewer operational interruptions.

This configuration should be managed through the Tailscale administration console.

---

# Firewall Integration

Responsibilities are intentionally separated.

**Tailscale**

* Creates `tailscale0`
* Encrypts traffic
* Authenticates devices

**OpenWrt**

* Controls firewall policy
* Filters traffic
* Determines administrative access

The `tailscale0` interface must not be recreated manually within the OpenWrt network configuration.

---

# Administrative Access

SSH is the preferred administration protocol.

Validation:

```sh
service dropbear status
netstat -ln | grep :22
```

Remote login:

```text
ssh root@<tailscale-ip>
```

Administrative services should never be exposed directly to the public internet.

---

# Operational Validation

Verify service status:

```sh
service tailscale status
```

Review connected peers:

```sh
tailscale status
```

Confirm assigned address:

```sh
tailscale ip
```

Verify interface:

```sh
ip addr show tailscale0
```

Confirm SSH connectivity from an authorised Tailnet device.

---

# Troubleshooting

## Router Offline

Verify:

* Internet connectivity.
* `tailscaled` service.
* Authentication status.
* System logs.

---

## SSH Timeout

Investigate:

* Dropbear service.
* Firewall policy.
* Interface assignment.
* Packet capture using:

```sh
tcpdump -ni tailscale0 tcp port 22
```

---

## Authentication Issues

Review:

* Tailnet membership.
* ACL configuration.
* Key expiry.
* Device approval.

---

# Security Considerations

Administrative access should satisfy the following:

* Encrypted end-to-end.
* Identity verified.
* No public exposure.
* Authentication logged.
* Access limited to authorised administrators.

---

# Design Decisions

## Why Identity Instead of IP?

User identity is more reliable than source IP addresses in modern, mobile environments.

## Why No Public SSH?

Removing public exposure eliminates a significant attack surface and avoids unnecessary firewall exceptions.

## Why Console Access Remains Important?

A physical recovery path ensures the router remains manageable even if networking fails.

---

# Lessons Learned

* Tailscale should manage the virtual interface.
* OpenWrt should manage firewall policy.
* Packet captures are often the fastest way to isolate connectivity issues.
* Layer-by-layer validation simplifies troubleshooting.

---

# References

* Tailscale Documentation
* WireGuard Whitepaper
* OpenWrt Documentation
* OpenWrt Firewall Documentation
