#!/usr/bin/env bash
set -euo pipefail

# Force the terminal backend to Daytona in case config drift happened.
hermes config set terminal.backend daytona
hermes config set terminal.container_persistent true
hermes config set terminal.container_cpu 1
hermes config set terminal.container_memory 5120
hermes config set terminal.container_disk 10240

echo "[hermes] terminal.backend=$(hermes config get terminal.backend || true)"
echo "[hermes] starting gateway..."

exec hermes gateway start
