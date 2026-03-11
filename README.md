#PRD Skill

把一句产品意图变成一份完整的中文需求文档，面向 AI agent 执行，而不是给人类分配工单。

支持两种场景：**项目启动**（从零定义产品）和**功能改动**（在现有系统上增改需求）。
支持三条链路：`PRD` / `PRD → Plan` / `PRD → Plan → Issues`。

---

## 安装

### macOS / Linux / WSL

```bash
curl -sL https://raw.githubusercontent.com/DAi0519/Skilllll/main/install.sh | bash
```

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/DAi0519/Skilllll/main/install.ps1 | iex
```

安装后重启 Claude Code 即可使用 `/prd`。

---

## 使用

```
/prd 我想做一个帮助独立开发者管理客户反馈的工具
```

```
/prd 在现有订单系统里加一个退款申请流程
```

```
/prd 帮我定义这个项目，顺手拆计划和 issues
```

产物默认保存在当前项目的 `PRD-Outputs/` 目录下。

---

## 卸载

### macOS / Linux / WSL

```bash
rm -rf ~/.claude/skills/prd
```

### Windows (PowerShell)

```powershell
Remove-Item -Recurse -Force "$env:USERPROFILE\.claude\skills\prd"
```
