# new-term-radar 一键部署指南

> 第三方部署指南 · 非 new-term-radar 官方仓库。官方项目：[zhuyansen/new-term-radar](https://github.com/zhuyansen/new-term-radar)
> 内容来自官方文档（2026-10-29）。项目迭代快，请以[官方文档](https://github.com/zhuyansen/new-term-radar#quick-start)为准。

[![⚡ 一键部署](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E9%83%A8%E7%BD%B2-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键部署推荐用百度搭子)

## 一键部署（推荐：用百度搭子）

> [!TIP]
> 新模型、新产品、新仓库刚有名字的时候就把它们抓出来，比关键词工具早几天到几周。

⚠️ 需要 Python 3.10+，只用标准库，不需要 pip 装依赖。X 信号要 AISA_API_KEY，可先用 --skip x 跳过；GitHub token 可选，只用于提高限额。报告输出为 Markdown。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/new-term-radar-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会检查 Python 3.10+，克隆仓库、复制配置并跑一次日报，先跳过需要 Key 的 X 信号，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## new-term-radar 是什么？

new-term-radar 是开源的每天从 X、Hugging Face、GitHub 与站点地图里抓正在冒头的新名字（协议：MIT，<img src="https://img.shields.io/github/stars/zhuyansen/new-term-radar?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

把新名字出现的顺序拆成六个信号：X 首次提及、Hugging Face 趋势、GitHub 新仓库爆发、站点地图新词、新站首页、Search Console；再用名字评分与 14 天复盘，输出每日候选词报告。

- GitHub 爆发：14 天内日均 200+ 星的新仓库
- Hugging Face：新进趋势榜的模型与 Space
- X 首提：名单账号 60 天内第一次说的名字
- 站点地图：新 URL 共享、老页面少见的词
- 关键词表：页面竞争、域名、排名与 12 个月曲线
- 14 天复盘：回看当时报的词有没有涨
- 多种调用：CLI、MCP server、Agent Skills

（来源：[官方仓库](https://github.com/zhuyansen/new-term-radar)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 1 | . |
| 思 | 路 |
| 零 | 依 |
| 多 | 入 |
| 有 | 复 |
| M | I |

| 需要注意 | 说明 |
|---|---|
| X |   |
| 第 | 一 |
| 站 | 点 |
| 输 | 出 |
| 项 | 目 |

> 以上基于官方文档与社区反馈整理（2026-10-29），以官方最新文档为准。

## 快速部署（官方方式）

```bash
python -c "import sys; assert sys.version_info >= (3,10), '需要 Python 3.10+，当前 '+sys.version"
git clone https://github.com/zhuyansen/new-term-radar.git
cd new-term-radar
cp config.example.json config.json
python -m radar daily --skip x --out report.md
echo "已生成 report.md：先看候选词，再按需配置 AISA_API_KEY 打开 X 信号"
```

部署步骤来源：[https://github.com/zhuyansen/new-term-radar#quick-start](https://github.com/zhuyansen/new-term-radar#quick-start)

## 验证状态

| 场景 | 状态 |
|---|---|
| README Quick start 确认 Python 3.10+、标准库、--skip x 用法 | 已核对 2026-10-29 |
| README 确认六个信号、MCP server 与 Skills 入口 | 已核对 2026-10-29 |
| 未实测日报抓取（未配置 AISA_API_KEY） | 说明 2026-10-29 |
| MCP 冒烟：initialize / tools/list 返回 get_guide、search_guide、get_project_info | 已验证 2026-10-29 |
| 非目标宿主调用 get_guide 被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-29 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

项目自带 MCP server 与 Agent Skills（也发在 PyPI 与 MCP Registry）；本仓库的 MCP 只提供部署步骤、参数与常见问题。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-29）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\new-term-radar-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 第一次运行

第一次跑没有「昨天」的快照，只会报 GitHub 爆发；从第二次开始，其它信号才能看出变化。

```bash
python -m radar daily --out report.md          # 每天一次，全信号
python -m radar sources --out sources.md       # 只跑 X 与 Hugging Face，可几小时一次
python -m radar daily --skip x,hf --out report.md
```

## 配置

`config.json` 里主要改三块：

- X 账号名单：你想盯的实验室、作者、媒体
- 站点地图：要监控的目录站与工具站
- 主题词：用来判断新词是否与你相关

X 信号要先设 `AISA_API_KEY`（https://go.aisa.one/yansen-zhu ），不想用就加 `--skip x`。

## 接到 Agent

README 给了 MCP server 与 Skills 的接入方式，也可以用 `--state DIR` 把快照与数据库放到固定目录，方便定时任务复用。

## 注意

- 只用标准库，但首次运行要联网抓公开数据
- 站点地图信号依赖你列的站点，站方改结构会失效
- 报告是候选词，不是结论；落地前自己核一遍搜索结果
- 免费源没有配额保证，量大时加 GitHub token

## 常见坑

- Python 版本不够：升到 3.10+
- radar 模块找不到：确认在仓库根目录执行 python -m radar
- 没有 X 结果：先加 --skip x，或配置 AISA_API_KEY
- 第一次报告很少：正常，第二天才有对比快照
- GitHub 限流：配一个只读 token 提高限额
- 定时任务重复抓：用 --state 指定固定目录保存快照

## 免责声明

本仓库为第三方指南，与 new-term-radar 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-29），项目迭代快，请以[官方文档](https://github.com/zhuyansen/new-term-radar#quick-start)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
