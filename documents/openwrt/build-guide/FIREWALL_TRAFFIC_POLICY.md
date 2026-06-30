# 08 – Firewall & Traffic Policy

## Purpose

This document defines the firewall architecture, traffic policies and security controls implemented on the OpenWrt router.

The firewall forms the primary security boundary between trusted and untrusted networks. Its purpose is to enforce the principle of least privilege by permitting only authorised traffic while denying all other communication by default.

The firewall configuration has been designed to remain simple, predictable and easy to audit while providing a secure foundation for future network expansion.

---

# Scope

This document covers:

* Firewall philosophy
* Security zones
* Interface assignment
* Traffic flow
* Input, output and forwarding policies
* Remote administration
* Validation
* Troubleshooting
* Security considerations
* Future enhancements

---

# Security Philosophy

The firewall follows several core security principles.

* Default deny.
* Explicit allow.
* Least privilege.
* Minimise exposed services.
* Separate trusted and untrusted networks.
* Document every exception.

No traffic should be permitted simply because it "might be required".

Every permitted service should have a documented operational requirement.

---

# Firewall Architecture

OpenWrt uses **fw4**, which generates **nftables** rules within the Linux kernel.

```text id="sbx2ws"
             Incoming Traffic
                     │
                     ▼
             nftables (fw4)
                     │
     ┌───────────────┼───────────────┐
     │               │               │
   LAN Zone      WAN Zone     Tailscale Zone
     │               │               │
     ▼               ▼               ▼
 Allow         Default Deny     Restricted Allow
```

The firewall configuration is managed using OpenWrt's Unified Configuration Interface (UCI), which generates nftables rules automatically.

Direct nftables modifications should only be used for temporary troubleshooting and must not replace persistent UCI configuration.

---

# Security Zones

The router currently defines three primary trust zones.

| Zone      | Trust Level | Purpose                             |
| --------- | ----------- | ----------------------------------- |
| LAN       | Trusted     | Internal homelab network            |
| WAN       | Untrusted   | Residential network and internet    |
| Tailscale | Trusted     | Authenticated remote administration |

Each zone has clearly defined responsibilities and trust assumptions.

---

# Interface Assignment

| Interface              | Zone      |
| ---------------------- | --------- |
| `br-lan`               | LAN       |
| Wireless WAN Interface | WAN       |
| `tailscale0`           | Tailscale |

The `tailscale0` interface is managed by Tailscale and associated directly with the firewall zone.

A manually created OpenWrt network interface must **not** be used.

---

# Default Policies

The firewall adopts a default-deny approach.

| Zone      | Input  | Output | Forward |
| --------- | ------ | ------ | ------- |
| LAN       | Accept | Accept | Accept  |
| WAN       | Reject | Accept | Drop    |
| Tailscale | Accept | Accept | Accept  |

This configuration ensures that:

* Internal devices can communicate normally.
* Outbound traffic is unrestricted.
* Unsolicited inbound traffic from the WAN is denied.
* Remote administration occurs only through authenticated Tailscale clients.

---

# Traffic Flow

## LAN

Permitted:

* Router administration.
* Internet access.
* Internal services.

---

## WAN

Permitted:

* DHCP.
* Required ICMP.
* Established connections.

Denied:

* Administrative services.
* Unsolicited inbound connections.
* Unauthorised forwarding.

---

## Tailscale

Permitted:

* Secure remote administration.
* SSH access.
* Future subnet routing.

Traffic entering via `tailscale0` is treated separately from the WAN.

---

# Firewall Management

Configuration is performed through UCI.

Typical validation:

```sh id="9jkmfc"
/sbin/fw4 check
```

Display generated rules:

```sh id="r9k9yw"
fw4 print
```

Inspect active nftables:

```sh id="80ohpl"
nft list ruleset
```

View firewall configuration:

```sh id="ifgjk2"
uci show firewall
```

---

# Validation

Following any firewall change verify:

## Syntax

```sh id="0iuv8f"
/sbin/fw4 check
```

---

## Service

```sh id="v61j6r"
service firewall restart
```

---

## Active Rules

```sh id="2jofra"
nft list chain inet fw4 input
```

---

## Connectivity

Confirm:

* LAN connectivity.
* Internet connectivity.
* SSH.
* Tailscale.
* DNS resolution.

---

# Operational Troubleshooting

## Firewall Fails to Load

Verify:

```sh id="vgrux7"
/sbin/fw4 check
```

Review:

```sh id="m1qrzm"
logread
```

---

## SSH over Tailscale Fails

Symptoms observed during deployment included:

* `tailscale ping` successful.
* SSH timeout.
* Dropbear listening correctly.
* TCP packets arriving on `tailscale0`.

Root cause:

`tailscale0` was not associated with a firewall zone.

Resolution:

* Remove any manually created `network.tailscale` interface.
* Create a firewall zone bound directly to `tailscale0`.

This issue demonstrates the importance of separating interface management (Tailscale) from firewall policy (OpenWrt).

---

## Packet Capture

Traffic validation:

```sh id="fguhsy"
tcpdump -ni tailscale0 tcp port 22
```

Packet capture should be preferred over assumptions when troubleshooting network behaviour.

---

# Design Decisions

## Why fw4?

Advantages include:

* Native nftables integration.
* High performance.
* Declarative configuration.
* Excellent OpenWrt integration.

---

## Why Default Deny?

Default-deny significantly reduces attack surface by ensuring that new services are inaccessible until explicitly permitted.

---

## Why Separate Tailscale?

Tailscale represents authenticated administrative traffic.

Treating it as a dedicated trust zone simplifies policy management and clearly distinguishes trusted overlay traffic from the untrusted WAN.

---

## Why Use UCI?

Although nftables rules can be modified directly, persistent configuration should always be maintained through UCI.

This improves:

* Maintainability.
* Repeatability.
* Upgrade compatibility.
* Documentation accuracy.

---

# Security Considerations

The firewall represents the primary enforcement point for the router.

Recommendations include:

* Review firewall changes before deployment.
* Validate every configuration change.
* Avoid temporary rules becoming permanent.
* Document every exception.
* Maintain the smallest practical attack surface.

---

# Lessons Learned

The deployment highlighted several operational observations.

* Packet captures are significantly more valuable than assumptions.
* Interface assignment is just as important as firewall rules.
* Tailscale should manage the interface.
* OpenWrt should manage the firewall.
* Direct nftables changes are useful for diagnostics but should not replace managed configuration.

---

# Future Enhancements

Potential future improvements include:

* VLAN-aware firewall policies.
* Guest network isolation.
* Infrastructure management network.
* Intrusion detection integration.
* Geo-based filtering.
* Rate limiting.
* Traffic accounting.
* Logging to a central SIEM.
* Policy-as-code validation.

---

# References

* OpenWrt Firewall (fw4) Documentation
* nftables Documentation
* Linux Netfilter Project
* CIS Linux Benchmark
* OpenWrt Security Documentation
