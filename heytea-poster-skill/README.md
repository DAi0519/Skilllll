# 喜茶风海报 Skill

一个用于 Claude Code / Codex 的非官方海报生成 Skill。它完整加载手写体海报 Prompt 母版，根据用户主题生成自然、安静、留白充足的手写体海报或可复制的图像生成提示词。

> 非官方项目，仅用于风格研究与创作实践，与喜茶品牌不存在隶属、合作或授权关系。

## 安装

macOS / Linux / WSL：

```bash
curl -sL https://raw.githubusercontent.com/DAi0519/Skilllll/main/install.sh | SKILL=heytea-poster-skill bash
```

Windows PowerShell：

```powershell
$env:SKILL="heytea-poster-skill"; irm https://raw.githubusercontent.com/DAi0519/Skilllll/main/install.ps1 | iex
```

安装后重启 Claude Code 或 Codex。

## 使用

显式调用：

```text
使用 $heytea-poster-skill，为“雨天散步”生成一张安静留白的手写体海报。
```

也可以直接描述：

```text
做一张喜茶风海报，主标题是“慢慢喝”，辅助句是“把时间留给茶”。
```

如果只需要提示词，请明确说“只输出图像生成 prompt，不生成图片”。
