# 06 – System Maintenance & Package Management

## Purpose

This document defines the operational procedures for maintaining the OpenWrt operating system throughout its lifecycle.

The objective is to ensure the platform remains secure, stable and reproducible by establishing consistent practices for software installation, updates, configuration management, backups and system validation.

This document is intended for ongoing operations after the initial deployment has been completed.

---

# Scope

This document covers:

* APK package management
* Repository management
* Package installation
* System updates
* Configuration management
* Backup checkpoints
* Upgrade planning
* Routine maintenance
* Operational validation
* Recovery planning

---

# Maintenance Philosophy

The OpenWrt router is considered critical infrastructure within the homelab.

All maintenance activities should follow these principles:

* Make one change at a time.
* Validate every change.
* Create a backup before major modifications.
* Keep software up to date.
* Minimise unnecessary packages.
* Document significant configuration changes.
* Prefer stability over frequent feature upgrades.

---

# Package Management

## Package Manager

OpenWrt 25.x uses the **APK** package manager.

Unlike previous OpenWrt releases, `opkg` is no longer used.

Useful commands:

```sh
apk update
apk upgrade
apk search <package>
apk info <package>
apk add <package>
apk del <package>
apk list --installed
```

---

# Repository Configuration

Package repositories are defined within:

```text
/etc/apk/repositories.d/
```

Typical files include:

```text
distfeeds.list
customfeeds.list
```

Only trusted repositories should be configured.

Avoid using unofficial repositories unless absolutely necessary.

---

# Repository Validation

After any repository changes:

```sh
apk update
```

Successful validation should:

* Download package indexes.
* Verify repository signatures.
* Complete without errors.

---

# Installing Packages

Before installing software:

Consider whether the package:

* Solves a genuine operational requirement.
* Introduces unnecessary complexity.
* Increases the attack surface.
* Has long-term maintenance implications.

Install packages individually whenever practical.

Example:

```sh
apk add tcpdump
```

Validate installation:

```sh
apk info tcpdump
```

---

# Removing Packages

Unused software should be removed.

Example:

```sh
apk del <package>
```

Review installed packages periodically to reduce attack surface and simplify maintenance.

---

# Package Selection Philosophy

Additional software should satisfy at least one of the following objectives:

* Improves security.
* Improves reliability.
* Simplifies administration.
* Enables monitoring.
* Supports troubleshooting.
* Provides required functionality.

Packages should not be installed solely for experimentation on production infrastructure.

---

# System Updates

Routine updates should follow a controlled process.

## Step 1

Create a configuration backup.

```sh
sysupgrade -b /root/pre-update-backup.tar.gz
```

---

## Step 2

Update package indexes.

```sh
apk update
```

---

## Step 3

Upgrade installed packages.

```sh
apk upgrade
```

---

## Step 4

Review logs.

```sh
logread
```

---

## Step 5

Verify services.

Examples:

```sh
service network status
service firewall status
service dropbear status
```

---

## Step 6

Confirm internet connectivity.

```sh
ping openwrt.org
```

---

# Configuration Management

Configuration files should be treated as production assets.

Recommended practices:

* Record significant changes.
* Backup before modification.
* Test changes immediately.
* Avoid unnecessary manual edits.

---

# Backup Strategy

Configuration backups should be created:

* Before upgrades.
* Before package installation.
* Before firewall changes.
* Before network modifications.
* Before remote access changes.

Example:

```sh
sysupgrade -b /root/openwrt-backup.tar.gz
```

Store backups outside the router.

---

# Validation Checklist

After maintenance activities verify:

| Validation                | Status |
| ------------------------- | ------ |
| Package update successful | ☐      |
| Firewall operational      | ☐      |
| Network operational       | ☐      |
| Internet connectivity     | ☐      |
| DNS resolution            | ☐      |
| SSH operational           | ☐      |
| Tailscale operational     | ☐      |
| System logs reviewed      | ☐      |

---

# Routine Maintenance Schedule

## Weekly

* Review system logs.
* Check available storage.
* Verify internet connectivity.
* Confirm Tailscale connectivity.

---

## Monthly

* Update installed packages.
* Create configuration backup.
* Review installed packages.
* Validate firewall operation.

---

## Quarterly

* Review configuration documentation.
* Remove obsolete packages.
* Test restore procedures.
* Review security settings.

---

# Troubleshooting

## Repository Errors

Possible causes:

* Internet connectivity.
* DNS resolution.
* Certificate validation.
* Repository configuration.

Verify:

```sh
apk update
ping openwrt.org
```

---

## Package Installation Failure

Check:

* Repository availability.
* Package name.
* Storage availability.
* Network connectivity.

---

## Upgrade Failure

Verify:

* Backup exists.
* Disk space available.
* System logs.
* Package repositories.

---

# Security Considerations

Operational maintenance should always prioritise security.

Recommendations include:

* Install only required software.
* Remove obsolete packages.
* Apply security updates promptly.
* Verify package sources.
* Backup before significant changes.
* Regularly review installed software.

---

# Design Decisions

## Why APK?

APK provides:

* Faster package management.
* Modern dependency handling.
* Improved repository support.
* Better long-term maintainability.

---

## Why Incremental Maintenance?

Small, validated changes:

* Reduce troubleshooting complexity.
* Simplify rollback.
* Improve reliability.
* Reduce operational risk.

---

## Why Regular Backups?

Configuration backups provide:

* Rapid recovery.
* Safe experimentation.
* Simplified hardware replacement.
* Disaster recovery capability.

---

# Lessons Learned

Operational experience during deployment identified several important practices:

* Repository failures should be investigated independently from general networking issues.
* Backup creation before maintenance significantly reduces operational risk.
* Installing only necessary packages improves long-term stability.
* Small, incremental updates are easier to validate than large maintenance windows.
* Consistent validation after every change reduces configuration drift.

---

# Future Improvements

Potential future enhancements include:

* Automated configuration backups.
* Scheduled update notifications.
* Configuration version control.
* Centralised logging.
* Automated health checks.
* Infrastructure monitoring.
* Configuration compliance reporting.

---

# References

* OpenWrt Documentation
* APK Package Manager Documentation
* Linux System Administration Best Practices
* OpenWrt Release Notes
* OpenWrt Security Advisories
