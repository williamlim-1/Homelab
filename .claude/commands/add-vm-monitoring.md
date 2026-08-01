---
description: Onboard a newly created VM into the monitor-01 Prometheus/Grafana stack
---

The user has created a new VM and wants it added to the monitoring stack on `monitor-01`. They will tell you the VM's name and, if known, its IP address. If the IP wasn't given, find it the same way used previously: query the QEMU guest agent from the Proxmox node (`qm agent <vmid> network-get-interfaces`), not by guessing.

Follow this sequence. Do not skip steps or assume a prior step succeeded without checking.

## 0. Prerequisites — confirm before changing anything

- Confirm passwordless SSH from `pve3` to the new VM is already working. If it isn't, stop and tell the user — this command assumes it's already set up (the user said they'd handle this separately per-VM).
- Confirm the VM's OS (Linux vs Windows) — the exporter and install method differ.
- Never ask the user to paste a password into chat. If a password is needed for a one-time bootstrap step, ask them to run the command themselves, or use it once via a tool call and then advise rotating it immediately after, same as previously done for `monitor-01` and the Grafana admin account.

## 1. Install the appropriate exporter on the new VM

- **Linux**: `sudo apt install -y prometheus-node-exporter && sudo systemctl enable --now prometheus-node-exporter`. Verify with `systemctl status`.
- **Windows**: this needs RDP/WinRM access this session doesn't have by default — tell the user to install `windows_exporter` (MSI from GitHub releases) themselves, and add a Windows Firewall rule scoped to `monitor-01`'s IP only, not the whole subnet. Don't attempt this over SSH.

## 2. Add convenience DNS on `pve3` (optional, ask first)

Only if the user wants hostname-based access (matches the pattern used for `monitor-01`):
- Append an entry to `/etc/hosts` on `pve3`: `<ip> <name>.homelab.local <name>`
- Add a `Host` block to `~/.ssh/config` on `pve3` pointing at the dedicated `id_ed25519_guests` key.
- `ssh-keyscan -H <name-or-ip>` into `pve3`'s `known_hosts` before the first connection attempt, or the first SSH will fail with a host-key error.

## 3. Add the Prometheus scrape target

Edit `~/monitoring/prometheus/prometheus.yml` on `monitor-01` (reach it via `pve3` → `monitor-01` SSH). Add a new job named after the VM, using its **IP address**, not a hostname — containers on `monitor-01` cannot resolve `pve3`'s `/etc/hosts` entries or any other host's DNS:

```yaml
  - job_name: '<vm-name>'
    static_configs:
      - targets: ['<vm-ip>:9100']
```

(Port 9182 instead of 9100 for `windows_exporter`.)

## 4. Reload Prometheus

`prometheus.yml` is bind-mounted — editing it on disk does **not** make the running container reload it. Restart the specific container:
```
cd ~/monitoring && docker compose restart prometheus
```

## 5. Verify — don't assume it worked

Wait at least one scrape interval (15s+), then check target health directly:
```
curl -s http://localhost:9090/api/v1/targets
```
Confirm the new job shows `"health":"up"` with an empty `"lastError"`. If it doesn't, read the actual error message before guessing at a fix — check container logs (`docker logs <container>`) for the real cause rather than re-trying blind.

## 6. Confirm in Grafana

The existing node-exporter dashboard uses a dynamic `Job`/`instance` variable (queries `label_values(node_uname_info, job)`), so a correctly named job should appear automatically — no dashboard edits needed. Have the user confirm the new host shows up in the dropdown.

## 7. Update documentation

In the same session, per this repo's process:
- `docs/journal/working-journal.md` — new entry describing what was added and why, following the existing entry format (Objective, Completed Work, Technical Decisions, Verification, Lessons Learned).
- `docs/systems/monitoring.md` — add the new target to the scrape list under Current State.
- `docs/private/inventory.md` — move the VM from "Needs Verification" to "Current" if applicable.
- `docs/private/service-addresses.md` — add the VM's hostname/IP if not already recorded.

Follow the repo's placeholder conventions (`TBD`, `Needs Verification`, etc.) for anything not yet confirmed, and never write credentials or API tokens into any committed file.
