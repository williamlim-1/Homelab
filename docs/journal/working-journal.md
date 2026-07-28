# Working Journal

## 2026-06-26 - Initial Proxmox Environment

### Objective

Establish the first stable virtualization foundation in the homelab.

### Completed Work

- Installed Proxmox VE 9.2.3
- Configured management networking
- Updated packages
- Created `ubuntu-01`
- Installed Ubuntu Server 24.04 LTS

### Architecture Changes

- The environment moved from standalone hardware to a virtualization-first model.

### Technical Decisions

- Use static management networking to simplify administration.
- Treat the Proxmox web interface as the primary day-to-day management surface.

### Verification

- Proxmox was reachable for management.
- `ubuntu-01` was successfully installed.

### Lessons Learned

- Proxmox administration is primarily web-based after initial installation.
- Snapshots provide a practical rollback mechanism before major changes.

### Engineering Takeaways

- The first virtualization layer should be stable before adding more complexity.

## 2026-07-10 - Two-Node Proxmox Cluster

### Objective

Expand Proxmox into a managed cluster with centralized control.

### Completed Work

- Installed Proxmox VE 9.2.x on `pve2`
- Configured static management networking on both nodes
- Disabled enterprise repositories
- Enabled no-subscription repositories
- Updated both nodes
- Created cluster `homelab`
- Joined `pve2`
- Verified cluster communication
- Verified web management access from both nodes

### Architecture Changes

- The environment became a two-node Proxmox cluster.

### Technical Decisions

- Create the cluster on the initial node before joining additional nodes.
- Keep node versions compatible before joining.

### Verification

- Cluster communication was confirmed.
- Management access was confirmed through the web interface.

### Lessons Learned

- Cluster nodes need compatible Proxmox versions.
- Proxmox 9 provides encoded assisted-join information.
- Centralized management works across cluster members.

### Engineering Takeaways

- Control-plane consistency matters before adding additional infrastructure.

## 2026-07-12 - QEMU Guest Agent

### Objective

Improve host-to-guest integration for Proxmox-managed VMs.

### Completed Work

- Installed QEMU Guest Agent
- Enabled the QEMU Guest Agent option in Proxmox

### Technical Decisions

- Install the package inside the guest and enable the matching Proxmox option.

### Verification

- The integration was enabled on both sides of the VM boundary.

### Lessons Learned

- Installing the guest package alone is not sufficient if the Proxmox option remains disabled.

### Engineering Takeaways

- Small integration settings can have outsized operational impact.

## 2026-07-12 - Windows Server and Active Directory

### Objective

Build the initial domain controller and internal directory services.

### Completed Work

- Installed Windows Server 2025 VM
- Installed VirtIO drivers
- Renamed the server to `dc-01`
- Assigned a static IP
- Installed Active Directory Domain Services
- Installed DNS Server
- Promoted the server to the first domain controller
- Created the `corp.homelab` forest
- Verified hostname
- Verified DNS
- Verified static networking
- Created snapshot `Post-ActiveDirectory-Install`

### Architecture Changes

- Identity and DNS became dedicated services rather than ad hoc host configuration.

### Technical Decisions

- Use a static address for the domain controller.
- Let the domain controller serve as its own preferred DNS server.

### Verification

- `hostname` returned `dc-01`
- `nslookup corp.homelab` resolved successfully

### Lessons Learned

- VirtIO storage drivers are required during Windows Server installation on Proxmox.
- DNS delegation warnings are expected for a new forest.
- Snapshots are valuable before major infrastructure changes.

### Engineering Takeaways

- Identity services should be treated as foundational infrastructure.

## 2026-07-24 - Third Proxmox Node

### Objective

Expand the virtualization cluster to three nodes and restore stable cluster health after a time synchronization issue.

### Completed Work

- Added `pve3`
- Updated nodes to compatible software versions
- Joined `pve3` to cluster `homelab`
- Verified communication across all three nodes
- Investigated authentication failures affecting `pve2`
- Identified clock drift as the root cause
- Synchronized system time
- Restarted required services
- Restored cluster access
- Verified cluster health

### Architecture Changes

- The environment expanded from two to three Proxmox nodes.

### Technical Decisions

- Treat time synchronization as a first-class dependency for cluster operations.

### Verification

- Cluster communication was restored.
- Access to `pve2` was recovered.

### Lessons Learned

- Proxmox authentication depends on synchronized clocks.
- Invalid authentication tickets may indicate time synchronization problems.
- Cluster health should be verified before troubleshooting higher-level services.

### Engineering Takeaways

- Control-plane issues often present as authentication issues.

## 2026-07-25 - OPNsense and Tailscale

### Objective

Provide a dedicated physical firewall and a secure remote-access path that works behind upstream NAT.

### Completed Work

- Completed OPNsense firewall deployment
- Configured LAN at the current homelab subnet
- Configured WAN through DHCP from the upstream router
- Built an initial native WireGuard configuration
- Evaluated remote-access alternatives
- Installed Tailscale on OPNsense
- Joined OPNsense to a tailnet
- Configured OPNsense as a subnet router
- Advertised the homelab subnet
- Installed Tailscale on a Windows workstation
- Tested remote administration over cellular data
- Verified access to core services externally

### Architecture Changes

- The firewall moved to dedicated physical hardware.
- Tailscale became the preferred remote-access method.

### Technical Decisions

