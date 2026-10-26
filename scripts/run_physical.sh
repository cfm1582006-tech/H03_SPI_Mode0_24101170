#!/usr/bin/env bash
set -euo pipefail
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
tag=${1:-physical_$(date -u +%Y%m%dT%H%M%SZ)}
appimage=${H03_LIBRELANE_APPIMAGE:-/home/duongluong/librelane-devshell-x86_64.AppImage}
pdk_root=${H03_PDK_ROOT:-/home/duongluong/.ciel/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71}
if [[ ! -x "$appimage" ]]; then
    printf 'Missing LibreLane AppImage: %s\n' "$appimage" >&2
    exit 2
fi
if [[ ! -d "$pdk_root/sky130A" ]]; then
    printf 'Missing sky130A under PDK root: %s\n' "$pdk_root" >&2
    exit 2
fi
exec "$appimage" python3 "$script_dir/run_physical.py" --tag "$tag" --pdk-root "$pdk_root" --jobs 4
