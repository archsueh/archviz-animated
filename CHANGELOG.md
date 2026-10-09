# Changelog

## 0.2.1 (2026-10-09)

### Fixed

- **`scripts/render_yang_mills.py` 根本编译不过 —— 这个脚本从来没有运行过。**
  `main()` 在第 263–264 行**读取** `GAUGE_STRENGTH` / `SELF_COUPLING`（作为
  `add_argument(default=...)`），却在第 267 行才写 `global` 声明 ——
  Python 要求 `global` 出现在函数内**任何**使用之前，所以这是 `SyntaxError:
  name 'GAUGE_STRENGTH' is used prior to global declaration`。修法是把 `global`
  移到 `main()` 第一行。**这是新加的字节编译 CI 步骤上线后立刻抓到的第一个真缺陷**
  —— 在此之前没有任何东西会执行或编译这个文件。
- **`requirements.txt` 只声明了 Pillow，漏了三个真实 import。**
  `scripts/render_yang_mills.py` 顶层 `import matplotlib / numpy / scipy` ——
  干净检出跑这个脚本会直接 `ImportError`。现补齐，并由套件新增的 `deps` 检查守住
  不再复发。同一缺陷在**家族五个仓库里全部存在**。
- **`references/` 里有文件谁也到不了？没有。** 本仓三个参考文件此前都已被
  SKILL.md 的 `## [9] 参考文档` 表点名 —— 是家族里唯一本来就合规的仓库。
  套件新增的 `coverage` 检查在此首跑即通过。

### Changed

- **`design-judgment` 集成块移出 SKILL.md 正文。** 2026-10-09 20:32:55 有并行会话
  在五个 archviz 仓库的 SKILL.md 末尾各追加了一段 956 字节的
  `<!-- design-judgment-integration -->` 块。**内容逐字保留，未删改一字**，
  现移入 `references/design-judgment.md`，正文只留一行指针，并在
  `## [9] 参考文档` 表里补一行。SKILL.md 10,950 → 10,480 字节。

### Added

- **`coverage` 检查** —— `references/*.md` 必须从 SKILL.md 可达。
- **`deps` 检查** —— 把仓库里每个第三方 import 与清单对账。

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
