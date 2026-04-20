# DESIGN.md 风格写作指南 (DESIGN.md Writing Guide)

这个参考文件用于把设计系统文档从“有 token 的规范书”提升成“AI 一读就能生成对味界面”的视觉语言文档。

目标不是复制品牌，而是学习一套对模型更友好的表达方式：

- 先锁定整体气质
- 再给出具体视觉证据
- 最后补足 token、组件、禁忌和 prompt

---

## 一、为什么这套写法有效

常见设计系统文档的问题不是信息不够，而是信息顺序不对：

- 一上来就列 token，模型知道“值”，但不知道“气质”
- 只写抽象原则，模型知道“方向”，但不知道“长相”

优秀的 DESIGN.md 会把两者合并：

1. 第一屏先让模型形成明确画面感
2. 后续章节再用颜色、字体、圆角、阴影、组件去证明这个画面感

---

## 二、推荐的首段公式

第一段建议使用这个公式：

```markdown
[产品名] 以 [产品类别 / 使用场景] 为基底，
再通过 [2-4 个具体视觉杠杆] 强化其气质。
整体感受应当是 [情绪/质感]，
最适合 [3 类页面或产品场景]。
```

### 好的视觉杠杆

- 轻字重大标题
- 黑白精密排版
- 暖白背景与柔和表面
- 高密度数据容器
- 低圆角保守组件
- 品牌色阴影
- 单一强调色
- 全幅媒体驱动
- 超宽留白与慢节奏分区
- 单色 UI + 彩色内容源

### 不好的写法

- 高级
- 简洁
- 现代
- 有质感
- 很科技
- 很国际化

这些词只能作为结果，不能作为证据。

---

## 三、九段式结构

### 1. Visual Theme & Atmosphere

回答四个问题：

- 它本质上是什么产品
- 它最核心的视觉反差在哪里
- 它应该让用户感受到什么
- 它最适合哪些页面

建议包含：

- 1-3 段整体描述
- `Key Characteristics` 列表，5-8 条

`Key Characteristics` 应优先写这种内容：

- 主画布颜色与文本对比
- 字体选择与字重策略
- 阴影是品牌化的还是完全克制的
- 圆角是保守还是夸张
- 信息密度高还是低
- 交互是否强调 hover / motion / chrome

### 2. Color Palette & Roles

不要只列色值，要说明“角色”。

推荐结构：

- `Primary`
- `Accent`
- `Neutral Scale`
- `Surface & Borders`
- `Semantic`
- `Shadow / Overlay`

要求：

- 优先用“角色 + 值 + 用途”
- 重要颜色必须写出不能误用的边界

### 3. Typography Rules

除了字号表，还要解释排版哲学。

最低要求：

- Primary / Mono / Display / Serif 等角色
- 层级表：字号、字重、行高、字距、适用范围
- 原则说明：为什么重、为什么轻、哪里紧、哪里松

### 4. Component Stylings

组件章节不要只写“有 Button / Input / Card”。

每个核心组件至少回答：

- 默认背景 / 文字 / 边框 / 圆角
- padding / 高度 / 阴影
- hover / active / focus / disabled
- 适合用在哪

优先按下面顺序描述：

1. 默认态长什么样
2. 状态怎么变
3. 哪些 token 决定它

### 5. Layout Principles

建议覆盖：

- 基础 spacing scale
- 容器宽度
- section 节奏
- 栅格与断点
- 信息密度
- 页面是否强调 full-bleed / card grid / editorial flow

### 6. Depth & Elevation

很多文档漏掉这部分，但模型很需要。

应明确：

- 是否用阴影
- 阴影是中性色还是品牌色
- 边框是否比阴影更重要
- 是否允许 blur / glass / vignette
- 焦点环长什么样

### 7. Do's and Don'ts

这是防跑偏章节，必须够具体。

好的 `Do` 示例：

- 用 4px-8px 的保守圆角，不要做满屏药丸
- 标题保持轻字重，不要改成 700
- 所有悬浮层用带蓝调的阴影，而不是中性黑影

好的 `Don't` 示例：

- 不要使用渐变按钮
- 不要把装饰色变成主 CTA 色
- 不要在标题上使用正字距

### 8. Responsive Behavior

回答：

- 断点如何变化
- 导航如何折叠
- 版心如何缩放
- 触控目标是否需要增大
- 图片/视频如何裁切

### 9. Agent Prompt Guide

这是给未来 agent 用的。

建议包含：

- `Quick Color Reference`
- `Example Component Prompts`
- `Iteration Guide`

