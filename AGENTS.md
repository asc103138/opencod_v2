# opencod_v2 - AGENTS.md

## 專案資訊
- 專案名稱：opencod_v2
- 專案用途：跨 AI Agent 同步——以 chezmoi 為單一來源，同步 opencode ↔ Antigravity（Gemini）技能與全域設定，Apple Silicon Mac 適性化
- 主要工作目錄：`/Users/tunyuan/opencod_v2`
- GitHub Repo：https://github.com/asc103138/opencod_v2（公開）
- GitHub Pages：https://asc103138.github.io/opencod_v2/（`docs/` 目錄）

## 同步對照表
| 內容 | opencode 側 | Antigravity 側 | chezmoi 源 |
|---|---|---|---|
| 全域技能 | `~/.config/opencode/skills`（39 個，去前綴） | `~/.gemini/config/skills`（26 個，`antigravity-*`） | `chezmoi-opencode` / `antigravity-skills` |
| 全域設定 | `~/.config/opencode/opencode.json` | `~/.gemini/config/mcp_config.json` | 同上（`.tmpl` 渲染） |
| 全域指引 | `~/.config/opencode/AGENTS.md` | `AGENTS.md` / `ANTIGRAVITY.md`（各專案） | 同上 |
| 審查規範 | `~/.config/opencode/rules/curriculum-review-protocol.md` | `~/.gemini/config/rules/curriculum-review-protocol.md` | 同上 |

## Obsidian 關聯筆記
- Vault 路徑：`/Users/tunyuan/opencode_0715`
- 專案駕駛艙：`/Users/tunyuan/opencode_0715/04-專案/opencod_v2-專案駕駛艙.md`

## 工作與安全規則
- 回應使用繁體中文（台灣）。
- 開工時讀本檔、讀 Obsidian 駕駛艙、檢查 Git 狀態。
- 收工時更新 Obsidian，檢查 diff 後只提交本次相關檔案。
- 絕不 commit API Key、Token、密碼或個人私密個資。
- Token 一律走本機 `~/.config/chezmoi/chezmoi.toml` 變數注入，不進任何 repo。
- 學生資料僅記錄班級代號與座號，不儲存真名。
- **全域教材審查規範**：凡涉及生成考卷、學習單、教學簡報或教材，必須嚴格落實三階審查（第一階課綱版本門檻、第二階CLT與退回確認、第三階迷思診斷），通過自我檢測並隨附審查報告後始得輸出交付。
