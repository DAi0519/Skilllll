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
      <td>从 PRD 或现有代码库生成设计系统规范与代码资产，输出 token、主题配置、预览页和组件规范</td>
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
/design-system 基于这个 PRD 生成设计系统规范和 token
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
