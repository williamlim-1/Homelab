# Rack Overview

## Purpose

Provide a public-safe summary of the rack-based physical organization.

## Scope

- Rack enclosure
- Switch
- Proxmox nodes
- Supporting power gear
- External firewall appliance

## Mermaid Diagram

```mermaid
flowchart TB
    Rack[10-inch Rack Current]
    SW[Homelab Switch Current]
    P1[pve Current]
    P2[pve2 Current]
    P3[pve3 Current]
    UPS[UPS Current]
    FW[OPNsense Appliance Current]

    Rack --> SW
    Rack --> P1
    Rack --> P2
    Rack --> P3
    Rack --> UPS
    FW -.-> Rack
```

## Explanation

The rack organizes the compute and switching gear, while the firewall remains physically separate.

## Assumptions

- Exact rack positions are private.
- The firewall is adjacent to the rack rather than inside it.

## Items Needing Verification

- Precise rack layout
- Any future rack expansion

## Related Documentation

- [`docs/infrastructure/rack.md`](../infrastructure/rack.md)

