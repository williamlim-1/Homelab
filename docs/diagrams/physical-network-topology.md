# Physical Network Topology

## Purpose

Document the physical infrastructure layout at a high level.

## Scope

- OEC Fiber equipment
- OEC router
- Dedicated OPNsense appliance
- Homelab rack and switch
- Proxmox nodes
- Workstation connection
- UPS
- Proposed backup computer

## Mermaid Diagram

```mermaid
flowchart LR
    Internet[Internet]
    OEC[EOC/OEC Fiber Equipment]
    Router[OEC Router]
    FW[Dedicated Physical OPNsense Firewall]
    SW[TP-Link Homelab Switch]
    Rack[10-inch Rack]
    P1[pve]
    P2[pve2]
    P3[pve3]
    WS[Workstation]
    UPS[UPS]
    Backup[Proposed Backup Computer]

    Internet --> OEC --> Router --> FW --> SW --> Rack
    SW --> P1
    SW --> P2
    SW --> P3
    SW --> WS
    UPS --> FW
    UPS --> SW
    UPS --> P1
    UPS --> P2
    UPS --> P3
    SW -.-> Backup
```

## Explanation

This diagram focuses on physical connectivity and organizational layout, not precise rack units or private labels.

## Assumptions

- The unmanaged switch is the current aggregation point.
- The firewall sits outside the Proxmox cluster.

## Items Needing Verification

- Final rack placement
- Exact UPS coverage
- Backup computer deployment status

## Related Documentation

- [`docs/architecture/physical-topology.md`](../architecture/physical-topology.md)

