# Proxmox Cluster

## Purpose

Show the current Proxmox control-plane relationship.

## Scope

- Cluster `homelab`
- Nodes `pve`, `pve2`, and `pve3`
- Local storage only
- Known and unknown VM placement
- Planned backup destination

## Mermaid Diagram

```mermaid
flowchart TB
    Cluster[Cluster homelab Current]
    P1[pve Current]
    P2[pve2 Current]
    P3[pve3 Current]
    Backup[Backup Target Planned]
    HA[High Availability Needs Verification]

    Cluster --> P1
    Cluster --> P2
    Cluster --> P3
    P1 -.-> Backup
    P2 -.-> Backup
    P3 -.-> Backup
    Cluster -.-> HA
```

## Explanation

The diagram intentionally avoids implying automatic failover or shared storage.

## Assumptions

- Management is centralized through the cluster.
- Storage remains node-local unless later confirmed otherwise.

## Items Needing Verification

- Final VM placement
- Backup target details
- Shared storage status

## Related Documentation

- [`docs/infrastructure/proxmox-cluster.md`](../infrastructure/proxmox-cluster.md)