Prompt 示例应尽量可复制：

```markdown
"创建一个主 CTA：深色背景、1px 细边框、6px 圆角、16px 文本、hover 时仅提升阴影，不改变色相。"
```

---

## 四、写作原则

### 1. 先定调，再举证

顺序应始终是：

1. 这是什么感觉
2. 这个感觉由什么视觉事实支撑
3. 这些事实如何落成 token 与组件

### 2. 形容词必须可追溯

如果写：

- 克制
- 温暖
- 工程化
- 奢华
- 编辑感

就必须立刻给出对应视觉证据，例如：

- 克制 = 单一强调色 + 低圆角 + 边框重于阴影
- 温暖 = 暖白背景 + 深棕文字 + 柔和表面分层
- 工程化 = 紧字距标题 + 单色 UI + 规则网格 + mono 标签

### 3. token 不是附录，而是证据

好的 token 表不是孤立的，它应该回扣前文：

- 为什么主色是这个色
- 为什么 heading 不用纯黑
- 为什么 focus ring 要偏蓝
- 为什么 radius 只给三档

### 4. 写“禁止项”很重要

如果不写 `Don't`，模型通常会自动补一些流行但不属于当前风格的设计：

- 渐变
- 大阴影
- 大面积玻璃拟态
- 过多强调色
- 超圆角胶囊化

### 5. 给未来 agent 留 prompt 入口

一个好的设计系统文档，应该让后续 agent 可以不重读整篇也能快速调用。

### 6. 显式写出 Anti-generic Rules

除了 `Do / Don't`，建议在文档前部或方案阶段直接写出：

```markdown
### Anti-generic Rules
- 不要使用与品牌无关的渐变背景
- 不要默认把所有组件做成 16px+ 大圆角
- 不要让多个强调色同时竞争 CTA
```

这能显著减少后续 agent 回退到默认 SaaS 风格的概率。具体失败模式和纠偏方法见 [Anti-Generic Heuristics](anti-generic-heuristics.md)。

---

## 五、从项目资产推导视觉语言

### 有代码时

从这些地方提取证据：

- 现有色值与变量
- 字体导入
- 常见圆角与阴影
- 页面密度
- 卡片/表格/表单的默认结构
- 空态 / loading / error 是否已有视觉模式

### 有 PRD 时

从这些地方推导：

- 产品类型
- 用户心理状态
- 页面任务密度
- 品牌语气
- 是否偏工具型 / 展示型 / 内容型 / 数据型

### 有参考品牌时

提炼：

- 视觉结构
- 排版节奏
- 信息密度
- 交互语气
- 色彩策略

不要直接搬：

- 品牌 logo 色
- 专有字体名称
- 专属 copy
- 独特图形资产

---

## 六、可复用模板

```markdown
# [Product Name] Design System

## 1. Visual Theme & Atmosphere

[产品] 以 [产品类别] 为基底，
再通过 [2-4 个具体视觉杠杆] 强化气质。
整体感受应为 [情绪]。
它最适合 [3 类场景]。

**Key Characteristics:**
- ...
- ...
- ...

### Anti-generic Rules
- ...
- ...
- ...

## 2. Color Palette & Roles
### Primary
- ...

### Accent
- ...

### Neutral Scale
- ...

### Surface & Borders
- ...

## 3. Typography Rules
### Font Family
- ...

### Hierarchy
| Role | Size | Weight | Line Height | Letter Spacing | Use |
|------|------|--------|-------------|----------------|-----|
| ... | ... | ... | ... | ... | ... |

### Principles
- ...

## 4. Component Stylings
### Buttons
- ...

### Cards & Containers
- ...

### Inputs & Forms
- ...

### Navigation
- ...

## 5. Layout Principles
- ...

## 6. Depth & Elevation
- ...

## 7. Do's and Don'ts
### Do
- ...

### Don't
- ...

## 8. Responsive Behavior
- ...

## 9. Agent Prompt Guide
### Quick Color Reference
- ...

### Example Component Prompts
1. ...
2. ...
3. ...
```

---

## 七、什么时候读这个文件

在这些场景应优先读取本文件：

- 用户要求“参考某个品牌/竞品气质”
- 你需要把 PRD 转成更有画面感的设计系统
- 你发现自己写出来的规范过于工程化、缺少审美锚点
- 你需要给未来 agent 留下可直接消费的视觉语言文档

如果你发现方案已经开始滑向默认 AI 风格，再继续读 [Anti-Generic Heuristics](anti-generic-heuristics.md)。
