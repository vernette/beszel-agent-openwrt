#!/usr/bin/env sh

API_URL="https://api.github.com/repos/vernette/beszel-agent-openwrt/releases/latest"

require_openwrt_release() {
  if [ ! -r /etc/openwrt_release ]; then
    echo "Error: /etc/openwrt_release not found."
    exit 1
  fi
  . /etc/openwrt_release
}

detect_arch() {
  ARCH="${DISTRIB_ARCH:-}"
  if [ -z "$ARCH" ]; then
    echo "Error: DISTRIB_ARCH not found in /etc/openwrt_release."
    exit 1
  fi
}

detect_pkg_manager() {
  if command -v apk >/dev/null 2>&1; then
    PKG_EXT="apk"
    PKG_MANAGER="apk"
  elif command -v opkg >/dev/null 2>&1; then
    PKG_EXT="ipk"
    PKG_MANAGER="opkg"
  else
    echo "Error: neither apk nor opkg found on this system."
    exit 1
  fi
}

resolve_asset_url() {
  if [ "$PKG_EXT" = "apk" ]; then
    MATCH_PATTERN="-${ARCH}.apk"
  else
    MATCH_PATTERN="_${ARCH}.ipk"
  fi

  PKG_URL="$(wget -qO- "$API_URL" | grep -o 'https://[^"]*'"${MATCH_PATTERN}")"
  if [ -z "$PKG_URL" ]; then
    echo "Error: failed to find asset URL for ${ARCH} (${PKG_EXT})."
    exit 1
  fi

  PKG_NAME="${PKG_URL##*/}"
  PKG_PATH="/tmp/${PKG_NAME}"
}

download_package() {
  printf "%s: %s\n%s: %s\n\n%s: %s\n" \
    "Architecture" "${ARCH}" \
    "Package manager" "${PKG_MANAGER}" \
    "Downloading" "${PKG_URL}"
  wget -qO "$PKG_PATH" "$PKG_URL"
}

install_package() {
  echo "Installing $PKG_PATH"
  if [ "$PKG_MANAGER" = "opkg" ]; then
    opkg install "$PKG_PATH"
  else
    apk add --allow-untrusted "$PKG_PATH"
  fi
  rm -f "$PKG_PATH"
}

main() {
  require_openwrt_release
  detect_arch
  detect_pkg_manager
  resolve_asset_url
  download_package
  install_package
  printf "\n%s\n" "Done. Edit config in /etc/config/beszel-agent"
}

main "$@"
