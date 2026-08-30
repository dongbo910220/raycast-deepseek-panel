#!/bin/zsh
set -euo pipefail

repo_root="${0:A:h:h}"
extension_source="$repo_root/extension"
panel_source="$repo_root/macos-panel"

if command -v pnpm >/dev/null 2>&1; then
  package_runner=(pnpm)
elif command -v corepack >/dev/null 2>&1; then
  package_runner=(corepack pnpm)
else
  print -u2 "pnpm or Corepack was not found"
  exit 1
fi

DEEPSEEK_DIRECT_DIST_DIR="$extension_source/assets" "$panel_source/build.zsh"
/usr/bin/codesign --verify --deep --strict "$extension_source/assets/DeepSeek Panel.app"

cd "$extension_source"
"${package_runner[@]}" install --frozen-lockfile
"${package_runner[@]}" build

cd "$repo_root"
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  if git grep -IlE 'sk-[A-Za-z0-9_-]{16,}|gh[pousr]_[A-Za-z0-9_]{20,}|github_pat_[A-Za-z0-9_]+|AKIA[0-9A-Z]{16}' -- . \
    | /usr/bin/grep -q .; then
    print -u2 "Potential credential found in a tracked file. Refusing to continue."
    exit 1
  fi
fi

print "All checks passed."
