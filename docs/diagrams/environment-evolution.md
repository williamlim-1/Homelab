# Environment Evolution

## Purpose

Show how the homelab changed over time.

## Scope

- June 26, 2026 - Initial Proxmox and Ubuntu environment
- July 10, 2026 - Two-node cluster
- July 12, 2026 - QEMU Guest Agent
- July 12, 2026 - Windows Server and Active Directory
- July 24, 2026 - Third Proxmox node
- July 25, 2026 - OPNsense and Tailscale deployment
- July 26, 2026 - Passwordless SSH between Proxmox nodes
- July 27, 2026 - Centralized Proxmox backup repository

## Mermaid Diagram

```mermaid
timeline
    title Homelab Evolution
    2026-06-26 : Initial Proxmox VE 9.2.3 environment and ubuntu-01
    2026-07-10 : Two-node Proxmox cluster named homelab
    2026-07-12 : QEMU Guest Agent integration
    2026-07-12 : Windows Server and Active Directory deployed
    2026-07-24 : pve3 added and cluster stabilized
    2026-07-25 : Dedicated physical OPNsense firewall and Tailscale remote access
    2026-07-26 : Passwordless SSH between Proxmox nodes
    2026-07-27 : Centralized Proxmox backup repository on pve3
```

## Explanation

The timeline emphasizes infrastructure maturity and architectural changes rather than task completion alone.

## Assumptions

- The dates provided are authoritative for the documented milestones.

## Items Needing Verification

- Any earlier pre-2026 precursor changes that are not yet documented

## Related Documentation

- [`docs/journal/`](../journal/)
