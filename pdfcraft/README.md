# pdfcraft｜Mac (Apple Silicon) 適性化

> 上游：<https://github.com/storytold/pdfcraft>（PdfCraft：純 Rust 的開源 Acrobat-like PDF 工作台）
> 本目錄只放 Mac 適性化筆記與設定片段，**不放二進位、不放原始碼**（upstream 為準）。

## 1. 安裝（2026-10-09，v0.4.0，已驗證）

採用官方預編譯包（已簽名＋公證，universal x86_64/arm64），不從原始碼編譯（本機無 Rust 工具鏈，且日常使用不需要）。

| 元件 | 檔案 | SHA256 | 安裝位置 |
|---|---|---|---|
| CLI | `pdfcraft-cli-0.4.0-macos-universal.zip` | `a8bf7a42…b79ffe` | `~/.local/bin/pdfcraft-cli` |
| GUI App | `pdfcraft-0.4.0-macos-universal.dmg` | `740da490…254fa10` | `/Applications/PdfCraft.app` |

簽名：`Developer ID Application: Learning Machines LLC (DJ6XS33FX8)`，`codesign` 驗證通過。
完整校驗值見上游 `SHA256SUMS.txt`（下載時已用 `shasum -a 256 -c` 驗過）。

```bash
# 版本確認
pdfcraft-cli --version          # pdfcraft-cli 0.4.0
pdfcraft-cli tools | head -5    # 131 個工具（JSON Schema）
```

## 2. 功能驗證結果（本機實測 ✅）

| 指令 | 結果 |
|---|---|
| `info a.pdf` | 結構 JSON（頁數、尺寸、書籤、加密狀態）正常 |
| `text a.pdf` | 閱讀順序文字正常 |
| `combine a.pdf b.pdf --out combined.pdf` | 2 頁合併，書籤自動各一 |
| `extract combined.pdf --pages 2 --out just-b.pdf` | 單頁抽取，文字正確 |
| `split combined.pdf --every 1 --out-dir parts/` | 逐頁分割正常 |
| `edit combined.pdf --rotate 1:90 --title "QC-TEST" --out edited.pdf` | 旋轉＋改標題正常 |
| `run doc_open path=a.pdf` | headless 工具呼叫正常 |
| `mcp --root <dir>` | stdio MCP 回 `tools/list` 正常（含 `--root` 目錄隔離） |

## 3. opencode MCP 串接

`opencode-mcp-snippet.json` 是可直接合併進 `~/.config/opencode/opencode.json` 的 `mcp` 片段
（格式與現有 `notebooklm`、`obsidian` 條目一致）。重點：

- 只用 stdio，本機程序，**不開網路埠**（PdfCraft 預設不啟動 server）。
- `--root` 把可讀寫範圍鎖在單一目錄（建議按專案設，例如考卷工作區）。
- Token 省量可用 `--compact`（tool list 縮成 ~10 個核心＋`tool_search`/`tool_call`）。
- 不想收錄 MCP server 的建置可用 `cargo build -p pdfcraft-cli --no-default-features`（原始碼編譯才需要）。

```bash
# 手動測試 MCP（關掉 stdin 即停止）
echo '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}' \
  | pdfcraft-cli mcp --root ~/Downloads/pdfs | head -c 300
```

## 4. 教學任務分工（teaching-file-toolkit 對照）

pdfcraft **只做「結構與保真操作」**，不做內容生成：

| 教學任務 | 用 pdfcraft | 仍用 Python 工具包 |
|---|---|---|
| D1 合併／拆分／抽頁 | ✅ `combine`、`split`、`extract`（書籤、連結、表單、圖層、附件保留，原位元組增量保存） | — |
| 頁面整理（旋轉／刪除／搬移／插入空白頁） | ✅ `edit`、`page_*`，undo 可走 `run` | — |
| D4 抽頁轉圖 | ✅ `render`（`page_render` → PNG） | 去白邊／合成仍用 pillow |
| 文字抽取（餵 AI） | ✅ `text`（閱讀順序，欄位／RTL／CJK 順序正確） | 大量轉 Markdown 仍用 markitdown／PyMuPDF |
| 表單填寫 | ✅ `form_fill`、欄位清單 `form_fields` | 套印獎狀（讀 Excel＋模板）仍用 python-docx 流程 |
| D2 浮水印 | ⚠️ 有 `stamp_custom`，但中文浮水印字型＋淡灰圖層仍建議 reportlab | ✅ reportlab（現行做法不變） |
| 考卷定稿清理 | ✅ `doc_hidden_info`／sanitize（去隱藏資訊）、加密 `protect` | — |
| W2/E1/E2/P1–P3、QR Code、圖表 | —（pdfcraft 不生成內容） | ✅ 原工具包不變 |

上游已知限制（ROADMAP，2026-10）：既有文字的可靠編輯（尤其 CJK）、中文 OCR、Office 匯入匯出、XFA 表單仍弱。
**中文考卷內文修改一律走 Word 流程重出 PDF**，不要指望 pdfcraft 改字。

## 5. 日常指令速查

```bash
pdfcraft-cli info  form.pdf                        # 結構 JSON
pdfcraft-cli text  paper.pdf --page 3              # 第 3 頁閱讀順序文字
pdfcraft-cli edit  in.pdf --rotate 1,2:90 --delete 5 --title "Q3" --out out.pdf
pdfcraft-cli combine report.pdf appendix.pdf --out combined.pdf
pdfcraft-cli extract report.pdf --pages 1,3,5 --out highlights.pdf
pdfcraft-cli split   report.pdf --every 10 --out-dir parts/
pdfcraft-cli tools                                  # 全部工具＋JSON Schema
```

## 6. 維護

- 升級：到上游 Releases 抓新版 `pdfcraft-cli-<ver>-macos-universal.zip`（驗 SHA → 蓋掉 `~/.local/bin/pdfcraft-cli` → 跑 `scripts/pdfcraft-check.sh`）。
- GUI App 同理換 DMG。兩者版本保持一致。
- 本目錄不追蹤 `.dmg`/`.zip`/二進位（見根 `.gitignore` 精神：大檔不上 repo）。
