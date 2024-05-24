#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/extrawurst/gitui"
TOOL_NAME="gitui"
TOOL_TEST="gitui --version"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
  list_github_tags
}

get_tool_cmd() {
  local tool_cmd
  tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
  echo "${tool_cmd}"
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"

  local arch
  arch="$(get_arch)"
  local platform
  platform="$(get_platform)"
  local ext
  ext="$(get_ext)"
  # https://github.com/tj-actions/auto-doc/releases/download/v2.7.1/auto-doc_2.7.1_Linux_x86_64.tar.gz
  url="$GH_REPO/releases/download/v${version}/$(get_tool_cmd)_${version}_${platform}_${arch}${ext}"

  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="${3%/bin}/bin"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path"
    cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

    local tool_cmd
    tool_cmd="$(get_tool_cmd)"
    test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
    echo "* Install locally or globally with:"
    echo "asdf local $TOOL_NAME $version"
    echo "asdf global $TOOL_NAME $version"
  ) || (
    rm -rf "$install_path"
    fail "An error occurred while installing $TOOL_NAME $version."
  )
}

get_arch() {
  arch=$(uname -m | tr '[:upper:]' '[:lower:]')
  case ${arch} in
  arm64)
    arch='arm64'
    ;;
  arm6)
    arch='arm6'
    ;;
  x86_64)
    arch='x86_64'
    ;;
  aarch64)
    arch='arm64'
    ;;
  i386)
    arch='i386'
    ;;
  esac

  echo "${arch}"
}

get_platform() {
  plat=$(uname | tr '[:upper:]' '[:lower:]')
  case ${plat} in
  darwin)
    plat='Darwin'
    ;;
  linux)
    plat='Linux'
    ;;
  windows)
    plat='Windows'
    ;;
  esac

  echo "${plat}"
}

get_ext() {
  plat=$(uname | tr '[:upper:]' '[:lower:]')
  case ${plat} in
  windows)
    ext='.zip'
    ;;
  *)
    ext='.tar.gz'
    ;;
  esac

  echo "${ext}"
}
