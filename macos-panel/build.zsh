#!/bin/zsh
set -euo pipefail

script_dir="${0:A:h}"
source_file="$script_dir/Sources/main.swift"
plist_file="$script_dir/Info.plist"
dist_dir="${DEEPSEEK_DIRECT_DIST_DIR:-$script_dir/dist}"
app_path="$dist_dir/DeepSeek Panel.app"
contents_path="$app_path/Contents"
executable_path="$contents_path/MacOS/DeepSeek Panel"
deployment_target="${MACOSX_DEPLOYMENT_TARGET:-13.0}"
sdk_path="$(/usr/bin/xcrun --sdk macosx --show-sdk-path)"
typeset -a architectures
if [[ -n "${DEEPSEEK_DIRECT_ARCHS:-}" ]]; then
  architectures=(${=DEEPSEEK_DIRECT_ARCHS})
else
  architectures=(arm64 x86_64)
fi
build_temp="$(/usr/bin/mktemp -d /tmp/deepseek-direct-build.XXXXXX)"
trap '/bin/rm -rf "$build_temp"' EXIT

if [[ ! -f "$source_file" || ! -f "$plist_file" ]]; then
  print -u2 "Missing DeepSeek Panel source or Info.plist"
  exit 1
fi

if [[ "$app_path" != "$dist_dir/DeepSeek Panel.app" || -z "$dist_dir" || "$dist_dir" == "/" ]]; then
  print -u2 "Refusing to replace an unexpected app path"
  exit 1
fi

rm -rf "$app_path"
mkdir -p "$contents_path/MacOS" "$contents_path/Resources"
cp "$plist_file" "$contents_path/Info.plist"

typeset -a architecture_binaries
for architecture in "${architectures[@]}"; do
  case "$architecture" in
    arm64|x86_64) ;;
    *)
      print -u2 "Unsupported architecture: $architecture"
      exit 1
      ;;
  esac

  architecture_binary="$build_temp/DeepSeek-Panel-$architecture"
  /usr/bin/xcrun swiftc \
    -swift-version 5 \
    -target "$architecture-apple-macos$deployment_target" \
    -sdk "$sdk_path" \
    -O \
    -framework AppKit \
    -framework SwiftUI \
    "$source_file" \
    -o "$architecture_binary"
  architecture_binaries+=("$architecture_binary")
done

if (( ${#architecture_binaries[@]} == 1 )); then
  /bin/cp "${architecture_binaries[1]}" "$executable_path"
else
  /usr/bin/lipo -create "${architecture_binaries[@]}" -output "$executable_path"
fi

chmod 755 "$executable_path"
/usr/bin/codesign --force --deep --sign - "$app_path"
/usr/bin/codesign --verify --deep --strict "$app_path"
/usr/bin/plutil -lint "$contents_path/Info.plist"
/usr/bin/lipo -archs "$executable_path"

print "$app_path"
