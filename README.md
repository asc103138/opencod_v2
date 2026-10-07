# opencod_v2

跨 AI Agent 同步專案：以 chezmoi 為單一來源，在 Apple Silicon Mac 上同步
**opencode ↔ Antigravity（Gemini）** 的全域技能與設定。

- 網站：https://asc103138.github.io/opencod_v2/
- 駕駛艙：Obsidian `04-專案/opencod_v2-專案駕駛艙.md`

## 結構

- `AGENTS.md` —— 專案規則入口（含同步對照表）
- `handoff.md` —— 多 Agent 交接紀錄
- `docs/index.html` —— GitHub Pages 落地頁
- `scripts/` —— 同步輔助腳本（預留）

## 同步指令

```bash
# opencode 側（獨立源）
chezmoi apply --source ~/.local/share/chezmoi-opencode -v

# Antigravity 側（預設源）
chezmoi update
```
