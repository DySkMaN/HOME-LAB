# OpenWrt Build Book

## Overview

This Build Book documents the complete lifecycle of deploying, configuring, securing, operating and maintaining the OpenWrt router used within the homelab.

The documentation has been written to allow the environment to be rebuilt from bare hardware while also serving as operational documentation for ongoing administration and troubleshooting.

All documentation has been sanitised for public release. Replace placeholder values with those appropriate for your own environment.

---

# Build Philosophy

The deployment follows several guiding principles.

* Build incrementally.
* Validate each phase before progressing.
* Keep configurations simple and reproducible.
* Maintain complete documentation.
* Secure the platform before exposing services.
* Create recovery points throughout the deployment.
* Minimise unnecessary software and complexity.

Each phase concludes with a validation checklist to ensure the system is operating correctly before moving to the next stage.

---

# Build Phases

## Phase 1 – Hardware Preparation

**Objective**

Prepare and verify the physical hardware platform.

**Deliverables**

* Hardware assembled
* Installation media created
* Firmware configured
* Boot process verified

**Documentation**

* README.md
* 01-HARDWARE.md

**Completion Criteria**

* Hardware successfully powers on.
* Installation media boots correctly.
* Target storage is detected.

---

## Phase 2 – Operating System Installation

**Objective**

Install OpenWrt and establish a functional operating system.

**Deliverables**

* OpenWrt installed
* Initial login completed
* Internet connectivity established
* Package repositories operational

**Documentation**

* 02-INSTALLATION.md

**Completion Criteria**

* Operating system installed.
* Internet access verified.
* Package manager functioning.
* Initial system backup created.

---

## Phase 3 – Baseline Configuration

**Objective**

Transform the default installation into a secure baseline suitable for production configuration.

**Deliverables**

* Hostname configured
* Time synchronised
* Root credentials secured
* System updated
* SSH operational
* Baseline backup completed

**Documentation**

* 03-INITIAL-CONFIGURATION.md

**Completion Criteria**

* System fully updated.
* Administrative access verified.
* Baseline configuration backed up.

---

## Phase 4 – Network Architecture

**Objective**

Configure the logical network design.

**Deliverables**

* Interface assignments
* LAN configuration
* WAN configuration
* Routing validation

**Documentation**

* 04-NETWORK-DESIGN.md

**Completion Criteria**

* Network topology operational.
* Routing validated.
* Internet connectivity confirmed.

---

## Phase 5 – Wireless WAN

**Objective**

Configure wireless connectivity to the upstream network.

**Deliverables**

* Wireless adapter configured
* Authentication verified
* Stable WAN connection

**Documentation**

* 05-WIFI-CONFIGURATION.md

**Completion Criteria**

* Wireless WAN operational.
* Stable internet connectivity.
* Automatic reconnection verified.

---

## Phase 6 – Software Management

**Objective**

Maintain software lifecycle management.

**Deliverables**

* Repository configuration
* Package installation
* Update procedures
* Upgrade procedures

**Documentation**

* 06-PACKAGE-MANAGEMENT.md

**Completion Criteria**

* Packages install successfully.
* Updates complete without errors.
* Repository integrity verified.

---

## Phase 7 – Secure Administration

**Objective**

Provide secure local administration.

**Deliverables**

* SSH configured
* Administrative access validated
* Security settings reviewed

**Documentation**

* 07-SSH.md

**Completion Criteria**

* Local administration operational.
* Authentication verified.
* Access restrictions documented.

---

## Phase 8 – Firewall

**Objective**

Implement default-deny firewall policy.

**Deliverables**

* Firewall zones
* Interface assignments
* Traffic policies
* Validation testing

**Documentation**

* 08-FIREWALL.md

**Completion Criteria**

* Firewall active.
* Required services accessible.
* Unauthorised traffic blocked.

---

## Phase 9 – Remote Administration

**Objective**

Enable secure remote access using Tailscale.

**Deliverables**

* Tailscale installed
* Tailnet authentication
* Firewall integration
* Remote SSH

**Documentation**

* 09-TAILSCALE.md

**Completion Criteria**

* Remote administration operational.
* Remote SSH verified.
* Firewall correctly integrates with `tailscale0`.

---

## Phase 10 – Remote Network Access

**Objective**

Provide secure access to internal infrastructure.

**Deliverables**

* Subnet routing
* Route advertisement
* Access validation

**Documentation**

* 10-SUBNET-ROUTING.md

**Completion Criteria**

* Internal devices reachable remotely.
* Routes approved.
* Connectivity validated.

---

## Phase 11 – Backup and Recovery

**Objective**

Protect the router configuration.

**Deliverables**

* Configuration backups
* Recovery procedures
* Disaster recovery testing

**Documentation**

* 11-BACKUP-RESTORE.md

**Completion Criteria**

* Backup verified.
* Restore procedure documented.
* Recovery tested.

---

## Phase 12 – Lifecycle Management

**Objective**

Maintain long-term platform reliability.

**Deliverables**

* Upgrade procedures
* Firmware management
* Package maintenance

**Documentation**

* 12-UPGRADES.md

**Completion Criteria**

* Upgrade process documented.
* Rollback strategy documented.

---

## Phase 13 – Troubleshooting

**Objective**

Provide operational diagnostics.

**Deliverables**

* Common faults
* Root cause analysis
* Resolution procedures

**Documentation**

* 13-TROUBLESHOOTING.md

**Completion Criteria**

* Common operational issues documented.
* Recovery procedures validated.

---

## Phase 14 – Operations Reference

**Objective**

Provide a quick operational reference.

**Deliverables**

* Frequently used commands
* Service management
* Diagnostics
* Verification commands

**Documentation**

* 14-COMMAND-REFERENCE.md

**Completion Criteria**

* Operational reference complete.
* Frequently used administrative tasks documented.

---

# Validation Gates

Each phase must be fully validated before progressing to the next.

This approach provides:

* Smaller troubleshooting scope.
* Easier rollback.
* Higher deployment reliability.
* Better change management.
* Clear operational checkpoints.

---

# Documentation Standards

Each document in this Build Book follows a consistent structure:

1. Purpose
2. Scope
3. Background
4. Design Decisions
5. Prerequisites
6. Implementation
7. Validation
8. Troubleshooting
9. Security Considerations
10. Lessons Learned
11. References

Maintaining a consistent structure improves readability, simplifies maintenance, and allows future additions to integrate seamlessly.
