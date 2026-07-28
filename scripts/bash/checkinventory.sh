#!/bin/bash

# checkinventory.sh
# Public-safe inventory script.
# Put real environment-specific values in checkinventory.local, which stays untracked.

set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_CONFIG="${SCRIPT_DIR}/checkinventory.local"
EXAMPLE_CONFIG="${SCRIPT_DIR}/checkinventory.example"

nodes=("pve" "pve2" "pve3")
ssh_user="root"

if [ -f "$LOCAL_CONFIG" ]; then
  source "$LOCAL_CONFIG"
fi

run_remote() {
  local node="$1"
  local command="$2"

  ssh -o BatchMode=yes -o ConnectTimeout=5 "${ssh_user}@${node}" "$command" 2>/dev/null
}

echo "# Homelab Inventory"
echo
echo "_Generated on $(date '+%Y-%m-%d %H:%M:%S')_"
echo

if [ ! -f "$LOCAL_CONFIG" ]; then
  echo "> Using public defaults."
  echo "> To override nodes or the SSH user, copy ${EXAMPLE_CONFIG##*/} to ${LOCAL_CONFIG##*/}."
  echo
fi

for node in "${nodes[@]}"; do
  echo "## ${node}"

  if ! run_remote "$node" "true" >/dev/null; then
    echo "- Status: unreachable"
    echo
    continue
  fi

  hostname_output="$(run_remote "$node" "hostname" || true)"
  uptime_output="$(run_remote "$node" "uptime -p" || true)"
  cpu_model="$(run_remote "$node" "awk -F: '/model name/ {print \$2; exit}' /proc/cpuinfo | xargs" || true)"
  cpu_threads="$(run_remote "$node" "nproc" || true)"
  memory_total="$(run_remote "$node" "free -h | awk '/^Mem:/ {print \$2}'" || true)"
  storage_output="$(run_remote "$node" "lsblk -dn -o NAME,SIZE,MODEL | sed '/^$/d'" || true)"
  vm_output="$(run_remote "$node" "qm list 2>/dev/null || echo 'qm list unavailable'" || true)"

  echo "- Status: reachable"
  [ -n "$hostname_output" ] && echo "- Hostname: ${hostname_output}"
  [ -n "$uptime_output" ] && echo "- Uptime: ${uptime_output}"
  [ -n "$cpu_model" ] && echo "- CPU: ${cpu_model}"
  [ -n "$cpu_threads" ] && echo "- CPU Threads: ${cpu_threads}"
  [ -n "$memory_total" ] && echo "- RAM: ${memory_total}"

  echo "- Storage:"
  if [ -n "$storage_output" ]; then
    echo "$storage_output" | sed 's/^/  - /'
  else
    echo "  - No storage data returned"
  fi

  echo "- VMs:"
  if [ -n "$vm_output" ]; then
    echo "$vm_output" | sed 's/^/  /'
  else
    echo "  - No VM data returned"
  fi

  echo
done
