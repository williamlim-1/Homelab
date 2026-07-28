# Remote Access Overview

## Purpose

Summarize how remote administration reaches the homelab.

## Current State

- Tailscale is the remote-access mechanism
- OPNsense acts as the subnet router
- External testing has been performed

## Architecture

- Remote devices establish an encrypted connection through Tailscale.
- The connection enters the homelab through OPNsense rather than direct service exposure.

## Design Decisions

- Prefer NAT traversal and subnet routing over direct inbound exposure.
- Keep remote administration tied to the firewall boundary.

## Related Documentation

- [`docs/diagrams/remote-access.md`](../diagrams/remote-access.md)

