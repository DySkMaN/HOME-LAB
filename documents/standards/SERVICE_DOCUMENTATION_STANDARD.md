# SERVICE_DOCUMENTATION_STANDARD.md

## Purpose

This document defines the minimum documentation requirements for all services deployed within the Homelab environment.

Every service should be documented to support:

* Deployment
* Maintenance
* Troubleshooting
* Recovery

---

# Required Documentation

Every service directory should contain:

```text
service/
├── compose.yml
├── README.md
├── README_INTERNAL.md
└── TROUBLESHOOTING.md
```

---

# README.md

Audience:

* Recruiters
* Contributors
* Other Homelab builders
* Public repository visitors

Purpose:

Provide a high-level overview of the service.

---

## Required Sections

### Purpose

What the service does.

---

### Containers

Container names and functions.

---

### Dependencies

Required supporting services.

Examples:

* Reverse proxy
* Databases
* Monitoring

---

### Networks

Docker networks used.

---

### Volumes

Persistent storage locations.

---

### Environment Variables

Non-sensitive variables only.

---

### Deployment

High-level deployment procedure.

---

### Validation

How service health is verified.

---

### Future Improvements

Planned enhancements.

---

# README_INTERNAL.md

Audience:

Platform administrator only.

Purpose:

Provide sufficient detail to rebuild and maintain the service.

---

## Required Sections

### Architecture

Service relationships.

---

### Configuration

Important configuration files.

---

### Volumes

Exact host paths.

---

### Secrets

Secret references.

Never commit secret values.

---

### Backup Requirements

Service-specific backup procedures.

---

### Recovery Requirements

Service-specific recovery procedures.

---

# TROUBLESHOOTING.md

Audience:

Operators and maintainers.

Purpose:

Capture operational knowledge gained through real incidents.

---

## Required Sections

### Symptoms

Observed behaviour.

---

### Root Cause

Underlying issue.

---

### Diagnostics

Commands and checks performed.

---

### Resolution

Actions taken.

---

### Prevention

How future occurrences can be avoided.

---

# Goal

Every service should be deployable, maintainable, recoverable, and supportable using documentation alone.
