#!/bin/bash
# Pre-commit: consistency kit. Mirrors .github/workflows/ci.yml.
#
# This repo has no venv and no pyproject.toml, so there is no dependency check
# to run — the kit itself is stdlib-only precisely so it can guard a repo that
# has no environment.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "Checking consistency kit..."
python3 "$ROOT/scripts/check_archviz.py"

echo "Checking consistency kit's own checker..."
python3 "$ROOT/scripts/check_archviz.py" --self-test >/dev/null
