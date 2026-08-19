#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_dir="$(cd "${script_dir}/.." && pwd)"
site_dir="${project_dir}/_site"

# Refuse to remove anything unless the target is this project's output folder.
if [[ "${site_dir}" != "${project_dir}/_site" || "${site_dir}" == "/_site" ]]; then
  echo "Refusing to clean an unexpected output directory: ${site_dir}" >&2
  exit 1
fi

rm -rf -- "${site_dir}"
