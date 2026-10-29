#!/usr/bin/env bash
set -euo pipefail
# new-term-radar 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/zhuyansen/new-term-radar#quick-start
# 更新日期：2026-10-29
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }
command -v python3 >/dev/null 2>&1 || command -v python >/dev/null 2>&1 || { echo "需要先安装 Python 3"; exit 1; }

mkdir -p .download
cd .download

python -c "import sys; assert sys.version_info >= (3,10), '需要 Python 3.10+，当前 '+sys.version"
git clone https://github.com/zhuyansen/new-term-radar.git
cd new-term-radar
cp config.example.json config.json
python -m radar daily --skip x --out report.md
echo "已生成 report.md：先看候选词，再按需配置 AISA_API_KEY 打开 X 信号"

echo ""

echo "部署完成：先看 report.md 里的候选词；要 X 信号再配 AISA_API_KEY，要 MCP 或技能调用按 README 接入"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/zhuyansen/new-term-radar#quick-start"
