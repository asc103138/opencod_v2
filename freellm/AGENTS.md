# freellm - AGENTS.md

## 專案資訊
- 專案名稱：freellm
- 專案用途：freeAPI —— 免費 LLM API 整合（awesome-freellm-apis 推薦模型接入 OpenCode）
- 主要工作目錄：`/Users/tunyuan/opencod_v2/freellm`
- 父 repo：https://github.com/asc103138/opencod_v2（公開，子目錄追蹤，不另建 repo）
- 主力模型：`groq/llama-3.3-70b-versatile`，輕量：`groq/llama-3.1-8b-instant`，備援：`gemini/gemini-3.8-flash`

## 資料夾結構
```
freellm/
├── AGENTS.md      # 本檔（子專案指引）
├── README.md      # 子專案說明
├── .gitignore     # 子專案忽略（含 .env、key）
├── docs/          # 免費 API 筆記、速率限制對照
└── scripts/       # 連線測試、配置小工具
```

## Obsidian 關聯筆記
- Vault 路徑：`/Users/tunyuan/opencode_0715`
- 專案駕駛艙：`/Users/tunyuan/opencode_0715/04-專案/freellm-專案駕駛艙.md`

## 工作與安全規則
- 回應使用繁體中文（台灣）。
- 絕不 commit API Key、Token、密碼或私密個資；Key 只放 `~/.zshrc`（`GROQ_API_KEY`、`GEMINI_API_KEY`），範例一律用佔位符。
- 學生資料僅記錄班級代號與座號，不儲存真名。
- 免費額度會變動，改模型/限速先查 `https://freellm.net/models/`。
