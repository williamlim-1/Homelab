# Tailscale

## Purpose

Document the secure remote-access layer used for homelab administration.

## Current State

- Tailscale is used for external access.
- OPNsense acts as a subnet router.
- Remote administration has been tested from outside the local network.

## Design Decisions

- Use encrypted remote access instead of exposing internal services directly.
- Keep subnet routing central to the firewall boundary.

## Needs Verification

- Exit-node behavior
- DNS distribution behavior
- Any future MagicDNS configuration

