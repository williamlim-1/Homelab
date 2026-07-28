# Identity and DNS

## Purpose

Show the authentication and name-resolution relationship in the environment.

## Scope

- Windows clients
- DNS lookups
- Kerberos or LDAP authentication
- Active Directory

## Mermaid Diagram

```mermaid
flowchart LR
    Client[Windows Client Current]
    DNS[DNS Lookup Current]
    DC[dc-01 Current]
    AD[Active Directory Current]
    Domain[corp.homelab Current]

    Client --> DNS --> DC --> Domain
    Client -->|Kerberos or LDAP authentication| DC --> AD
```

## Explanation

The domain controller is both the identity source and the DNS anchor for the AD domain.

## Assumptions

- Usernames are intentionally omitted.
- DNS behavior may include forwarding through OPNsense, but that remains to be verified.

## Items Needing Verification

- DNS forwarding details
- Tailscale DNS distribution
- Any split-DNS behavior

## Related Documentation

- [`docs/identity/active-directory.md`](../identity/active-directory.md)
- [`docs/identity/dns.md`](../identity/dns.md)

