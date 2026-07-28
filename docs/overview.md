# Homelab Overview

## Purpose

Provide a single high-level view of the homelab and its current technical state.

## Current Environment

- Dedicated physical OPNsense firewall
- Three-node Proxmox VE cluster named `homelab`
- Active Directory and internal DNS on `dc-01`
- Ubuntu Server workload on `ubuntu-01`
- Windows Server administration and directory services on `dc-01`
- Windows client VMs used for lab and admin workflows
- Tailscale for secure remote administration
- Centralized Proxmox backups on `pve3-backup`
- Backup storage exported from `pve3` and used as the shared Proxmox backup target
- Docker and monitoring work still evolving
- Planned internal application work, including OwlHQ

## Architecture

The homelab is organized around a dedicated edge firewall, clustered virtualization, identity services, and a separate backup repository.

- OPNsense provides the network boundary and remote-access entry point
- Proxmox hosts the virtual machines and cluster workloads
- `dc-01` anchors identity and DNS
- `ubuntu-01` provides the Linux administration and general server workload
- `pve3` exports the shared NFS backup repository used by Proxmox
- `pve3-backup` is the shared backup target for scheduled VM backups

## Current Status

- Proxmox nodes are reachable and can SSH to each other by hostname
- `ubuntu-01` can be reached from `pve` with `ssh will@ubuntu-01`
- `dc-01` and `ubuntu-01` are included in the scheduled Proxmox backup job
- The backup job runs daily at 01:00 to shared storage on `pve3-backup`
- Backup compression is set to `zstd`
- Retention keeps daily, weekly, monthly, and yearly copies according to the current job policy
- A successful backup test has already completed for `dc-01`
- Restore testing is still the next proof step

## Related Documentation

- [`README.md`](../README.md)
- [`docs/architecture/overview.md`](architecture/overview.md)
- [`docs/infrastructure/overview.md`](infrastructure/overview.md)
- [`docs/identity/overview.md`](identity/overview.md)
- [`docs/systems/overview.md`](systems/overview.md)
- [`docs/remote-access/overview.md`](remote-access/overview.md)
- [`docs/operations/overview.md`](operations/overview.md)
- [`docs/journal/working-journal.md`](journal/working-journal.md)
- [`docs/goals.md`](goals.md)
