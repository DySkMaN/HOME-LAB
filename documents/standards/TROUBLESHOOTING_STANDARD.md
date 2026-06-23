# TROUBLESHOOTING_STANDARD.md

## Purpose

This document defines how troubleshooting information should be captured within the Homelab environment.

The objective is to create a permanent operational knowledge base.

---

# Philosophy

Problems will occur.

The goal is not to avoid every problem.

The goal is to:

* Detect issues quickly
* Resolve them efficiently
* Document lessons learned

---

# When To Document

Create a troubleshooting entry when:

* A service outage occurs
* Unexpected behaviour is observed
* Significant diagnostic effort is required
* A non-obvious fix is discovered
* A rebuild uncovers important lessons

---

# Required Structure

Every troubleshooting entry should contain:

---

## Problem Summary

Brief description of the issue.

---

## Symptoms

Observed behaviour.

Examples:

* Service unavailable
* HTTP errors
* Container restart loops
* Authentication failures

---

## Environment

Relevant platform details.

Examples:

* Service
* Stack
* Docker version
* Operating system

---

## Diagnostics

Commands executed.

Examples:

```bash
docker ps
docker logs
docker compose config
```

Document:

* What was checked
* Why it was checked
* Results

---

## Root Cause

The actual reason the issue occurred.

Avoid documenting assumptions.

---

## Resolution

The exact steps used to resolve the issue.

---

## Validation

How success was confirmed.

Examples:

* Service accessible
* Container healthy
* Monitoring restored

---

## Prevention

Actions taken to reduce future occurrences.

Examples:

* Documentation updates
* Configuration improvements
* Additional monitoring

---

# Troubleshooting Workflow

```text
Issue Detected
      │
      ▼
Collect Evidence
      │
      ▼
Identify Cause
      │
      ▼
Implement Fix
      │
      ▼
Validate
      │
      ▼
Document
```

---

# Repository Requirements

Troubleshooting documentation should:

* Be factual
* Be reproducible
* Avoid blame
* Focus on technical findings

---

# Goal

Troubleshooting documentation should reduce future resolution times and improve operational knowledge across the platform.
