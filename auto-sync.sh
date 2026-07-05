#!/bin/bash

WATCH_DIR="/Users/admin/Desktop/HTML/Important"
REPO_DIR="/Users/admin/qmi-dashboards"

echo "[qmi-sync] Watching for changes..."

/opt/homebrew/bin/fswatch -0 \
  "$WATCH_DIR/call-dashboard (3).html" \
  "$WATCH_DIR/aj-dashboard.html" \
  "$WATCH_DIR/agent-dashboard.html" \
  "$WATCH_DIR/qj-onboarding.html" | while read -d "" event; do

  echo "[qmi-sync] Change detected: $event — pushing to GitHub..."

  cp "$WATCH_DIR/call-dashboard (3).html" "$REPO_DIR/qj-dashboard.html"
  cp "$WATCH_DIR/aj-dashboard.html"        "$REPO_DIR/aj-dashboard.html"
  cp "$WATCH_DIR/agent-dashboard.html"     "$REPO_DIR/agent-hub.html"
  cp "$WATCH_DIR/qj-onboarding.html"       "$REPO_DIR/onboarding.html"

  cd "$REPO_DIR"
  git add .
  git commit -m "auto-sync $(date '+%d/%m/%Y %H:%M')" --quiet
  git push --quiet

  echo "[qmi-sync] Done — changes are live."
done
