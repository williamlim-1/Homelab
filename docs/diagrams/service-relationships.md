# Service Relationships

## Purpose

Show how core services depend on each other.

## Scope

- Identity
- DNS
- Workstations
- Linux administration
- Container services
- Monitoring
- Stark
- Firewall services
- Shared backup storage

## Mermaid Diagram

```mermaid
flowchart TB
    AD[dc-01 Current]
    Win[Windows Clients Current]
    Lin[ubuntu-01 Current]
    Dock[docker-01 Needs Verification]
    Mon[monitor-01 Planned]
    Stark[Stark Planned]
    Backup[pve3 Shared Backup Repository Current]
    FW[OPNsense Current]
    Legacy[fw-01 Historical]

    Win --> AD
    Win --> FW
    Lin --> FW
    Dock --> FW
    AD --> Backup
    Lin --> Backup
    Mon -.-> FW
    Stark -.-> Dock
    Legacy -.-> FW
```

## Explanation

The diagram shows current dependencies and keeps planned items visibly distinct.

## Assumptions

- `monitor-01` is not yet confirmed operational.
- `docker-01` exists or is planned, but placement is not yet fully verified.
- The shared backup repository is current and supports Proxmox backups.

## Items Needing Verification

- `monitor-01` deployment state
- `docker-01` actual hosting details
- Stark deployment timeline
- Whether any additional VMs are intended to be added to backup scope

## Related Documentation

- [`docs/systems/monitoring.md`](../systems/monitoring.md)
- [`docs/applications/stark.md`](../applications/stark.md)
