# Systems Overview

## Purpose

Summarize the key virtual machines and workload systems in the homelab.

## Current State

- `dc-01` - Windows Server domain controller and DNS
- `ubuntu-01` - general Linux server
- `docker-01` - container host, needs verification
- `win11-01` - IT administration workstation
- `win11-02` - simulated employee workstation
- `monitor-01` - monitoring system running Prometheus and Grafana

## Architecture

- The systems layer runs on Proxmox.
- The VM set reflects infrastructure, administration, and future application needs.

## Design Decisions

- Separate identity, Linux, workstation, and container roles where possible.
- Treat planned systems as planned until deployed and verified.

## Related Documentation

- [`docs/infrastructure/overview.md`](../infrastructure/overview.md)
- [`docs/diagrams/service-relationships.md`](../diagrams/service-relationships.md)