- Keep the firewall independent from the virtualization cluster.
- Use Tailscale to avoid immediate dependence on upstream port forwarding.

### Challenges

- Native WireGuard required upstream port forwarding.

### Root Cause

- The firewall sits behind the ISP-side router, which introduces double NAT.

### Resolution

- Use Tailscale for NAT traversal and subnet routing.

### Verification

- Remote administration was tested from outside the local network.

### Lessons Learned

- A subnet router can expose an authorized private subnet without installing Tailscale on every internal device.
- Remote-access testing must occur from outside the local network.

### Engineering Takeaways

- Secure remote access should be designed around the actual network boundary, not the desired one.

## 2026-07-26 - Initial Structure

### Objective

Create a documentation structure that can support both private operations and public sharing.

### Completed Work

- Established a documentation layout around architecture, infrastructure, identity, systems, remote access, operations, diagrams, journal entries, and goals
- Added a private documentation area for sensitive operational details
- Created public-safe guidance for writing about the environment
- Added starter pages for the Proxmox cluster, OPNsense, and key VMs

### Architecture Changes

- Introduced a split between public documentation and private operational notes
- Moved the repository toward role-based, engineering-oriented documentation rather than setup notes
- Added a long-term goals document to capture growth across disciplines

### Technical Decisions

- Keep sensitive data out of public docs and store it in a dedicated private area
- Document systems by function and purpose rather than by configuration dump
- Use Markdown as the primary documentation format for portability and readability

### Challenges

- The environment details are intentionally incomplete in places
- Public documentation must remain useful without exposing internal addresses or secrets

### Root Cause

- The repository needed a structure that could represent both the current homelab and the engineering thinking behind it

### Resolution

- Added templates and guidance that favor explanation, design reasoning, and safe disclosure

### Verification

- Confirmed the structure exists on disk and is organized into public and private areas

### Lessons Learned

- Good infrastructure documentation is a design artifact, not a note dump
- Separating sensitive operational data early makes it easier to publish later

## 2026-07-26 - Passwordless SSH Between Proxmox Nodes

### Objective

Enable passwordless SSH between `pve`, `pve2`, and `pve3` so routine cluster tasks can be run without interactive authentication.

### Completed Work

- Generated an ED25519 SSH key on each Proxmox node
- Copied each node's public key to the other two nodes using `ssh-copy-id`
- Updated `/etc/hosts` on every node so `pve`, `pve2`, and `pve3` resolve to the correct management addresses
- Verified that each node can SSH to every other node by hostname without a password prompt

### Architecture Changes

- The Proxmox cluster now has trusted administrative communication between nodes.

### Technical Decisions

- Use ED25519 keys for compact, modern SSH keying.
- Depend on hostname resolution instead of remembering raw management addresses for node-to-node access.

### Verification

- Hostname-based SSH works between all three nodes without prompting for a password.

### Lessons Learned

- Simple host resolution and SSH trust relationships make cluster administration easier to scale.
- Node-to-node automation becomes much easier once passwordless communication is in place.

### Engineering Takeaways

- Cluster-wide administration benefits from treating SSH trust as baseline infrastructure rather than an ad hoc convenience.

## 2026-07-26 - Initial Backup for dc-01

### Objective

Establish the first working backup for the domain controller.

### Completed Work

- Created backup storage on `pve3`
- Ran a `vzdump` backup for VM `101` (`dc-01`)
- Confirmed the backup archive was written successfully
- Created a scheduled backup job that runs Sundays at 01:00
- Configured the job to use `pve3-backup`
- Set snapshot mode, `zstd` compression, and keep-last=2 retention
- Included all guests in the scheduled backup job
- Confirmed `ubuntu-01` is included in the schedule

### Architecture Changes

- The homelab now has a working backup target, a real backup artifact for `dc-01`, and a recurring backup schedule.

### Technical Decisions

- Use `pve3` as the first backup destination.
- Use snapshot mode with `zstd` compression.

### Verification

- Backup completed successfully with no errors.
- The scheduled backup job is present in Proxmox and matches the desired settings.

### Lessons Learned

- A backup target is only operational once a real backup job completes.
- Proxmox can back up a running VM in snapshot mode while preserving service availability.

### Engineering Takeaways

- The first successful backup turns the backup plan into an actual recovery path.

## 2026-07-27 - Centralized Proxmox Backup Repository

### Objective

Convert the backup target from a node-local path into a shared cluster-wide repository.

### Completed Work

- Exported the backup drive from `pve3` over NFS
- Added the NFS share to Proxmox as shared storage
- Verified the repository is visible from the cluster as `pve3-backup`
- Updated the backup job to use the shared repository
- Confirmed the scheduled job targets all guests in the cluster
- Verified the retention policy and schedule in Proxmox

### Architecture Changes

- The backup repository is now centralized instead of behaving like a node-local directory on each host.

### Technical Decisions

- Use NFS so every Proxmox node can write to one shared repository.
- Keep the repository physically attached to `pve3` while exposing it cluster-wide.

### Verification

- Proxmox reports the backup storage as active and shared.
- The scheduled backup job points to the shared repository.

### Lessons Learned

- A storage path mounted locally on multiple nodes is not the same as a shared repository.
- Centralized storage needs to be explicitly exported and added to Proxmox as shared storage.

### Engineering Takeaways

- Shared storage is what turns a backup disk into a cluster backup repository.
