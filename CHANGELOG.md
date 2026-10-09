# Changelog

## 0.2.0 (2026-10-09)

This repo had **no CI and no changelog** before this release — there was no
record of what had shipped and nothing checking that the docs matched the code.

### Added

- **`CHANGELOG.md`** (this file). The repo carried a `metadata.version` of 0.1.0
  with nothing to compare it against, so the version gate had no anchor. The
  0.1.0 section below records what this release is built on, from the code that
  is actually present rather than from an invented history.
- **`scripts/check_archviz.py`** — the family's portable consistency kit
  (archviz-diagram ADR-003). One file, per-repo `archviz-checks.json`, stdlib
  only, no venv and no package import required. Five checks: `version` /
  `budget` / `routing` / `counts` / `cjk`. `--self-test` carries 23 adversarial
  fixtures, four of which must **not** fire.
- **`.github/workflows/ci.yml`** — first CI for this repo.
- **`scripts/git-pre-commit.sh`** — the same gates locally.
- **`.gitattributes`** — pins SKILL.md to LF; the byte cap counts LF-normalised
  bytes.
- **`archviz-checks.json`** — registry: 3 render modes read from SKILL.md's
  `## [6]` / `## [7]` / `## [8]` section headings.

### Changed

- **`description` now names the three render modes.** It described the pipeline
  and the visual style but named none of the modes, so there was no lexical hook
  for "柱状图动画" / "数学可视化" / "物理场可视化" — or for their English names.
  Each mode is now named in both languages, which is also what gives the `counts`
  check a claim to hold.
- Version 0.1.0 → 0.2.0.

### Verified

- `scripts/check_archviz.py` → PASS (5/5)
- `scripts/check_archviz.py --self-test` → 23/23

## 0.1.0

Baseline, recorded retroactively on 2026-10-09 from the repository contents.

Three render modes, each with a spec example and a renderer:

| Mode | Section | Renderer | Example spec |
|---|---|---|---|
| 柱状图动画 (Bar Chart Animation) | SKILL.md §[6] | `scripts/render_animated_bar_chart.py` | `examples/bar-chart-spec.json` |
| 数学可视化 (Math Visualization) | SKILL.md §[7] | `scripts/render_math_visualization.py` | `examples/math-viz-spec.json` |
| 物理场可视化 (Yang-Mills Gauge Field) | SKILL.md §[8] | `scripts/render_yang_mills.py` | `examples/yang-mills.html` |

Pipeline: content analysis → JSON spec → Python render → three deliverables
(`.excalidraw` editable source + PNG + GIF). Dark hand-drawn style, glow + pulse
motion, no image API, fully deterministic. Dependency: `Pillow>=10.0.0`.

> This section is **not** a historical changelog entry — no such entry existed.
> It is a dated record of the state at the time the changelog was introduced, so
> the version gate has something to check against instead of an empty file.
