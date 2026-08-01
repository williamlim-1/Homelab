# Monitoring

## Purpose

Document the monitoring posture without overstating operational maturity.

## Current State

- `monitor-01` runs Prometheus and Grafana as a Docker Compose stack.
- Prometheus scrapes:
  - Its own metrics.
  - `node_exporter` on `monitor-01` (host-level metrics).
  - `node_exporter` on `ubuntu-01` (host-level metrics).
  - `prometheus-pve-exporter`, which queries the Proxmox API for cluster-wide node, VM, and storage metrics across `pve`, `pve2`, and `pve3`.
- Grafana has two dashboards imported: a node-exporter dashboard (host-level detail per VM) and a Proxmox cluster dashboard (hypervisor-level detail).
- Alerting is not yet configured.

## Architecture

- `node_exporter`/`pve-exporter` provide two distinct layers of visibility: guest-OS-level metrics versus hypervisor-level metrics. Neither substitutes for the other.
- `prometheus-pve-exporter` authenticates to the Proxmox API using a dedicated, read-only (`PVEAuditor`) API token rather than a privileged account.
- Container-to-container traffic inside the Compose stack resolves by Docker Compose service name; traffic to hosts outside the stack (Proxmox nodes, other VMs) uses IP addresses rather than hostnames, since those containers have no route to cluster DNS or `/etc/hosts` entries defined elsewhere.

## Requirements

- Host availability - partially met (Proxmox layer covered by `pve-exporter`; `ubuntu-01` covered by `node_exporter`)
- VM health - partially met (see above)
- Infrastructure metrics - partially met
- Logs and alerts - Not Yet Implemented

## Planned

- `windows_exporter` on `dc-01`
- Alerting (Alertmanager or Grafana-native)
- Monitoring coverage for `docker-01` once that host's role is verified

## Related Documentation

- [`docs/systems/overview.md`](overview.md)
- [`docs/journal/working-journal.md`](../journal/working-journal.md)
