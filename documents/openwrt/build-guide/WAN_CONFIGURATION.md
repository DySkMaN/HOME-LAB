# 05 – WAN Configuration

## Purpose

This document describes the configuration, validation and operational management of the Wide Area Network (WAN) connection used by the OpenWrt router.

At the time of writing, the router establishes WAN connectivity using a supported USB Wi-Fi adapter operating in client (station) mode. The architecture has been intentionally documented in a technology-agnostic manner so the same operational procedures remain applicable if the WAN is later migrated to Ethernet, fibre, LTE or another transport.

---

# Scope

This document covers:

* WAN architecture
* Wireless WAN implementation
* Interface configuration
* Internet connectivity
* DNS verification
* Failures and recovery
* Operational validation
* Security considerations
* Future improvements

Wireless security and firewall policy are documented separately.

---

# Design Objectives

The WAN configuration has been designed to achieve the following objectives:

* Reliable internet connectivity.
* Simple deployment.
* Minimal hardware requirements.
* Logical separation between upstream and homelab networks.
* Stable operation during long uptime.
* Easy recovery following hardware replacement.

---

# WAN Architecture

The OpenWrt router functions as the network edge for the homelab while relying on an existing residential network for internet access.

```text
                     Internet
                         │
                  ISP Infrastructure
                         │
                  Residential Router
                  (Wireless Access Point)
                         │
                  WPA2/WPA3 Security
                         │
              USB Wi-Fi Adapter (Station)
                         │
                  OpenWrt WAN Interface
                         │
              Routing • NAT • Firewall
                         │
                    Homelab LAN
```

The WAN connection is considered an untrusted network and all traffic entering from the upstream network is processed according to the configured firewall policy.

---

# Hardware

| Component              | Purpose                   |
| ---------------------- | ------------------------- |
| USB Wi-Fi Adapter      | Upstream WAN connectivity |
| Supported Linux Driver | Wireless client operation |
| OpenWrt                | Routing and firewall      |

The wireless adapter is dedicated to WAN connectivity and is not used as an access point.

---

# Why a Wireless WAN?

A traditional wired WAN connection was not available for the homelab deployment.

Using a wireless WAN allows the router to:

* Operate independently of the residential router.
* Preserve the dedicated Ethernet interface for the homelab LAN.
* Minimise cabling.
* Allow the router to be relocated easily.

### Advantages

* Simple deployment.
* No additional infrastructure required.
* Low cost.
* Portable.

### Limitations

* Dependent on wireless signal quality.
* Subject to RF interference.
* Lower reliability than dedicated Ethernet.
* Performance depends on the upstream access point.

These trade-offs are acceptable for the current deployment.

---

# Interface Configuration

The WAN interface operates as a wireless client associated with the upstream wireless network.

Responsibilities include:

* Association with the access point.
* DHCP client.
* Default route.
* DNS acquisition.
* Internet connectivity.

The WAN interface should never provide services to downstream devices.

---

# IP Addressing

The WAN interface receives its configuration dynamically.

The following parameters are expected:

* IPv4 address
* Default gateway
* DNS servers
* Lease duration

No static addressing is required.

---

# Connectivity Validation

## Verify Interface Status

```sh
ip addr
```

Confirm that the WAN interface is present and operational.

---

## Verify Default Route

```sh
ip route
```

Expected result:

* A valid default gateway.
* WAN interface associated with the default route.

---

## Verify Internet Reachability

```sh
ping 1.1.1.1
```

Successful replies confirm Layer 3 connectivity.

---

## Verify DNS

```sh
ping openwrt.org
```

Successful hostname resolution confirms DNS functionality.

---

## Verify Package Connectivity

```sh
apk update
```

Successful repository updates confirm both DNS resolution and outbound HTTPS connectivity.

---

# Wireless Validation

Confirm wireless association.

```sh
iw dev
```

Review system logs.

```sh
logread | grep -i wpa
```

Inspect wireless status.

```sh
iwinfo
```

Expected results include:

* Successful authentication.
* Stable association.
* Acceptable signal quality.
* No repeated authentication failures.

---

# Operational Monitoring

Routine monitoring should include:

* WAN uptime.
* Signal quality.
* DHCP lease renewal.
* DNS responsiveness.
* Internet latency.

Any degradation should be investigated before it impacts downstream services.

---

# Troubleshooting

## No Wireless Association

Possible causes:

* Incorrect SSID.
* Incorrect authentication.
* Unsupported wireless mode.
* Poor signal quality.
* Regulatory domain mismatch.

Verify:

```sh
iw dev
logread | grep -i wpa
```

---

## No IP Address

Possible causes:

* DHCP failure.
* Authentication failure.
* Association failure.

Verify:

```sh
ip addr
ip route
```

---

## Internet Unreachable

Verify:

* Default gateway.
* DNS.
* Firewall.
* Wireless association.
* Upstream connectivity.

---

## Repository Errors

Symptoms may include:

* Repository download failures.
* Certificate validation errors.
* HTTPS failures.

Refer to **06 – Package Management** for repository-specific troubleshooting.

---

# Security Considerations

The WAN network is considered untrusted.

Security principles include:

* Default-deny firewall policy.
* No administrative services exposed directly to the WAN.
* Remote administration performed through Tailscale.
* Only established and authorised traffic permitted.

---

# Design Decisions

## Why DHCP?

DHCP simplifies deployment and avoids unnecessary administrative overhead when operating behind an existing residential router.

---

## Why No Bridge Mode?

The upstream router remains responsible for internet connectivity.

OpenWrt provides routing and network separation for the homelab rather than replacing the residential gateway.

---

## Why Not Use the Wi-Fi Adapter as an Access Point?

Separating WAN and LAN responsibilities simplifies the design and reduces operational complexity.

The wireless adapter remains dedicated to its role as the upstream WAN interface.

---

# Lessons Learned

The deployment highlighted several operational observations:

* Wireless WAN can provide a reliable solution where Ethernet is unavailable.
* Validating connectivity layer by layer significantly reduces troubleshooting time.
* Driver compatibility should always be verified before deployment.
* Package repository issues should be isolated from general network connectivity problems.
* Stable WAN connectivity should be confirmed before configuring higher-level services.

---

# Future Improvements

Potential future enhancements include:

* Dedicated Ethernet WAN.
* Secondary WAN for redundancy.
* Automatic WAN failover.
* LTE/5G backup connectivity.
* Performance monitoring.
* Link quality alerting.
* IPv6 WAN support.

These enhancements will be implemented only where they provide measurable operational value.

---

# References

* OpenWrt Wireless Documentation
* Linux Wireless Documentation
* WPA Supplicant Documentation
* OpenWrt Network Configuration Guide
* IEEE 802.11 Standards
