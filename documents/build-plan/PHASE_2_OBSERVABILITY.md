# PHASE_2_OBSERVABILITY.md

# Phase 2 – Observability

## Purpose

Phase 2 introduces monitoring, metrics collection, and operational visibility across the Homelab environment.

This phase enables proactive management by providing insight into infrastructure health, service performance, and resource utilisation.

---

# Objectives

The objectives of this phase are:

* Implement infrastructure monitoring
* Collect host metrics
* Visualise system performance
* Establish operational dashboards
* Create performance baselines
* Improve troubleshooting capabilities

---

# Components

## Node Exporter

Responsibilities:

* Host metrics collection
* CPU monitoring
* Memory monitoring
* Disk monitoring
* Network monitoring

---

## Prometheus

Responsibilities:

* Metrics collection
* Metrics storage
* Alerting foundation
* Time-series database

---

## Grafana

Responsibilities:

* Dashboard visualisation
* Performance reporting
* Capacity planning
* Operational visibility

---

# Monitoring Architecture

```text id="jv6s6w"
Ubuntu Server
      │
      ▼
Node Exporter
      │
      ▼
 Prometheus
      │
      ▼
  Grafana
```

---

# Metrics Collected

## Infrastructure

* CPU utilisation
* Memory utilisation
* Disk usage
* Disk I/O
* Network throughput

---

## Docker

* Container status
* Container uptime
* Resource consumption
* Service availability

---

## Platform

* Host health
* Service health
* Capacity trends

---

# Operational Benefits

The monitoring platform provides:

* Faster troubleshooting
* Resource visibility
* Capacity planning
* Historical analysis
* Service validation

---

# Future Enhancements

Planned additions include:

* Alerting
* Centralised logging
* Security monitoring
* Uptime monitoring
* Infrastructure reporting

---

# Success Criteria

Phase 2 is complete when:

* Metrics are collected successfully
* Dashboards are operational
* Historical data is retained
* Resource utilisation is visible
* Monitoring documentation is completed

---

# Skills Demonstrated

* Monitoring
* Observability
* Performance Analysis
* Metrics Collection
* Capacity Planning
* Dashboard Development
