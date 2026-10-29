# new-term-radar 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/zhuyansen/new-term-radar#quick-start
# 更新日期：2026-10-29
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }
if (-not (Get-Command python -ErrorAction SilentlyContinue)) { throw '需要先安装 Python 3' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

python -c "import sys; assert sys.version_info >= (3,10), '需要 Python 3.10+，当前 '+sys.version"
git clone https://github.com/zhuyansen/new-term-radar.git
Set-Location new-term-radar
Copy-Item config.example.json config.json
python -m radar daily --skip x --out report.md
Write-Host "已生成 report.md：先看候选词，再按需配置 AISA_API_KEY 打开 X 信号"

Write-Host ''

Write-Host '部署完成：先看 report.md 里的候选词；要 X 信号再配 AISA_API_KEY，要 MCP 或技能调用按 README 接入'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/zhuyansen/new-term-radar#quick-start'
