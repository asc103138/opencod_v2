#!/bin/zsh
# pdfcraft 安裝檢查（Mac / Apple Silicon）
# 用法：./scripts/pdfcraft-check.sh
# 檢查 CLI＋GUI 是否存在、版本是否一致、基本功能是否正常。
set -u
PIN="0.4.0"
ok=1

echo "== pdfcraft 安裝檢查（期望版本 v${PIN}）=="

if ! command -v pdfcraft-cli >/dev/null 2>&1; then
  echo "❌ pdfcraft-cli 不在 PATH（期望 ~/.local/bin/pdfcraft-cli）"
  ok=0
else
  ver="$(pdfcraft-cli --version 2>&1 | head -1)"
  echo "✅ CLI：${ver} ($(command -v pdfcraft-cli))"
  case "${ver}" in
    *"${PIN}"*) ;;
    *) echo "⚠️ CLI 版本與釘選 ${PIN} 不一致";;
  esac
fi

if [[ -d "/Applications/PdfCraft.app" ]]; then
  echo "✅ GUI：/Applications/PdfCraft.app 存在"
else
  echo "⚠️ GUI：/Applications/PdfCraft.app 不存在（CLI 仍可獨立使用）"
fi

if [[ "${ok}" == "1" ]]; then
  tmp="$(mktemp -d)/pc-check-$$"
  mkdir -p "${tmp}" && cd "${tmp}" || exit 1
  /usr/bin/python3 -c "
open('t.pdf','wb').write(b'%PDF-1.4\n1 0 obj<</Type/Catalog/Pages 2 0 R>>endobj\n2 0 obj<</Type/Pages/Kids[3 0 R]/Count 1>>endobj\n3 0 obj<</Type/Page/Parent 2 0 R/MediaBox[0 0 200 200]>>endobj\nxref\n0 4\n0000000000 65535 f \n0000000009 00000 n \n0000000058 00000 n \n0000000107 00000 n \ntrailer<</Size 4/Root 1 0 R>>\nstartxref\n190\n%%EOF')"
  if pdfcraft-cli info t.pdf >/dev/null 2>&1; then
    echo "✅ 煙霧測試：info 解析正常"
  else
    echo "❌ 煙霧測試：info 失敗"; ok=0
  fi
  cd / && rm -rf "${tmp}"
fi

[[ "${ok}" == "1" ]] && echo "全部通過" || echo "有項目未通過，見 pdfcraft/README.md §1 重裝"
exit $((1 - ok))
