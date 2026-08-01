# Remote Access

## Purpose

Describe how external administrative access reaches the homelab and how it is expected to work.

## Current State

- Tailscale is the remote-access mechanism.
- OPNsense acts as the Tailscale subnet router, advertising the homelab subnet.
- Remote administration has been tested from outside the local network.

## Architecture

- Remote devices establish an encrypted Tailscale connection.
- The connection enters the homelab through OPNsense rather than direct service exposure.
- This keeps remote administration tied to the firewall boundary instead of exposing individual services.

## Design Decisions

- Prefer NAT traversal and subnet routing over direct inbound port exposure.
- Use encrypted remote access instead of exposing internal services directly.
- Document access paths separately from credentials.

## Operational Considerations

- Remote-access testing should be performed from outside the local network to be meaningful.

## Needs Verification

- Exit-node behavior
- DNS distribution behavior
- Any future MagicDNS configuration

## Related Documentation

- [`docs/diagrams/remote-access.md`](diagrams/remote-access.md)
