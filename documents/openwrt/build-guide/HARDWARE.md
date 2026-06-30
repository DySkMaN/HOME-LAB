# 01 - Hardware

## Purpose

This document describes the physical hardware used to build the OpenWrt router, the rationale behind each hardware selection, and any relevant compatibility considerations.

The objective is to create a reliable, low-power x86 routing platform suitable for a small enterprise or homelab environment while remaining cost-effective and easy to maintain.

---

# Design Goals

The hardware platform was selected to meet the following objectives:

* Low power consumption suitable for 24/7 operation.
* Small physical footprint.
* Silent operation.
* Gigabit networking performance.
* USB expansion for wireless networking.
* Excellent Linux compatibility.
* Long-term reliability.
* Affordable replacement cost.

---

# Hardware Inventory

| Component        | Model                                  | Purpose                                    |
| ---------------- | -------------------------------------- | ------------------------------------------ |
| Router Platform  | Dell Wyse 5070 Thin Client             | Primary OpenWrt router                     |
| CPU              | Intel Quad-Core x86 Processor          | Routing, firewall and VPN processing       |
| Memory           | 8 GB DDR4 *(or installed capacity)*    | Operating system and package memory        |
| Storage          | Internal SSD *(capacity as installed)* | OpenWrt operating system and configuration |
| LAN Interface    | Integrated Gigabit Ethernet            | Downstream LAN connectivity                |
| WAN Interface    | USB Wi-Fi Adapter                      | Upstream wireless WAN connection           |
| Wireless Adapter | MediaTek MT7921AUN                     | Wi-Fi client connectivity                  |
| Ethernet Switch  | TP-Link TL-SG1016D                     | Distribution of wired LAN devices          |

> **Note:** Capacity values should be updated if hardware changes.

---

# Physical Topology

```text
                 Internet
                     │
                     │
           Home Wireless Network
                     │
         USB Wi-Fi Adapter (WAN)
                     │
      Dell Wyse 5070 running OpenWrt
                     │
           Gigabit Ethernet (LAN)
                     │
            TP-Link TL-SG1016D
                     │
      Homelab Servers and Clients
```

---

# Platform Selection

## Dell Wyse 5070

The Dell Wyse 5070 was selected because it provides a capable x86 platform while maintaining extremely low power consumption.

### Advantages

* Small form factor.
* Silent operation.
* Reliable business-grade hardware.
* Low energy usage.
* Native x86 compatibility.
* Excellent Linux support.
* Easily sourced on the second-hand market.

### Limitations

* Single onboard Ethernet interface.
* Additional USB adapter required for wireless WAN.
* Limited internal expansion.

Despite these limitations, the platform comfortably exceeds the processing requirements of this deployment.

---

# Wireless Adapter

## MediaTek MT7921AUN

The WAN connection uses a USB Wi-Fi adapter based on the MediaTek MT7921AUN chipset.

### Selection Criteria

* Supported by recent Linux kernels.
* Compatible with OpenWrt.
* Dual-band operation.
* USB connectivity.
* Stable driver support.

### Deployment Role

The adapter operates as a wireless client connecting OpenWrt to the upstream residential router.

This approach removes the need for an additional Ethernet cable while maintaining network separation between the homelab and the existing home network.

---

# Storage

The OpenWrt installation is hosted on the internal SSD.

The storage contains:

* OpenWrt operating system.
* Installed packages.
* System configuration.
* Logs.
* Persistent application data.

Configuration backups are performed before significant changes.

---

# Cooling and Power

The platform is intended for continuous operation.

Design considerations include:

* Low thermal output.
* Minimal power consumption.
* Quiet operation.
* Stable performance under sustained workloads.

Future plans include integration with a UPS to allow graceful shutdown during extended power outages.

---

# Hardware Compatibility

The following components have been verified during deployment:

| Component           | Status        |
| ------------------- | ------------- |
| x86 Platform        | ✅ Supported   |
| Gigabit Ethernet    | ✅ Operational |
| USB Storage Boot    | ✅ Operational |
| MediaTek MT7921AUN  | ✅ Operational |
| APK Package Manager | ✅ Operational |
| Tailscale           | ✅ Operational |

---

# Future Hardware Enhancements

Potential future improvements include:

* Dual-port Intel Ethernet adapter.
* Dedicated management interface.
* Higher-capacity SSD.
* Hardware watchdog integration.
* UPS monitoring and automated shutdown.
* Additional USB expansion where required.

These upgrades are optional and are not required for current functionality.

---

# Maintenance Considerations

Routine hardware maintenance should include:

* Inspecting ventilation and cooling paths.
* Confirming SSD health.
* Checking USB adapter seating and cable condition.
* Verifying system uptime and operating temperatures.
* Updating firmware and software where appropriate.
* Creating configuration backups before hardware modifications.

---

# Security Considerations

Physical access to the router should be restricted.

Recommendations include:

* Install the device in a secure location.
* Protect BIOS/UEFI settings with a password if appropriate.
* Disable unused boot devices where practical.
* Maintain regular OpenWrt updates.
* Keep hardware documentation separate from sensitive configuration information.

---

# Lessons Learned

During deployment, several observations were made:

* A low-power thin client provides more than enough performance for a homelab edge router.
* USB Wi-Fi adapters can successfully provide WAN connectivity when Ethernet is unavailable.
* Selecting hardware with strong Linux support significantly reduces deployment complexity.
* Careful hardware selection is often more valuable than purchasing higher-specification components that provide little practical benefit.

---

# References

* OpenWrt x86 Installation Guide
* OpenWrt Hardware Compatibility Documentation
* Linux Wireless Documentation
* MediaTek Driver Documentation
* Dell Wyse 5070 Technical Documentation
