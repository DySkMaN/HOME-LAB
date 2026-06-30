# 10 – Secure Network Gateway

## Purpose

This document defines how the OpenWrt router securely provides remote access to the homelab network.

Rather than documenting administrative access to the router itself, this document explains how the router functions as a secure gateway that connects authorised users to internal infrastructure through Tailscale subnet routing.

---

# Scope

This document covers:

* Gateway architecture
* Subnet routing
* Route advertisement
* Route approval
* Traffic flow
* Access to internal services
* Split routing
* Firewall forwarding
* Performance considerations
* Future network expansion

---

# Gateway Philosophy

The OpenWrt router serves as the trusted entry point into the homelab.

Instead of exposing every internal service to the internet or installing remote access software on every device, authorised users authenticate once and traverse a controlled gateway.

Benefits include:

* Reduced attack surface.
* Centralised routing.
* Simplified administration.
* Consistent security policy.
* Easier auditing.

---

# Architecture

```text
                     Internet
                         │
                  Tailscale Tailnet
                         │
               Identity Authentication
                         │
                  OpenWrt Router
               (Secure Network Gateway)
                         │
                  Firewall Inspection
                         │
                 Routing Decision
                         │
        ┌──────────┬──────────┬──────────┐
        │          │          │
    Docker Host  Storage   Future Hosts
```

The router becomes the single, trusted gateway between remote administrators and internal infrastructure.

---

# Why Subnet Routing?

Subnet routing allows one authenticated device to advertise reachability for an entire internal network.

Advantages include:

* No need to install Tailscale on every server.
* Centralised management.
* Consistent security policies.
* Lower operational overhead.

This model is well suited to infrastructure devices that remain permanently connected behind the router.

---

# Route Advertisement

The router advertises approved internal networks to the Tailnet.

Examples include:

* Infrastructure LAN.
* Storage network.
* Future management VLAN.
* Future development network.

Only networks that require remote administration should be advertised.

---

# Route Approval

Advertised routes remain inactive until approved within the Tailscale administration console.

This additional approval stage prevents accidental publication of internal networks and provides administrative oversight.

---

# Traffic Flow

The following sequence describes a typical remote connection.

```text
Remote Administrator
        │
Encrypted WireGuard Tunnel
        │
OpenWrt Router
        │
Decrypt Traffic
        │
Firewall Policy
        │
Routing Decision
        │
Destination Host
```

The router performs routing and policy enforcement before traffic reaches the destination device.

---

# Accessing Internal Services

Once subnet routing is operational, authorised users may securely access approved services such as:

* SSH
* HTTPS
* SMB
* NFS
* RDP
* Docker applications
* Monitoring dashboards
* Storage services

Access remains subject to both Tailscale policy and local firewall policy.

---

# Split Routing

The deployment uses split routing.

Only traffic destined for the advertised internal networks traverses the encrypted tunnel.

General internet traffic continues to use the administrator's local internet connection.

Advantages include:

* Lower latency.
* Reduced bandwidth consumption.
* Improved user experience.
* Simpler troubleshooting.

---

# Exit Nodes

OpenWrt is **not** currently configured as an exit node.

Reasons include:

* Administrative traffic does not require full-tunnel routing.
* Split routing better aligns with current operational requirements.
* Reduced processing overhead.

This decision may be revisited if future requirements change.

---

# Firewall Integration

The firewall remains responsible for:

* Forwarding policy.
* Network isolation.
* Access control.
* Traffic filtering.

Tailscale provides secure transport but does not replace firewall policy.

---

# Validation

Verify subnet advertisement:

```sh
tailscale status --json
```

Verify routing:

```sh
ip route
```

Confirm remote access to an internal host from an authorised Tailnet device.

Test representative services (for example SSH, HTTPS and SMB) to ensure firewall forwarding and routing behave as expected.

---

# Performance Considerations

Performance depends on:

* Router CPU capacity.
* Available WAN bandwidth.
* Wireless signal quality.
* MTU.
* Number of concurrent connections.

Routine monitoring should include latency, packet loss and throughput.

---

# Future Expansion

The gateway architecture supports future enhancements including:

* Multiple advertised networks.
* VLAN-aware routing.
* High-availability gateways.
* Exit node functionality.
* IPv6 subnet advertisement.
* Granular Tailscale ACLs.
* Policy-based routing.

---

# Security Considerations

The gateway should advertise only the networks that are operationally required.

Recommended practices include:

* Review advertised routes regularly.
* Approve routes deliberately.
* Apply least-privilege ACLs.
* Monitor gateway availability.
* Audit remote access periodically.

---

# Lessons Learned

* Centralising remote access simplifies infrastructure management.
* Route advertisement and route approval are independent processes.
* Firewall policy remains essential even when using an encrypted overlay network.
* Treating the router as a secure gateway provides a scalable foundation for future network growth.

---

# References

* Tailscale Subnet Router Documentation
* OpenWrt Documentation
* Linux IP Routing Documentation
* WireGuard Documentation
* Zero Trust Architecture Guidance
