# Troubleshooting

## Purpose

Capture common engineering issues and how they were understood.

## Current State

- Cluster issues can be caused by clock drift.
- Windows Server installation on Proxmox depends on VirtIO storage drivers.
- Remote access behavior depends on the relationship between OPNsense, Tailscale, and upstream NAT.

## Guidance

- Start with the lowest-level dependency that could explain the symptom.
- Verify time, routing, and connectivity before higher-level services.

