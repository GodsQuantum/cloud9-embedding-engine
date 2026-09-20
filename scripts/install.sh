#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
PREFIX="${PREFIX:-/usr/local}"
ETC_DIR="${C9EE_ETC_DIR:-/etc/cloud9-embedding-engine}"
LIB_DIR="$PREFIX/lib/cloud9-embedding-engine"

install -d "$PREFIX/bin" "$ETC_DIR" "$LIB_DIR"
install -m 0755 "$ROOT/bin/cloud9-embedding-engine" "$PREFIX/bin/cloud9-embedding-engine"
install -m 0755 "$ROOT/bin/cloud9-embedding-server" "$PREFIX/bin/cloud9-embedding-server"
install -m 0755 "$ROOT/scripts/bench_client.py" "$LIB_DIR/bench_client.py"
install -m 0755 "$ROOT/scripts/model_gate.py" "$LIB_DIR/model_gate.py"
install -m 0644 "$ROOT/models/catalog.json" "$ETC_DIR/catalog.json"

if [[ ! -e "$ETC_DIR/engine.env" ]]; then
  install -m 0644 "$ROOT/config/cloud9-embedding-engine.env.example" "$ETC_DIR/engine.env"
fi

if [[ "$(id -u)" -eq 0 && -d /etc/systemd/system ]]; then
  install -m 0644 "$ROOT/systemd/cloud9-embedding.service" /etc/systemd/system/cloud9-embedding.service
  systemctl daemon-reload
  echo "Installed systemd unit. Review $ETC_DIR/engine.env, then: systemctl enable --now cloud9-embedding.service"
fi

echo "Installed Cloud9 Embedding Engine."
