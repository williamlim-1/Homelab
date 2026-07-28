# Identity Overview

## Purpose

Summarize how identity and name resolution are handled in the homelab.

## Current State

- `corp.homelab` is the current Active Directory domain and forest
- `dc-01` is the domain controller and DNS host
- Windows clients authenticate against Active Directory

## Architecture

- `dc-01` provides directory services, authentication, and DNS.
- OPNsense may participate in forwarding or resolution, but that behavior still needs verification.

## Design Decisions

- Use a dedicated domain controller rather than ad hoc local accounts.
- Keep DNS close to the identity system.
- Avoid documenting sensitive identity details in public files.

## Related Documentation

- [`docs/diagrams/identity-and-dns.md`](../diagrams/identity-and-dns.md)
- [`docs/systems/dc-01.md`](../systems/dc-01.md)

