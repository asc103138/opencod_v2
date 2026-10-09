# freellm

免費 LLM API 整合子專案（`opencod_v2` 子目錄）。

- 主力：`groq/openai/gpt-oss-120b`（免信用卡，極速）
- 輕量：`groq/openai/gpt-oss-20b`
- 備援：`gemini/gemini-3.8-flash`（1M 上下文，多模態）
- 配置：`~/.config/opencode/opencode.json`（`provider.groq` / `provider.gemini`，key 走 `{env:...}`）
- 模型目錄：https://freellm.net/models/ ｜ 配置產生器：https://freellm.net/config/

## 快速驗證

```bash
source ~/.zshrc
opencode models groq | head -n 20
opencode models gemini
```

> Key 只放本機 `~/.zshrc`，絕不進版控。
