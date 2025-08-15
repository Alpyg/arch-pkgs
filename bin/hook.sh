#!/bin/bash

set -euo pipefail

base_dir="$(cd -- "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)/.." &>/dev/null && pwd)"
user="${SUDO_USER:-$(logname 2>/dev/null || whoami)}"
home="$(eval echo "~$user")"

phase="$1"

# parse the most recent transaction from pacman.log
mapfile -t pkgs < <(
  tac /var/log/pacman.log |
  awk '
    /transaction completed/ {in_tx=1; next}
    /transaction started/ && in_tx {exit}
    in_tx && /installed|reinstalled|upgraded|removed/ {print $(NF-1)}
  ' |
  tac
)

for pkg in "${pkgs[@]}"; do
  pkg_dir="${base_dir}/pkgs/${pkg}"
  script="${pkg_dir}/install.sh"
  if [[ -f "$script" ]]; then
    source "$script"
    if declare -F "$phase" >/dev/null; then
      echo "[$pkg] Running $phase"
      "$phase"
    fi
  fi
done
