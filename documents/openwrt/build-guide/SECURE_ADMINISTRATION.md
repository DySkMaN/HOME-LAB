# 07 – Secure Administration

## Purpose

This document defines the administrative access model for the OpenWrt router.

The objective is to provide secure, reliable and auditable methods for managing the router while minimising the exposure of administrative services.

This document establishes the operational standard for authentication, remote administration, privilege management and administrative best practices.

---

# Scope

This document covers:

* Administrative access philosophy
* Console access
* SSH administration
* Remote administration
* Authentication
* Password management
* Future SSH key deployment
* Session management
* Administrative validation
* Security considerations

Tailscale deployment is documented separately in **09 – Remote Administration (Tailscale)**.

---

# Administrative Philosophy

The router is considered critical infrastructure.

Administrative access should therefore satisfy the following principles:

* Minimise exposed services.
* Require authentication.
* Encrypt all remote administration.
* Restrict administration to authorised operators.
* Prefer secure remote access over public exposure.
* Record significant configuration changes.
* Keep administrative methods consistent.

---

# Administrative Methods

| Method               | Purpose                         | Status                   |
| -------------------- | ------------------------------- | ------------------------ |
| Local Console        | Recovery and initial deployment | Supported                |
| SSH                  | Routine administration          | Operational              |
| Tailscale            | Secure remote access            | Operational              |
| Web Interface (LuCI) | Optional                        | Disabled unless required |

The preferred administration method is SSH over Tailscale.

---

# Local Console Access

The local console provides administrative access when:

* Initial deployment is performed.
* Network configuration is unavailable.
* Remote administration fails.
* Disaster recovery is required.

Physical access should always remain available as a recovery method.

---

# SSH Administration

OpenWrt uses Dropbear as the default SSH server.

Primary responsibilities:

* Secure shell access.
* Encrypted administration.
* Remote command execution.
* Configuration management.

Verify service status:

```sh
service dropbear status
```

Confirm the service is listening:

```sh
netstat -ln | grep :22
```

---

# Authentication Strategy

## Current Configuration

Current deployment uses:

* Username/password authentication.
* Administrative root account.
* Strong unique password.

Passwords should never be reused across systems.

---

## Future Configuration

Future enhancements include:

* SSH public key authentication.
* Password authentication disabled.
* Hardware security keys where appropriate.
* Multi-factor authentication for remote administration.

---

# Password Management

Administrative passwords should:

* Be unique.
* Be randomly generated.
* Be stored in a password manager.
* Never be committed to documentation or version control.

Password changes:

```sh
passwd
```

---

# Remote Administration

Remote administration is performed using Tailscale.

Advantages include:

* Encrypted communication.
* Automatic NAT traversal.
* Identity-based access.
* No inbound port forwarding.
* Reduced attack surface.

The router should not expose SSH directly to the public internet.

---

# Administrative Workflow

Recommended workflow:

1. Connect to the tailnet.
2. Verify router availability.
3. Establish SSH session.
4. Perform required maintenance.
5. Validate changes.
6. Create configuration backup where appropriate.
7. Document significant modifications.

---

# Session Management

Administrative sessions should:

* Remain active only while required.
* Be terminated after maintenance.
* Avoid multiple concurrent administrative sessions where practical.

Long-running configuration changes should be planned and validated before execution.

---

# Configuration Validation

Verify administrative access.

## SSH

```sh
ssh root@<router>
```

Confirm:

* Authentication succeeds.
* Shell access available.
* Commands execute normally.

---

## Service Status

```sh
service dropbear status
```

---

## Listening Ports

```sh
netstat -ln | grep :22
```

---

## Remote Connectivity

Verify remote administration using:

```sh
tailscale status
```

---

# Recovery Procedures

If remote administration fails:

1. Verify Tailscale connectivity.
2. Verify SSH service.
3. Verify firewall.
4. Review system logs.
5. Access the local console.

Never rely exclusively on remote administration.

---

# Troubleshooting

## SSH Connection Refused

Possible causes:

* SSH service stopped.
* Firewall configuration.
* Incorrect destination.
* Authentication failure.

Verify:

```sh
service dropbear status
```

---

## SSH Timeout

Investigate:

* Network connectivity.
* Firewall policy.
* Tailscale.
* Interface assignment.

Packet capture:

```sh
tcpdump -ni tailscale0 tcp port 22
```

---

## Authentication Failure

Verify:

* Username.
* Password.
* SSH configuration.
* Root authentication policy.

Review:

```sh
logread
```

---

# Security Considerations

Administrative services represent the highest-value target on the router.

Security objectives include:

* Encrypt all administrative traffic.
* Restrict access to authorised users.
* Avoid exposing SSH to the internet.
* Keep authentication credentials secure.
* Apply software updates promptly.
* Monitor authentication failures.

---

# Design Decisions

## Why SSH?

SSH provides:

* Encrypted communication.
* Mature authentication.
* Extensive tooling.
* Broad platform support.
* Automation capability.

---

## Why Tailscale?

Rather than exposing SSH publicly:

* Identity controls access.
* No inbound firewall rules required.
* NAT traversal is automatic.
* Public attack surface is reduced.

---

## Why Local Console?

Network failures should never prevent administrative recovery.

Maintaining console access ensures the platform remains recoverable under all operating conditions.

---

# Lessons Learned

Deployment highlighted several operational considerations:

* Packet captures are invaluable when diagnosing remote administration issues.
* Firewall configuration must account for virtual interfaces such as `tailscale0`.
* Tailscale should manage its own interface rather than relying on a manually created OpenWrt network definition.
* Layer-by-layer validation significantly reduces troubleshooting time.

---

# Future Improvements

Potential future enhancements include:

* SSH key authentication.
* Password authentication disabled.
* Hardware-backed authentication.
* Bastion host integration.
* Administrative audit logging.
* Configuration change tracking.
* Automated compliance validation.

---

# Administrative Checklist

Before performing maintenance:

* Configuration backup completed.
* SSH connectivity verified.
* Tailscale operational.
* System time synchronised.

After maintenance:

* Services validated.
* Logs reviewed.
* Connectivity verified.
* Documentation updated.
* Backup created if required.

---

# References

* OpenWrt Dropbear Documentation
* OpenSSH Documentation
* Linux Security Best Practices
* Tailscale Documentation
* CIS Benchmarks (Linux)
