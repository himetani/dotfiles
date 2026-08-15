#!/bin/sh
#
# Offer to upgrade Homebrew, at most once every INTERVAL_DAYS.
#
# Homebrew is a rolling release with no lockfile, so there is no version to
# record in this repository and nothing for chezmoi to apply: the only way to
# stay current is to run brew upgrade often enough. Asking here ties that to a
# moment when the machine is already being brought up to date, without upgrading
# anything behind the user's back.
#
# Unlike the other run scripts this one is not keyed on a file hash, because
# there is no input file that changes when a new version is published.

set -eu

INTERVAL_DAYS=7
state_file="${XDG_STATE_HOME:-$HOME/.local/state}/chezmoi/brew-upgrade-last"

if [ "$(uname -s)" != "Darwin" ]; then
  exit 0
fi

if ! command -v brew >/dev/null 2>&1; then
  exit 0
fi

# Nothing to prompt on when chezmoi runs without a terminal. /dev/tty can exist
# and still fail to open, so test it by opening it rather than with -r.
if ! : 2>/dev/null < /dev/tty; then
  exit 0
fi

if [ -f "$state_file" ]; then
  last=$(cat "$state_file" 2>/dev/null || echo 0)
  days=$(( ( $(date +%s) - last ) / 86400 ))
  if [ "$days" -lt "$INTERVAL_DAYS" ]; then
    exit 0
  fi
  printf 'Homebrew was last upgraded %s days ago. Upgrade now? [y/N] ' "$days"
else
  printf 'Homebrew has not been upgraded from chezmoi yet. Upgrade now? [y/N] '
fi

# A failed read means nobody was there to answer, which must not be recorded as
# a decision: doing so would silently suppress the prompt for INTERVAL_DAYS.
if ! read -r answer < /dev/tty; then
  echo
  echo "No answer given; leaving the question for next time."
  exit 0
fi

# Record the answer either way, so declining postpones the question for
# INTERVAL_DAYS instead of asking again on the next apply.
mkdir -p "$(dirname "$state_file")"
date +%s > "$state_file"

case "$answer" in
  [yY] | [yY][eE][sS])
    brew update
    brew upgrade
    brew cleanup
    ;;
  *)
    echo "Skipped. Will ask again in $INTERVAL_DAYS days."
    ;;
esac
