#!/bin/bash
# mango for Anbernic handhelds: pick the device, clone its branch of
# mango-config next to this script and run that branch's setup

set -eu

REPO=https://github.com/crackerjacques/mango-config.git
HERE=$(cd "$(dirname "$0")" && pwd)

[ "$(id -u)" -ne 0 ] || { echo "run as the desktop user, not root" >&2; exit 1; }

. /etc/os-release
case "${ID:-}" in
	ubuntu) script=mangowm_setup.sh ;;
	debian) script=mangowm_setup_debian.sh ;;
	*) echo "Ubuntu or Debian only (this is ${PRETTY_NAME:-unknown})" >&2; exit 1 ;;
esac

# the device tree names the board; offer that one as the default
model=$(tr -d '\0' </proc/device-tree/model 2>/dev/null || true)
case "$model" in
	*"RG DS"*) guess=1 ;;
	*"Vita Pro"*) guess=2 ;;
	*[Rr]otate*) guess=3 ;;
	*) guess="" ;;
esac

cat <<EOF

  mango for Anbernic handhelds
  ============================

  This device: ${model:-unknown}
  System:      ${PRETTY_NAME:-unknown}

    1) RG DS
    2) RG Vita Pro
    3) RG Rotate

EOF
read -r -p "Choose [1-3]${guess:+ ($guess)}: " n </dev/tty
case "${n:-$guess}" in
	1) board=rg-ds ;;
	2) board=rg-vita-pro ;;
	3) board=rg-rotate ;;
	*) echo "aborted"; exit 0 ;;
esac
branch=anbernic-$board
dest=$HERE/$board

if [ -e "$dest/.git" ]; then
	git -C "$dest" pull -q --ff-only
else
	git clone -q -b "$branch" "$REPO" "$dest"
fi

exec bash "$dest/$script" "$@"
