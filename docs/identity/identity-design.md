# Identity Design

## Purpose

Document the reasoning behind the identity model.

## Current State

- Active Directory is the main identity system.
- Windows clients can authenticate to the domain.
- The design supports future OU, group, and access-control growth.

## Design Decisions

- Keep identity centralized.
- Start with a single domain and expand policy structure over time.
- Treat application integration as a future design area rather than a finished capability.

