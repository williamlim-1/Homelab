# High-Level Architecture

## Purpose

Provide a public-safe view of the homelab at a system level.

## Scope

- Internet edge
- Firewall boundary
- Proxmox cluster
- Identity services
- Backup repository
- Windows and Linux workloads
- Remote access
- Planned monitoring and application layers

## Mermaid Diagram

```mermaid
flowchart TB
    Internet[Internet]
    OEC[OEC Fiber Router]
    FW[Dedicated Physical OPNsense Firewall]
    SW[Homelab Switch]
    PVE[Proxmox Cluster]
    AD[Active Directory and DNS]
    Linux[Ubuntu and Linux Services]
    Clients[Windows Client VMs]
    Backup[pve3 Shared Backup Repository]
    Docker[Docker Services]
    Monitor[Monitoring - Planned]
    Owl[OwlHQ - Planned]
    Remote[Remote Tailscale Devices]

    Internet --> OEC
    OEC --> FW
    FW --> SW
    SW --> PVE
    PVE --> AD
    PVE --> Linux
    PVE --> Clients
    PVE --> Backup
    PVE --> Docker
    PVE -.-> Monitor
    PVE -.-> Owl
    Remote -->|Encrypted Tailscale connection| FW
```

## Explanation

The diagram shows the firewall as the edge boundary and the Proxmox cluster as the primary compute layer beneath it.

## Assumptions

- Public documentation should not expose IP addresses.
- Monitoring and OwlHQ are planned, not yet confirmed as production services.
- The shared backup repository is current, not planned.

## Items Needing Verification

- Exact placement of some services within the cluster
- Whether monitoring is operational
- Whether OwlHQ has any deployed components

## Related Documentation

- [`docs/architecture/high-level-architecture.md`](../architecture/high-level-architecture.md)
