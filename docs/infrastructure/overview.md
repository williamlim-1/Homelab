# Infrastructure Overview

## Purpose

Summarize the core infrastructure that underpins the homelab.

## Overview

The homelab is built around a dedicated physical OPNsense firewall, a three-node Proxmox cluster, internal identity services, and a compact physical rack.

## Current State

- Dedicated physical OPNsense firewall
- Three-node Proxmox cluster named `homelab`
- Active Directory and DNS on `dc-01`
- Ubuntu server workload on `ubuntu-01`
- Windows client VMs are available for lab and admin workflows
- Docker and monitoring work are still evolving
- Tailscale provides remote administration
- Shared NFS backup storage is implemented on `pve3` and used by Proxmox backup jobs

## Proxmox Cluster Specs

### `pve`

- CPU: Intel Core i7-9700T
- Threads: 8
- RAM: 32 GB
- Storage: 1 TB SSD
- Boot mode: UEFI

### `pve2`

- CPU: Intel Core i7-8700T
- Threads: 12
- RAM: 16 GB
- Storage: 512 GB SSD
- Boot mode: UEFI

### `pve3`

- CPU: Needs Verification
- Threads: 6
- RAM: 32 GB
- Storage: 1 TB HDD and 512 GB SSD
- Boot mode: Needs Verification

## Cluster Communication

Passwordless SSH is configured between `pve`, `pve2`, and `pve3` using ED25519 key pairs.

This allows each Proxmox node to reach the others by hostname without interactive password prompts, which supports centralized administration, file transfer, health checks, and future automation.

## Current State Notes

- Shared backup storage is now in place for Proxmox VM backups.
- High availability is not currently configured.
- Automatic failover is not currently documented.

## Architecture

- OPNsense forms the edge boundary and routing layer.
- Proxmox provides the virtualization layer for guests.
- Identity and name resolution are anchored on `dc-01`.
- The rack organizes the small-footprint physical environment.

## Design Decisions

- Keep the firewall separate from virtualization.
- Use Proxmox as the primary compute substrate.
- Centralize identity in Active Directory.
- Track sensitive operational data in private documentation.

## Related Documentation

- [`docs/diagrams/high-level-architecture.md`](../diagrams/high-level-architecture.md)
- [`docs/identity/overview.md`](../identity/overview.md)
- [`docs/systems/overview.md`](../systems/overview.md)
- [`docs/operations/overview.md`](../operations/overview.md)
