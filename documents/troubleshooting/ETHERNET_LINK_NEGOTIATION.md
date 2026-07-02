# Ubuntu Server Unable to Communicate with OpenWrt Router via Ethernet

## Overview

This document describes the troubleshooting process used when an Ubuntu Server connected to an OpenWrt router through an Ethernet switch failed to establish reliable network connectivity.

Although both devices appeared physically connected, the server experienced failed communication caused by an Ethernet link negotiation issue.

---

# Environment

## Components

- OpenWrt Router
- Ubuntu Server
- Gigabit Ethernet Switch

## Network Topology

```text
Internet
    │
Upstream Network
    │
OpenWrt Router
    │
LAN
    │
Ethernet Switch
    │
Ubuntu Server
```

---

# Symptoms

Observed behaviour included:

- Unable to communicate with the router
- ICMP ping returning 100% packet loss
- No Internet connectivity
- Ethernet interface reporting a physical link
- Network configuration appeared correct

---

# Initial Assumptions

The following possible causes were investigated:

- Incorrect IP addressing
- Incorrect routing
- Firewall configuration
- Physical cabling fault
- Switch port failure
- OpenWrt LAN configuration
- Ethernet auto-negotiation failure
- Network interface driver issue

---

# Investigation

## 1. Verify Interface Status

```bash
ip addr
ip link
```

Confirmed:

- Interface was UP
- Link detected
- Valid IP address assigned

---

## 2. Verify Routing

```bash
ip route
```

Confirmed a valid default gateway and expected network routes.

---

## 3. Test Connectivity

```bash
ping <router-ip>
```

Result:

```text
100% packet loss
```

Since addressing and routing appeared correct, investigation shifted towards the physical network.

---

## 4. Inspect Ethernet Negotiation

Install `ethtool` if required.

```bash
sudo apt install ethtool
```

Inspect the interface.

```bash
sudo ethtool <interface>
```

Observed:

```text
Link partner advertised:

10baseT Half
10baseT Full
100baseT Half
100baseT Full
```

Expected:

```text
1000baseT Full
```

The connected device was only negotiating Fast Ethernet rather than Gigabit Ethernet, indicating a Layer 1/Layer 2 issue.

---

# Root Cause

The problem was traced to failed Ethernet auto-negotiation.

Although the interface detected a physical link, the connected devices were not successfully negotiating their highest supported speed.

Potential causes included:

- Faulty Ethernet cable
- Damaged connector
- Faulty switch port
- Poor cable termination
- Auto-negotiation failure

Correcting the physical connection restored normal link negotiation.

---

# Resolution

After replacing the physical connection:

- Gigabit link negotiated successfully
- Packet loss ceased
- Router communication restored
- Internet connectivity restored
- Network operation returned to normal

---

# Verification

Verify negotiated speed.

```bash
sudo ethtool <interface>
```

Expected output:

```text
Speed: 1000Mb/s
Duplex: Full
Auto-negotiation: on
Link detected: yes
```

Verify routing.

```bash
ip route
```

Verify connectivity.

```bash
ping <router-ip>
ping 8.8.8.8
ping example.com
```

Inspect interface statistics.

```bash
ip -s link show <interface>
```

No increasing RX/TX errors should be present.

---

# Lessons Learned

This issue reinforced the importance of troubleshooting from the lowest layer of the OSI model upwards.

Although the symptoms initially resembled an IP routing problem, the underlying cause existed at the Ethernet physical layer.

Key takeaways:

- A detected Ethernet link does not guarantee a healthy connection.
- Always verify negotiated speed and duplex using `ethtool`.
- Eliminate physical faults before changing network configuration.
- Follow a structured troubleshooting methodology to reduce unnecessary changes.

---

# Useful Commands

Display interface configuration.

```bash
ip addr
```

Display routing table.

```bash
ip route
```

Test connectivity.

```bash
ping <host>
```

Inspect Ethernet negotiation.

```bash
sudo ethtool <interface>
```

View interface statistics.

```bash
ip -s link show <interface>
```

Review kernel network messages.

```bash
journalctl -k
```

---

# Outcome

Reliable communication between the Ubuntu server and OpenWrt router was restored after resolving the Ethernet negotiation issue.

This incident demonstrated the value of structured, OSI-based troubleshooting, confirming that physical layer verification should be completed before modifying higher-level network configuration.
