# Skilllll

一组面向 AI agent 的 Skill 合集，让 Claude Code / Codex 拥有更专业的工作流。

## 包含的 Skills

| Skill | 命令 | 说明 |
|-------|------|------|
| **PRD** | `/prd` | 把模糊想法变成完整的中文需求文档，支持项目启动和功能改动两种场景 |
| **Design System** | `/design-system` | 从 PRD 或现有代码库生成设计系统规范与代码资产，输出 token、主题配置、预览页和组件规范 |

---

## 安装

默认安装全部 skill。

### macOS / Linux / WSL

```bash
# 安装全部
curl -sL https://raw.githubusercontent.com/DAi0519/Skilllll/main/install.sh | bash

# 只安装某个 skill
curl -sL https://raw.githubusercontent.com/DAi0519/Skilllll/main/install.sh | SKILL=prd bash
curl -sL https://raw.githubusercontent.com/DAi0519/Skilllll/main/install.sh | SKILL=design-system bash
```

### Windows (PowerShell)

```powershell
# 安装全部
irm https://raw.githubusercontent.com/DAi0519/Skilllll/main/install.ps1 | iex

# 只安装某个 skill
$env:SKILL="prd"; irm https://raw.githubusercontent.com/DAi0519/Skilllll/main/install.ps1 | iex
$env:SKILL="design-system"; irm https://raw.githubusercontent.com/DAi0519/Skilllll/main/install.ps1 | iex
```

安装脚本会自动检测已安装的工具（Claude Code / Codex），并写入对应目录。**安装完成后需手动重启工具**。

---

## 使用

```
/prd 我想做一个帮助独立开发者管理客户反馈的工具
```

```
/design-system 基于这个 PRD 生成设计系统规范和 token
```

---

## 卸载

### macOS / Linux / WSL

```bash
# 卸载全部
rm -rf ~/.claude/skills/prd ~/.claude/skills/design-system
rm -rf ~/.codex/skills/prd ~/.codex/skills/design-system

# 卸载单个
rm -rf ~/.claude/skills/prd
rm -rf ~/.claude/skills/design-system
```

### Windows (PowerShell)

```powershell
# 卸载全部
Remove-Item -Recurse -Force "$env:USERPROFILE\.claude\skills\prd", "$env:USERPROFILE\.claude\skills\design-system"
Remove-Item -Recurse -Force "$env:USERPROFILE\.codex\skills\prd", "$env:USERPROFILE\.codex\skills\design-system"

# 卸载单个
Remove-Item -Recurse -Force "$env:USERPROFILE\.claude\skills\prd"
Remove-Item -Recurse -Force "$env:USERPROFILE\.claude\skills\design-system"
```
