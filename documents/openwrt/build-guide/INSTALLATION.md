# 02 - Installation

## Purpose

This document describes the complete installation process for deploying OpenWrt on an x86-64 platform.

The procedure has been written to be repeatable, vendor-neutral where practical, and suitable for rebuilding the router from bare hardware.

> **Note**
>
> This documentation has been sanitised for public release. Replace all placeholder values with those appropriate for your own environment.

---

# Scope

This guide covers:

* Preparing installation media
* Installing OpenWrt
* Initial boot
* First login
* Basic verification
* Internet connectivity
* Package management
* Initial backup

Configuration of networking, Wi-Fi, firewall, SSH and Tailscale are documented separately.

---

# Prerequisites

## Hardware

| Component          | Requirement                |
| ------------------ | -------------------------- |
| Router Platform    | x86-64 compatible system   |
| Storage            | Internal SSD or equivalent |
| USB Flash Drive    | Installation media         |
| Keyboard           | Initial configuration      |
| Display            | Initial installation       |
| Network Connection | Temporary internet access  |

---

## Software

Download the latest supported OpenWrt x86 image from the official OpenWrt project.

Recommended image type:

* EFI image for UEFI systems
* Combined image for direct disk installation

---

# Preparing Installation Media

## 1. Download OpenWrt

Download the latest stable x86-64 release.

Verify the download checksum where available.

---

## 2. Create Boot Media

Use an appropriate imaging utility to write the image directly to a USB flash drive.

Do **not** simply copy the image file onto the drive.

---

## 3. Configure Firmware

Access the system firmware (BIOS/UEFI).

Recommended settings:

* UEFI boot enabled
* USB boot enabled
* Secure Boot disabled (if unsupported)
* Internal SSD available as installation target

Save configuration and reboot.

---

# Installing OpenWrt

Boot from the installation USB.

When the installer starts:

1. Identify the target disk.
2. Confirm the correct destination.
3. Install OpenWrt.
4. Remove installation media.
5. Reboot.

---

# First Boot

After reboot:

Connect directly to the LAN interface.

Access the router using the default LAN address.

Log in as:

```text id="ebfq0t"
Username: root
Password: (blank)
```

Immediately configure a root password.

---

# Verify Installation

Confirm the operating system:

```sh id="3l5gvu"
cat /etc/openwrt_release
```

Confirm architecture:

```sh id="5fvrja"
uname -a
```

Confirm storage:

```sh id="rqpm1r"
df -h
```

Confirm interfaces:

```sh id="81jlwm"
ip addr
```

---

# Establish Internet Connectivity

Before installing additional packages verify:

* Interface status
* Default gateway
* DNS resolution

Useful commands:

```sh id="wmhfr8"
ip route

ping 8.8.8.8

ping openwrt.org
```

Both network connectivity and DNS resolution should succeed.

---

# Update Package Repositories

OpenWrt 25.x uses **apk**.

Update repositories:

```sh id="cc8n2k"
apk update
```

Upgrade installed packages:

```sh id="lgjx94"
apk upgrade
```

---

# Repository Notes

During deployment HTTPS repository updates initially failed with:

```text id="pzm9jd"
unexpected end of file
```

The issue was isolated to HTTPS repository access.

Temporary workaround:

* Switch repository URLs to HTTP.
* Update package indexes.
* Install certificate packages.
* Restore HTTPS repositories.

This issue was unrelated to internet connectivity.

---

# Verify Services

Confirm basic services are operational.

Examples:

```sh id="5ziczk"
service network status

service firewall status

service dropbear status
```

---

# Configure Remote Administration

Remote administration should not be considered complete until:

* SSH is operational
* Firewall configuration has been validated
* Tailscale connectivity has been verified

These procedures are documented separately.

---

# Create Initial Backup

Once installation is complete and verified:

```sh id="z29g7n"
sysupgrade -b /root/openwrt-initial-backup.tar.gz
```

Store the backup securely outside the router.

---

# Validation Checklist

The installation is considered successful when the following criteria have been met.

| Validation                       | Status |
| -------------------------------- | ------ |
| OpenWrt boots successfully       | ☐      |
| Root password configured         | ☐      |
| LAN connectivity verified        | ☐      |
| Internet connectivity verified   | ☐      |
| DNS resolution verified          | ☐      |
| Package repositories operational | ☐      |
| Packages updated                 | ☐      |
| SSH operational                  | ☐      |
| Initial backup created           | ☐      |

---

# Common Installation Issues

## USB Does Not Boot

Possible causes:

* Incorrect firmware boot mode
* USB not written correctly
* Incorrect image type
* Boot order configuration

---

## No Internet Access

Verify:

* Interface assignment
* Default route
* DNS configuration
* Physical connectivity
* Wi-Fi association (if applicable)

---

## Package Repository Errors

Symptoms:

* Repository download failures
* HTTPS errors
* Certificate validation failures

Refer to **06-PACKAGE-MANAGEMENT.md** for detailed troubleshooting.

---

# Lessons Learned

Several observations were made during deployment:

* Installing OpenWrt on x86 hardware is straightforward once firmware configuration is correct.
* Verifying internet connectivity before troubleshooting package management saves significant time.
* Package repository issues should be isolated from general networking issues.
* Creating an initial configuration backup immediately after deployment provides a reliable recovery point.
* Separating installation from configuration documentation simplifies long-term maintenance.

---

# References

* OpenWrt Installation Guide
* OpenWrt x86 Documentation
* APK Package Management Documentation
* UEFI Specification
* Linux Networking Documentation
