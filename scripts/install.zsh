#!/bin/zsh
set -euo pipefail

repo_root="${0:A:h:h}"
panel_source="$repo_root/macos-panel"
extension_source="$repo_root/extension"
panel_assets="$extension_source/assets"

raycast_found=false
for raycast_path in "/Applications/Raycast.app" "$HOME/Applications/Raycast.app"; do
  if [[ -d "$raycast_path" ]]; then
    raycast_found=true
    break
  fi
done

if [[ "$raycast_found" != true ]]; then
  print -u2 "Raycast was not found in /Applications or ~/Applications"
  exit 1
fi

if ! /usr/bin/xcrun --find swiftc >/dev/null 2>&1; then
  print -u2 "Swift compiler not found. Install Xcode Command Line Tools first."
  exit 1
fi

DEEPSEEK_DIRECT_DIST_DIR="$panel_assets" "$panel_source/build.zsh"
built_app="$panel_assets/DeepSeek Panel.app"
/usr/bin/codesign --verify --deep --strict "$built_app"

if command -v pnpm >/dev/null 2>&1; then
  package_runner=(pnpm)
elif command -v corepack >/dev/null 2>&1; then
  package_runner=(corepack pnpm)
else
  print -u2 "pnpm or Corepack was not found. Install Node.js 22.22.2+ and pnpm 11."
  exit 1
fi

cd "$extension_source"
"${package_runner[@]}" install --frozen-lockfile

print ""
print "DeepSeek Panel built into the Raycast extension assets:"
print "  $built_app"
print ""
print "Import the Raycast extension once with:"
print "  cd ${(q)extension_source}"
print "  ${package_runner[*]} dev"
print ""
print "After Raycast reports a successful build, press Ctrl+C."
