#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
python3 -m json.tool "$ROOT/models/catalog.json" >/dev/null
python3 - "$ROOT/models/catalog.json" <<'PY'
import json,sys
d=json.load(open(sys.argv[1]))
ids=[m["id"] for m in d["models"]]
assert len(ids)==len(set(ids))
assert "qwen3-0.6b-q8" in ids
PY
echo "catalog ok"
