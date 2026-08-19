#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_dir="$(cd "${script_dir}/.." && pwd)"
site_dir="${project_dir}/_site"
max_file_mib=95
max_site_mib=500

if [[ ! -d "${site_dir}" ]]; then
  echo "Publish check failed: ${site_dir} does not exist." >&2
  exit 1
fi

# Resource globs can include Finder metadata even though Git ignores it.
find "${site_dir}" -type f -name .DS_Store -delete

oversized_files="$(find "${site_dir}" -type f -size +"${max_file_mib}"M -print)"
if [[ -n "${oversized_files}" ]]; then
  echo "Publish check failed: files larger than ${max_file_mib} MiB:" >&2
  printf '%s\n' "${oversized_files}" >&2
  echo "Serve large media from the CDN instead of GitHub Pages." >&2
  exit 1
fi

site_kib="$(du -sk "${site_dir}" | awk '{print $1}')"
if (( site_kib > max_site_mib * 1024 )); then
  echo "Publish check failed: _site is $((site_kib / 1024)) MiB; limit is ${max_site_mib} MiB." >&2
  echo "Check project.resources for local media or render-only datasets." >&2
  exit 1
fi

echo "Publish check passed: _site is $((site_kib / 1024)) MiB and contains no file larger than ${max_file_mib} MiB."
