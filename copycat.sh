#!/bin/bash

if [ -z "$1" ]; then
  echo "usage: $0 <file>"
  exit 1
fi

if command -v xclip &>/dev/null; then
  cat "$1" | xclip -selection clipboard
elif command -v wl-copy &>/dev/null; then
  cat "$1" | wl-copy
else
  echo "no clipboard tool found (need xclip or wl-copy)"
  exit 1
fi

