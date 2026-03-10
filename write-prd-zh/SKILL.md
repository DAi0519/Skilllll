---
name: write-prd-zh
description: Draft Chinese product requirement documents (PRDs) for software features, internal tools, workflows, and product changes. Use when Codex needs to write a PRD in Chinese, turn rough ideas or notes into a structured spec, clarify requirements before implementation, or convert product discussions into a development-ready GitHub issue or Markdown document.
---

# 中文 PRD

## Overview

把模糊想法整理成一份中文 PRD，并让文档足够清晰，能直接支持设计、开发和测试继续往下走。

优先做需求澄清和范围收敛，再落文档。不要一上来就写漂亮废话。

## Workflow

### 1. 明确问题

先用几句话确认这些信息：

- 谁遇到了问题
- 现在为什么不顺
- 这次改动想带来什么结果
- 什么不在这次范围内

如果用户给的信息不足，先提少量高价值问题。优先提能改变方案方向的问题，而不是细枝末节。

当用户不方便来回回答时，允许做有限假设，但必须显式标成“假设”。

### 2. 建立上下文

如果当前工作区有代码、文档、Issue 或设计稿，先读相关内容，再确定方案。

至少确认：

- 当前行为是什么
- 已有模块或流程能复用什么
- 明显的技术约束是什么
- 哪些边界条件会影响需求定义

如果没有代码库上下文，就明确说明这份 PRD 基于概念输入而不是现状核验。

### 3. 收敛决策

在写 PRD 之前，尽量把下面几类决策收敛：

- 核心用户路径
- 成功标准
- 范围边界
- 异常和边界场景
- 关键实现取舍
- 测试重点

优先用对比式问题推动决策，例如“先支持 A 还是同时支持 A+B”，“是否允许手动兜底”，“上线后看哪个指标算成功”。

如果仍有未决项，把它们单独列为“开放问题”，不要混进已确认内容里。

### 4. 撰写 PRD

默认使用 [references/prd-template.md](references/prd-template.md) 的结构。

默认产出这些部分：

- 背景与问题
- 目标
- 方案概述
- 用户故事
- 功能需求
- 实现决策
- 测试决策
- 非目标
- 开放问题
- 后续备注

写作要求：

- 用中文写
- 多写事实和决策，少写口号
- 用户故事和需求描述优先从用户和业务行为出发
- 实现决策写到模块、接口、流程、数据层级即可
- 不写脆弱的文件路径、代码片段或过细的工单级步骤，除非用户明确要求

### 5. 做可执行性检查

完成后快速检查：

- 开发是否能据此开工
- 测试是否知道该测什么
- 范围是否清晰
- 依赖和风险是否被说出来
- 文档里是否混入了未经确认的主观假设

如果文档还不能直接推动下一步，就补“假设”“开放问题”或“待确认决策”。

## Question Strategy

当输入模糊、利益相关方多、或方案分支多时，再读 [references/discovery-questions.md](references/discovery-questions.md)。

提问时遵守这些规则：

- 一次只问少量最关键的问题
- 先问会影响范围和方案方向的问题
- 尽量给用户容易选择的对比项
- 能从代码和现有文档确认的，不要反问用户
- 问不清时先给一版合理假设，再请用户修正

## Output Rules

默认输出 Markdown。

如果用户要的是 GitHub issue 风格：

- 标题短而明确
- 正文结构保持完整
- 每段控制在易扫读的长度

如果用户只想要“先出草稿”，也保持完整结构，但把不确定项集中写在“开放问题”和“假设”里。

## Guardrails

- 不要把 PRD 写成实现清单
- 不要把“可能以后会做”的内容混进本期范围
- 不要为了显得完整而编造指标、约束或用户反馈
- 不要省略边界条件、失败路径和非目标
- 不要在没有证据时断言现有系统能力
