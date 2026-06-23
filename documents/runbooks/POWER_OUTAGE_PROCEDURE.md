# POWER_OUTAGE_PROCEDURE.md

## Purpose

This document describes the operational response to a power outage.

---

# Objectives

* Protect data integrity
* Prevent filesystem corruption
* Preserve service availability
* Enable safe recovery

---

# Event Detection

Power loss is detected by the UPS.

The UPS becomes the temporary power source.

---

# Graceful Shutdown Process

Recommended service shutdown order:

1. Media Services
2. Monitoring Services
3. Storage Services
4. Security Services
5. HTTP Services
6. Proxy Services

---

# Host Shutdown

When UPS battery reaches the configured threshold:

1. Containers stop gracefully
2. Docker services stop
3. Operating system shuts down

---

# During Outage

Actions:

* Do not force power on
* Preserve remaining UPS capacity
* Monitor battery status

---

# Power Restoration

When utility power returns:

1. UPS returns to charging mode
2. Host powers on
3. Docker starts
4. Services recover

---

# Validation

Confirm:

* All stacks started
* Storage accessible
* Monitoring operational
* Backups functional

---

# Documentation

Record:

* Outage duration
* Services affected
* Recovery actions taken
