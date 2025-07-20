#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 \"your commit message\"" >&2
  exit 1
fi

COMMIT_MSG="$1"

USERNAME="saltytine"
TOKEN="==========================="

REMOTE_URL=$(git config --get remote.origin.url)

if [[ $REMOTE_URL != https://* ]]; then
  echo "doesnt work"
  exit 2
fi

AUTH_REMOTE_URL=$(echo "$REMOTE_URL" | sed "s#https://#https://$USERNAME:$TOKEN@#")

git remote set-url origin "$AUTH_REMOTE_URL"

git add --all
git commit -m "$COMMIT_MSG"
git push -u origin main

git remote set-url origin "$REMOTE_URL"

echo "threw your trash into gitHub with commit: \"$COMMIT_MSG\""

