# Skilllll

给 Claude Code / Codex 用的一组中文 Skills。

## 可用 Skills

<table>
  <thead>
    <tr>
      <th align="left" width="220"><span style="white-space: nowrap;">Skill</span></th>
      <th align="left" width="220"><span style="white-space: nowrap;">命令</span></th>
      <th align="left">说明</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><span style="white-space: nowrap;"><code>PRD</code></span></td>
      <td><span style="white-space: nowrap;"><code>/prd</code></span></td>
      <td>把模糊想法变成完整的中文需求文档，支持项目启动和功能改动两种场景</td>
    </tr>
    <tr>
      <td><span style="white-space: nowrap;"><code>Design System</code></span></td>
      <td><span style="white-space: nowrap;"><code>/design-system</code></span></td>
      <td>从 PRD、现有代码库或参考风格生成轻量 <code>DESIGN.md</code> 视觉方向纲领，默认不产出重型 token、主题配置或预览页</td>
    </tr>
    <tr>
      <td><span style="white-space: nowrap;"><code>DAi-paper</code></span></td>
      <td><span style="white-space: nowrap;"><code>/DAi-paper</code></span></td>
      <td>基于李继刚老师的 <a href="https://github.com/lijigang/ljg-skills">ljg-skills</a> 思路优化，主要读近 1-2 年的 <code>AIGC / 空间智能 / 交互</code> 方向论文，输出结构化 Markdown 笔记；如果线程里已确认可写 Notion 目标，默认同步到 Notion 数据库</td>
    </tr>
  </tbody>
</table>

## 支持的工具

安装脚本会自动检测并写入已安装的目标目录：

- `Claude Code`
- `Codex`

安装完成后需要手动重启工具，skill 才会重新加载。

## Design System 说明

`/design-system` 现在默认生成一份轻量 `DESIGN.md`，用于给后续 UI 工作提供审美方向和执行约束，而不是一开始就生成完整设计系统资产包。

它的默认取向：

- 尊重用户提供的参考图、竞品、风格词和偏好，在用户观点基础上优化，而不是替用户改口味
- 默认偏 MUJI / Dieter Rams 式克制、高效、低噪声审美，但不把任何一家风格奉为唯一标准
- 保留 Apple / Jobs 式产品纪律：敢说“不”、追问真实动机、拒绝平庸妥协
- 强化信息层级、排版优雅、对齐、间距、文本密度和无意义信息删除
- 默认只产出 `DESIGN.md`；只有用户明确要求时才扩展 `tokens.css`、预览页或完整设计系统

## 安装

默认安装全部 skills。

### macOS / Linux / WSL

```bash
# 安装全部
curl -sL https://raw.githubusercontent.com/DAi0519/Skilllll/main/install.sh | bash

# 只安装某个 skill
curl -sL https://raw.githubusercontent.com/DAi0519/Skilllll/main/install.sh | SKILL=prd bash
curl -sL https://raw.githubusercontent.com/DAi0519/Skilllll/main/install.sh | SKILL=design-system bash
curl -sL https://raw.githubusercontent.com/DAi0519/Skilllll/main/install.sh | SKILL=DAi-paper bash
```

### Windows (PowerShell)

```powershell
# 安装全部
irm https://raw.githubusercontent.com/DAi0519/Skilllll/main/install.ps1 | iex

# 只安装某个 skill
$env:SKILL="prd"; irm https://raw.githubusercontent.com/DAi0519/Skilllll/main/install.ps1 | iex
$env:SKILL="design-system"; irm https://raw.githubusercontent.com/DAi0519/Skilllll/main/install.ps1 | iex
$env:SKILL="DAi-paper"; irm https://raw.githubusercontent.com/DAi0519/Skilllll/main/install.ps1 | iex
```

## 使用示例

```text
/prd 我想做一个帮助独立开发者管理客户反馈的工具
```

```text
/design-system 基于这个 PRD 生成一份 DESIGN.md 视觉方向纲领
```

```text
/DAi-paper 找一篇最近两年的空间智能论文，读完后本地一份，Notion 数据库一份
```

## 仓库结构

```text
.
├── PRD/
├── Design-system/
├── DAi-paper/
├── install.sh
└── install.ps1
```

每个目录都是一个独立 skill，核心说明写在各自的 `SKILL.md` 里。

## 卸载

### macOS / Linux / WSL

```bash
# 卸载全部
rm -rf ~/.claude/skills/prd ~/.claude/skills/design-system ~/.claude/skills/DAi-paper
rm -rf ~/.codex/skills/prd ~/.codex/skills/design-system ~/.codex/skills/DAi-paper

# 卸载单个
rm -rf ~/.claude/skills/prd
rm -rf ~/.codex/skills/prd
rm -rf ~/.claude/skills/design-system
rm -rf ~/.codex/skills/design-system
rm -rf ~/.claude/skills/DAi-paper
rm -rf ~/.codex/skills/DAi-paper
```

### Windows (PowerShell)

```powershell
# 卸载全部
Remove-Item -Recurse -Force "$env:USERPROFILE\.claude\skills\prd", "$env:USERPROFILE\.claude\skills\design-system", "$env:USERPROFILE\.claude\skills\DAi-paper"
Remove-Item -Recurse -Force "$env:USERPROFILE\.codex\skills\prd", "$env:USERPROFILE\.codex\skills\design-system", "$env:USERPROFILE\.codex\skills\DAi-paper"

# 卸载单个
Remove-Item -Recurse -Force "$env:USERPROFILE\.claude\skills\prd"
Remove-Item -Recurse -Force "$env:USERPROFILE\.codex\skills\prd"
Remove-Item -Recurse -Force "$env:USERPROFILE\.claude\skills\design-system"
Remove-Item -Recurse -Force "$env:USERPROFILE\.codex\skills\design-system"
Remove-Item -Recurse -Force "$env:USERPROFILE\.claude\skills\DAi-paper"
Remove-Item -Recurse -Force "$env:USERPROFILE\.codex\skills\DAi-paper"
```
