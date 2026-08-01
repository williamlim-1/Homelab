# Identity Overview

## Purpose

Summarize how identity and name resolution are handled in the homelab, and the reasoning behind the design.

## Current State

- `corp.homelab` is the current Active Directory domain and forest.
- `dc-01` is the domain controller and DNS host.
- Windows clients authenticate against Active Directory.

## Architecture

- `dc-01` provides directory services, authentication, and DNS.
- OPNsense may participate in forwarding or resolution, but that behavior still needs verification.

## Design Decisions

- Use a dedicated domain controller rather than ad hoc local accounts.
- Keep DNS close to the identity system.
- Keep identity centralized, starting with a single domain and expanding OU, group, and access-control structure over time.
- Treat application integration as a future design area rather than a finished capability.
- Avoid documenting sensitive identity details in public files.

## Related Documentation

- [`docs/diagrams/identity-and-dns.md`](../diagrams/identity-and-dns.md)
