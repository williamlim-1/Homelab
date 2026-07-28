# Operations Overview

## Purpose

Summarize the current operational posture of the homelab.

## Current State

- Snapshots are used for rollback protection
- OPNsense configuration export is completed
- Proxmox backups use a centralized NFS repository exported from `pve3`
- The backup job runs daily at 01:00
- The backup job uses snapshot mode and `zstd` compression
- The backup job keeps 7 daily, 8 weekly, 12 monthly, and 2 yearly backups
- `dc-01` has been backed up successfully
- `ubuntu-01` is included in the scheduled backup job
- Restore testing is not yet confirmed
- Troubleshooting remains tied to time sync, routing, and identity dependencies

## Backup Posture

- Backup storage is shared across the cluster via NFS
- The scheduled job targets `pve3-backup`
- The repository is exported from `pve3`
- All guests are currently included in the scheduled job
- The first backup job completed successfully for `dc-01`
- Backups should still be validated with a restore test before being treated as fully proven

## Architecture

- Snapshots support change safety.
- Backups are still maturing.
- Operational knowledge is captured in the journal and supporting docs.

## Related Documentation

- [`docs/journal/`](../journal/)
- [`docs/diagrams/backup-architecture.md`](../diagrams/backup-architecture.md)
