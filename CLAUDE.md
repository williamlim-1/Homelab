# Repo Guidance

This repository is for professional homelab documentation.

## Working Style

- Treat documentation as an engineering artifact.
- Prefer concise, factual writing over instructional text in public docs.
- When a session changes the environment, update the relevant docs in the same session if possible.
- Write for another infrastructure engineer.
- Prefer explanation over instruction.
- Use `TBD`, `Needs Verification`, `Unknown`, `Historical Configuration`, `Planned`, or `Not Yet Implemented` instead of inventing details.
- Do not invent missing infrastructure details.

## Documentation Flow

- Use `docs/journal/` for chronological change tracking.
- Use `docs/private/` for sensitive operational details.
- Keep public docs focused on architecture, purpose, state, and lessons learned.
- Keep IP addresses, URLs, credentials, keys, tokens, MAC addresses, serial numbers, and recovery details out of public files.

## Verification

- Do not claim a service is operational unless it has been verified.
- Do not claim backup or failover maturity unless that has been tested.
- Keep current and historical configurations distinct.

## Internal Section Guidance

These labels can be used in the repository, but their content should be factual rather than instructional:

- `Purpose`
- `Overview`
- `Current State`
- `Architecture`
- `Design Decisions`
- `Operational Considerations`
- `Maintenance`
- `Troubleshooting`
- `Lessons Learned`
- `History`
- `Related Documentation`

## Placeholder Guidance

If a section does not yet have real content, leave a short placeholder sentence or `TBD` marker instead of explaining what the section should contain.
