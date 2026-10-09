# handoff.md —— 多 Agent 交接紀錄

## 2026-10-08 初始化（opencode）
- 建立專案骨架：AGENTS.md / README.md / .gitignore / handoff.md / docs/index.html
- GitHub 公開 repo + main 分支推送
- GitHub Pages（docs/ 目錄）啟用
- Obsidian 駕駛艙建立
- 下一步：定義跨 Agent 同步腳本（scripts/）內容

## 2026-10-09 pdfcraft 安裝＋Mac 適性化（opencode）
- 上游 `storytold/pdfcraft` v0.4.0，採官方預編譯包（不從原始碼編譯）
- CLI → `~/.local/bin/pdfcraft-cli`（SHA256 已驗、Developer ID 簽名有效、131 工具）
- GUI → `/Applications/PdfCraft.app`（universal＋公證）
- 實測通過：info／text／combine／extract／split／edit／run／mcp(`--root` 隔離)
- 新增：`pdfcraft/README.md`（安裝＋驗證＋教學任務分工）、`pdfcraft/opencode-mcp-snippet.json`（合併進 `opencode.json` 用，`--root` 預設 Obsidian vault）、`scripts/pdfcraft-check.sh`（版本釘選檢查）
- 分工結論：pdfcraft 只做結構／保真操作（D1 合併拆分、抽頁轉圖、表單填寫、定稿清理）；內容生成（Word／浮水印／圖表／QR）仍走 teaching-file-toolkit；中文內文修改走 Word 重出（pdfcraft CJK 編輯仍弱）
- MCP 尚未寫入全域 `opencode.json`（需使用者確認 `--root` 目錄後手動合併片段）
- 2026-10-09 補：使用者確認走預設，已寫入全域 `opencode.json`（`--root /Users/tunyuan/opencode_0715`，stdio local），JSON 驗證通過；下次啟動 opencode 即生效
