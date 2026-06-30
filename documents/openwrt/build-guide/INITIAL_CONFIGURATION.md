# 03 - Initial Configuration

## Purpose

This document describes the initial configuration tasks performed immediately after a successful OpenWrt installation.

The objective is to establish a secure, repeatable baseline configuration before implementing networking, firewall policies, wireless connectivity, remote access, or additional services.

This document intentionally focuses on the operating system itself rather than feature-specific configuration.

---

# Scope

This guide covers:

* Initial login
* Root account configuration
* Hostname configuration
* Time synchronisation
* Basic network verification
* Package repository configuration
* System updates
* Secure Shell (SSH)
* Configuration backup

Wireless networking, firewall configuration, package management and Tailscale are documented separately.

---

# Initial Login

Following installation, connect directly to the LAN interface and log in using the default credentials.

Immediately configure a root password.

```sh
passwd
```

Verify authentication by opening a new SSH session.

---

# Configure Hostname

Assign a descriptive hostname appropriate for the environment.

Example:

```sh
uci set system.@system[0].hostname='openwrt'
uci commit system
service system reload
```

Verify:

```sh
hostname
```

---

# Configure Time Zone

Correct system time is required for:

* TLS certificate validation
* Logging
* Scheduled tasks
* Package management
* Security auditing

Configure the appropriate timezone.

Example:

```sh
uci set system.@system[0].zonename='Australia/Sydney'
uci set system.@system[0].timezone='AEST-10AEDT,M10.1.0,M4.1.0/3'
uci commit system
service system reload
```

Verify:

```sh
date
```

---

# Configure NTP

Enable automatic time synchronisation.

Verify:

```sh
service sysntpd status
```

Confirm system time updates correctly after internet connectivity is established.

---

# Verify Network Interfaces

Inspect all detected interfaces.

```sh
ip addr
```

Review routing table.

```sh
ip route
```

Confirm:

* LAN interface present
* WAN interface detected
* Default gateway configured
* No duplicate interfaces

---

# Verify Internet Connectivity

Confirm basic network functionality.

Test IP connectivity:

```sh
ping 1.1.1.1
```

Test DNS:

```sh
ping openwrt.org
```

Expected outcome:

* Successful ICMP replies
* DNS resolution functioning correctly

---

# Configure Package Repositories

OpenWrt 25.x uses the APK package manager.

Update package indexes.

```sh
apk update
```

Upgrade installed packages.

```sh
apk upgrade
```

---

## Repository Validation

Repository configuration should satisfy the following:

* Package indexes download successfully
* Repository signatures validate correctly
* HTTPS repositories function normally

If HTTPS repositories fail, refer to **06-PACKAGE-MANAGEMENT.md**.

---

# Install Essential Packages

Install only packages required for baseline administration.

Typical examples:

* Tailscale
* tcpdump
* curl
* bind-tools
* nano or vim (optional)

Avoid installing unnecessary software during the baseline build.

---

# Configure SSH

Verify that Dropbear is operational.

```sh
service dropbear status
```

Confirm the service is listening.

```sh
netstat -ln | grep :22
```

Recommended actions:

* Set a strong root password.
* Verify password authentication.
* Confirm SSH access from the LAN before enabling remote administration.

Further hardening is documented in **07-SSH.md**.

---

# Verify Firewall

Confirm the firewall configuration is valid.

```sh
/sbin/fw4 check
```

Inspect active nftables rules.

```sh
nft list tables
```

The firewall should validate successfully before making any configuration changes.

---

# Configure Logging

Review the system log.

```sh
logread
```

Look for:

* Driver errors
* Network failures
* Package issues
* Authentication errors
* Hardware warnings

Resolve unexpected errors before continuing.

---

# Create Initial System Backup

After completing the baseline configuration:

```sh
sysupgrade -b /root/openwrt-baseline-backup.tar.gz
```

Copy the archive to external storage.

This backup represents the clean operating system baseline.

---

# Validation Checklist

| Validation                       | Status |
| -------------------------------- | ------ |
| Root password configured         | ☐      |
| Hostname configured              | ☐      |
| Time synchronised                | ☐      |
| NTP operational                  | ☐      |
| Internet connectivity verified   | ☐      |
| DNS functioning                  | ☐      |
| Package repositories operational | ☐      |
| Packages updated                 | ☐      |
| SSH operational                  | ☐      |
| Firewall validated               | ☐      |
| Baseline backup created          | ☐      |

---

# Common Issues

## Incorrect System Time

Symptoms:

* HTTPS failures
* Certificate validation errors
* Authentication failures

Verify:

```sh
date
```

Confirm NTP is operational.

---

## Package Update Failures

Possible causes:

* DNS failure
* Incorrect repository configuration
* Certificate validation
* Internet connectivity

Refer to **06-PACKAGE-MANAGEMENT.md**.

---

## SSH Unavailable

Verify:

```sh
service dropbear status
netstat -ln | grep :22
```

Confirm firewall configuration permits management traffic.

Refer to **07-SSH.md**.

---

# Security Considerations

The baseline configuration should satisfy the following principles:

* Administrative password configured.
* Default credentials removed.
* Remote administration disabled until verified.
* System fully updated.
* Configuration backed up.
* No unnecessary packages installed.
* Logging operational.

---

# Lessons Learned

Several observations were made during deployment:

* Completing baseline validation before feature configuration significantly reduces troubleshooting complexity.
* System time should be verified before investigating TLS or package repository issues.
* Incremental backups provide reliable recovery points during deployment.
* A minimal baseline simplifies long-term maintenance and improves system reliability.

---

# References

* OpenWrt User Guide
* OpenWrt APK Documentation
* Linux Networking Documentation
* OpenWrt Firewall (fw4) Documentation
* Dropbear Documentation
