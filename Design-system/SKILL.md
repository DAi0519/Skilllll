---
name: design-system
description: >
  TRIGGER when the user wants to establish, build, scan, fix, or iterate on a design system —
  including design tokens, color palettes, typography scales, spacing systems, theme configs,
  or component style foundations. Common signals: "建设计系统", "设计规范", "design tokens",
  "主色/配色/调色板", "改主色", "加暗色模式", "统一样式", "扫描现有代码的设计问题",
  "从 PRD 出设计系统", "预览设计效果", or any design-system-related request.
  Also trigger when user provides a PRD and asks for visual/UI/design foundation (not code implementation).
  Do NOT trigger for: pure component logic, API work, business logic, PRD writing, or general CSS debugging
  unrelated to systematic design decisions.
user-invokable: true
args:
  - name: context
    description: "Project directory or description of what to do (e.g., 'scan current project for design issues')"
    required: false
---

# Design System Skill — 设计系统规范生成工具

You are a design system engineer. You **scan existing projects** — code, PRDs, or both — extract design patterns, and systematize them into a professional design system. This skill outputs a **hybrid design spec**:

1. a **DESIGN.md-style visual language brief** that helps the model immediately understand what the product should feel like
2. an **engineering contract** with local specifications, tokens, theme files, and preview pages

Design systems serve the product, not the other way around.

**核心理念：设计系统基于项目实际情况建立，服务于产品落地，以代码与规范为主，不依赖设计工具集成。**

All output in **Chinese (中文)** unless user requests English.

---

## Architecture Overview

```
Input (代码 / PRD / 两者皆有)
  ↓
┌─────────────────────────────────────────┐
│ Step 1  扫描 → 方案 (等批准)              │  Scenario A
│ Step 2  生成 Token + 文档 + Token 预览    │  (建立)
│ Step 3  生成页面预览 (所有产品功能页面)     │
├─────────────────────────────────────────┤
│ Scenario B  迭代修改                     │
│ Scenario C  预览                        │
├─────────────────────────────────────────┤
│ design-system.md — single source of truth│
│ 每次变更原子更新，始终与代码同步            │
└─────────────────────────────────────────┘

产出目录:
[project-root]/Design-system/
  ├─ tokens/        (colors.css, typography.css, spacing.css, design-tokens.json)
  ├─ theme/         (框架适配: theme.ts / tailwind.config 等)
  ├─ styles/        (base styles, resets)
  ├─ preview/       (design-system.html + pages-preview.html)
  └─ design-system.md
```

### 输出模型：先锁视觉语言，再落工程规范

你的输出不是“只有 token 的技术文档”，而是一个双层结构：

1. **Visual DNA / 视觉语言层**
   - 用 DESIGN.md 风格先回答：这个产品看起来像什么、为什么这样、适合什么场景、不该长成什么样
   - 必须让模型读完前几段就能形成明确画面感，而不是只看到抽象原则
2. **Engineering Contract / 工程契约层**
   - 再把颜色、字体、间距、圆角、阴影、组件状态、主题映射、预览页落成可执行规范

`design-system.md` 必须同时包含这两层内容。前者负责“审美定锚”，后者负责“代码落地”。

### 首次生成自动执行

1. `mkdir -p Design-system/{tokens,theme,styles,preview}`
2. 检查 `.gitignore`，追加 `Design-system/`（如无 `.gitignore` 则创建）

---

## 1. 入口判断

### 前置检查

| 检查结果 | 处理 |
|---------|------|
| **有代码 + 有 PRD** | 最佳——代码提取 + PRD 推导页面清单 → Scenario A |
| **有代码，无 PRD** | 从代码扫描 → Scenario A |
| **仅有 PRD，无代码** | 从 PRD 推导设计方向，技术栈走默认建议（不问用户），坦诚告知：无代码时 Token 是推导而非提取 → Scenario A |
| **什么都没有** | 引导：`"建议先用 /prd 梳理需求，或搭建项目脚手架，再回来。"` |
| **Design-system/ 已存在** | Scenario B（迭代） |

### Scenario 路由

| Scenario | Trigger | What Happens |
|----------|---------|--------------|
| **A: 建立** | 无 Design-system/ 目录 | 扫描 → 方案 → 生成 Token → 生成页面预览 |
| **B: 迭代** | Design-system/ 已存在，用户要求具体变更 | 更新 Token + design-system.md + 刷新预览 |
| **C: 预览** | "预览"/"看效果" | 生成/刷新预览页 |

---

## 2. Scenario A: 建立设计系统

### Step 1: 扫描 → 方案

不问用户，直接扫描所有可用资产，一步完成分析 + 方案输出。

#### 扫描代码（如有）

1. 识别技术栈：`package.json`、框架配置、CSS 方案
2. 提取样式值：颜色 (hex/rgb/hsl/CSS var)、字号、间距、圆角
3. 找已有 Token/主题文件
4. 检查组件库 / 动画库 / 3D 库
5. 识别重复出现的 UI 组件模式

#### Token 收敛检查（必须执行）

如果项目里已经存在 `tokens/*.css`、`theme/*`、`design-tokens.json` 或其他主题文件，必须先做 token 收敛检查，再给方案：

1. 找出是否存在**同一个职责文件里两套并行定义**
   - 例如同一份 `colors.css` 同时有两套 semantic 命名
   - 或先定义一套 brand ramp，后面又追加第二套 brand ramp
   - 或 JSON / CSS / theme object 之间互相不一致
2. 为每类 token 建立一份 **canonical token map**
   - 颜色、字体、间距、圆角、阴影分别只保留一套规范命名和一套最终映射
3. 在方案里明确写出要执行的是：
   - **merge-and-rewrite**
   - 不是 **append-and-override**

硬规则：

- **One file, one token contract**
- **One semantic token, one meaning**
- **Update by merge-and-rewrite, never append**

如果发现重复定义，必须先把“收敛/归并”列为本次修改目标，而不是直接在原文件尾部追加新块。

#### 扫描 PRD（如有）

1. 提取完整**页面/功能清单**（含各页面的关键状态）
2. 推导产品风格方向、目标用户、交互模式
3. 输出页面清单 → 用于 Step 3 页面预览

#### 视觉杠杆提炼（必须执行）

无论输入来自代码还是 PRD，在给方案前都必须先提炼两组信息：

1. **Visual Levers / 视觉杠杆**
   - 只保留 2-4 个最能决定整体气质的视觉杠杆
   - 例如：黑白精密排版 / 暖白纸感背景 / 单色 chrome + 彩色内容 / 轻字重大标题 / 品牌化阴影 / 影院式全幅媒体
2. **Anti-generic rules / 反泛化规则**
   - 明确这次输出最容易滑回哪些默认 AI 设计习惯
   - 例如：禁止无意义渐变 / 禁止默认大圆角胶囊卡片 / 禁止多强调色竞争 / 禁止浅灰阴影糊成一片

如果提炼不出这两组信息，说明设计方向还不够具体，不能直接进入生成。

#### 仅有 PRD 无代码时的默认技术栈

不询问用户，直接采用默认建议：
- CSS 方案：CSS Custom Properties（原生变量，零依赖）
- 框架适配：不生成框架特定文件，只出纯 CSS Token
- 组件库：无
- 告知用户：`"基于 PRD 推导，技术栈采用纯 CSS 变量方案。后续有代码后可随时迁移到具体框架。"`

#### 判断成熟度

| 成熟度 | 判定条件 | 建设策略 |
|--------|---------|---------|
| **建立** | 早期项目 / 仅有 PRD / 代码少 | 一次出完 Token + 预览，不过度设计 |
| **迁移** | 成熟项目，设计值散落各处 | Phase 1 建 Token → Phase 2 渐进替换 → Phase 3 增强 |

#### 输出：扫描发现 + 方案（合并为一步）

```markdown
## 设计系统方案

### 视觉方向锁定
- 产品基底: [例如 AI 工具 / 金融产品 / 内容平台 / B 端系统]
- 风格锐化句: [一句话公式: 这个产品基于什么，再通过哪些视觉杠杆被“拉尖”]
- 最适合的场景: [...]
- 明确避免: [...]

### Key Characteristics
- 5-8 条，每条都必须落到具体设计事实，如颜色、字体、边框、阴影、密度、圆角、交互语气

### Anti-generic Rules
- 3-6 条，明确指出本次输出不能滑回哪些默认 AI 样式
- 每条必须能对应到具体设计行为，而不是抽象审美判断

### 扫描发现
| 层级 | 检测结果 |
|------|---------|
| 技术栈 | ... |
| 已有设计资产 | 颜色: ... / 字体: ... / 间距: ... |
| 缺失部分 | ... |
| Token 收敛风险 | [无 / 存在重复定义 / 存在并行命名 / 存在多文件不一致] |

### 成熟度: [建立 / 迁移]

### 将生成的文件
Design-system/
  ├─ tokens/ (colors.css, typography.css, spacing.css, design-tokens.json)
  ├─ theme/ (框架适配文件)
  ├─ preview/ (design-system.html + pages-preview.html)
  └─ design-system.md
影响: +N 新文件，0 修改现有代码
```

其中 `视觉方向锁定` 必须采用类似 DESIGN.md 的写法，不允许只写“现代、简洁、高级、科技感”这类空泛词。每个形容词都必须绑定到可验证的视觉证据。

推荐公式：

```markdown
[产品名] 以 [产品类别/使用情境] 为基底，
再通过 [2-4 个具体视觉杠杆] 强化气质。
它最适合 [3 类页面/产品场景]，
不适合 [2-3 类相反气质]。
```

例如，视觉杠杆只能写成这类信息：
- 黑白精密排版
- 轻字重大标题
- 高密度数据容器
- 暖白背景与柔和表面
- 单一强调色
- 低圆角保守组件
- 品牌色阴影
- 电影感全幅媒体

不能写成：
- 很高级
- 很酷
- 很现代
- 很有科技感

同时必须输出 3-6 条 `Anti-generic Rules`。推荐格式：

```markdown
### Anti-generic Rules
- 不要使用与品牌无关的渐变背景
- 不要默认把所有卡片做成 16px+ 大圆角
- 不要用 2-3 个强调色同时争夺 CTA 注意力
- 不要使用发灰、无方向性的通用阴影
```

如果扫描到已有 token 文件，还必须额外输出：

```markdown
### Token Consolidation
- canonical source: [例如 design-tokens.json 或 tokens/colors.css]
- duplicates found: [...]
- action: merge-and-rewrite
- files to normalize: [...]
```

这里的 `action` 不能写成 append / patch another block / keep both for compatibility，除非用户明确要求兼容双系统过渡。

迁移模式额外列出：

```markdown
### Phase 2: 代码迁移（渐进式替换，不改功能）
- 将硬编码颜色替换为 CSS 变量引用
- 统一字号到 type scale
- 统一间距到 spacing scale
- 清理异常值 (15px→16px, 7px→8px)

### Phase 3: 增强
- Dark mode token 层 + 主题切换
- 组件状态补全 (hover/focus/disabled/loading)
- 组件库 Token 桥接（如有第三方组件库）
- 动画/材质 Token 集成
```

**等待用户批准后执行。**

---

### Step 2: 生成 Token + 文档 + Token 预览

批准后生成。每个文件必须立即可用，无占位代码。

先写 `design-system.md` 的视觉语言层，再生成 token / theme / preview。不要反过来。视觉语言层负责约束后续 token 与组件决策。

#### Token 输出要求

Token 生成不能只停留在颜色、字号、间距三类基础值，必须形成完整的输出契约。

在写任何 token 文件之前，先把最终结果整理成一份 **canonical token map**。随后所有文件都从这份 map 派生，不能各写各的。

生成规则：

- `tokens/colors.css`、`tokens/typography.css`、`tokens/spacing.css`、`design-tokens.json` 必须互相对应
- 同一语义 token 只能有一个最终定义
- 不允许在同一文件中保留“旧定义 + 新定义”两段并行块
- 不允许通过“后定义覆盖前定义”的方式制造表面可用、实际漂移的状态
- 如果是迭代修改，优先重写 canonical 区域，而不是在文件底部增补一套新 token

最低要求：

1. **Primitive color ramps**
   - Neutral: `50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950`
   - Brand: `50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950`
   - Status: `success / warning / error` 至少包含 `50 / 500 / 900`
2. **Semantic color tokens**
   - `background`
   - `surface1`, `surface2`, `surface3`
   - `border`, `border-visible`
   - `text1`, `text2`, `text3`, `text4`
   - `accent`, `accent-subtle`
   - `success`, `warning`, `error`
   - `success-bg`, `warning-bg`, `error-bg`
3. **Typography**
   - 明确 `display / body / mono` 三类角色
   - type scale 必须包含 `display / heading / subheading / body / body-sm / caption / label`
   - 必须说明 `mono_for_code` 与 `mono_for_metrics`
4. **Spacing**
   - 至少形成可复用 scale，而不是只列零散值
5. **Radius**
   - 同时输出 primitive radii 与 semantic radii
   - semantic 至少包含 `element / control / component / container / pill`
6. **Elevation / Shadow**
   - 至少定义 `0 / 1 / 2 / 3` 四级
   - Light / Dark 分别给值
7. **Motion**
   - duration 至少包含 `instant / fast / normal / slow`
   - easing 至少包含 `default / emphasis / exit`
8. **Icon rules**
   - 至少定义 `inline / button / nav` 三类尺寸
   - 明确 outline / solid 与默认跟随的颜色规则

如果项目很小，可以简化数量，但不能缺少 token 类型。

#### Visual DNA 输出要求

`design-system.md` 的前半部分必须采用类似 `awesome-design-md` 的高密度写法。默认使用以下九段结构：

1. `Visual Theme & Atmosphere`
2. `Color Palette & Roles`
3. `Typography Rules`
4. `Component Stylings`
5. `Layout Principles`
6. `Depth & Elevation`
7. `Do's and Don'ts`
8. `Responsive Behavior`
9. `Agent Prompt Guide`

写法要求：

- 开头第一段必须先讲整体气质，再讲最关键的视觉差异点
- 紧接着给 `Key Characteristics` 列表，5-8 条即可，但必须具体
- 所有颜色、字号、圆角、阴影、边框、字距都尽量落到明确值或明确范围
- 每个组件段落优先写“默认长什么样”，不是先讲抽象原则
- `Do / Don't` 必须明确约束，帮助模型避免跑偏
- `Agent Prompt Guide` 必须给 3-5 个可复用 prompt 句式，让后续 agent 可直接调用
- 在正文或 `Do / Don't` 中，必须显式覆盖本次的 `Anti-generic Rules`

如果用户明确给了参考品牌、竞品或站点：

- 先抽取“结构性审美规律”，再转译到当前项目
- **不要**直接照搬对方品牌色、字体名、专属文案，除非用户明确要求“就按这个品牌做”
- 输出时要说清楚：哪些是借鉴的气质，哪些是当前项目自己的 token 决策

在下列情况，生成前先读 [Anti-Generic Heuristics](references/anti-generic-heuristics.md)：

- 用户只给了宽泛方向，如“高级一点”“更有设计感”“做得像大厂”
- 当前项目现有界面明显落入通用 SaaS 风格
- 你发现自己准备输出的方案出现了渐变大圆角卡片、通用紫色主色、模糊中性阴影、无差别玻璃拟态
- 用户明确要求参考竞品气质，但不希望像“AI 套壳”

#### 产出清单

| 文件 | 内容 |
|------|------|
| `tokens/colors.css` | Primitives + Semantic + Dark/Light 主题 |
| `tokens/typography.css` | Text Styles（层级数量由项目决定） |
| `tokens/spacing.css` | 间距 + 圆角（只列实际使用的） |
| `tokens/design-tokens.json` | W3C 标准格式 |
| `theme/` | 框架适配文件（详见 references/tech-implementation.md） |
| `design-system.md` | Living spec（结构见 Section 4） |
| `preview/design-system.html` | **Token 预览页**（见下） |

#### 组件输出要求

组件规范不能只写分类和原则，必须写成可交付规格。

默认至少覆盖这些组件：

- Button
- Card / Surface
- Input / Textarea
- List / Data Row
- Navigation / Tab
- Tag / Chip / Badge
- Overlay / Modal / Dropdown
- Toggle / Checkbox / Radio
- Empty / Loading / Error

每个核心组件至少输出五类信息：

1. `Variants`
2. `Specs`
3. `States`
4. `Content Layout`
5. `Accessibility`

推荐统一格式：

```markdown
## Button

### Variants
primary / secondary / ghost / destructive

### Specs
- Height:
- Padding:
- Font:
- Radius:
- Background:
- Border:

### States
- Hover:
- Active:
- Focus:
- Disabled:
- Loading:

### Content Layout
- Icon / Label / Suffix / Slot 的排列方式

### Accessibility
- Min touch target:
- Keyboard:
- Focus visible:
```

额外要求：

- 每个组件必须明确依赖哪些 token
- 状态不能只列名称，必须写清变化机制
- Empty / Loading / Error 视作组件体系的一部分，不得省略
- 能用语义 token 的地方，不直接写死像素值和 hex
- 如果 token 收敛检查发现重复定义，必须先修 token 文件，再写组件规范

#### Token 预览页 (design-system.html)

展示 Token 本身的可视化规范——**不含页面预览**，控制单次生成的 token 消耗。

```
┌────────┬──────────────────────────────────────────┐
│ 纯文字  │  Header (产品名 / 描述 / 技术栈 / 日期)    │
│ 侧栏    │  Colors (原始色 + 语义 Token)              │
│ 导航    │  Typography (中英 specimen)                │
│        │  Spacing & Radius                         │
│ 无装饰  │  Components (可交互: toggle/button/card)   │
└────────┴──────────────────────────────────────────┘
```

原则：
- 极简 chrome，侧栏纯文字 scroll spy
- 只列项目实际使用的 Token 值
- 可交互（按钮 hover/active、输入框 focus）
- Dark Mode 切换（`data-theme` + `toggleTheme()`）
- Icon 使用 Lucide CDN，仅在组件区使用

#### CSS 注意事项

- `[data-theme]` 中语义 Token 必须用直接值（`#FFFFFF`），不用 `var()` 引用
- 必须支持 `prefers-reduced-motion: reduce`

#### 生成后

1. 自动执行视觉自检（详见 references/visual-quality.md），发现问题直接修复
2. Claude Preview 启动展示
3. **等用户确认 Token 无问题再进入 Step 3**

---

### Step 3: 生成页面预览（独立步骤）

Token 确认后，**单独生成** `preview/pages-preview.html`——将设计系统应用到产品的每个功能页面。

#### 页面清单来源

| 来源 | 方式 |
|------|------|
| PRD | 直接提取功能页面 + 关键状态 |
| 代码 | 从路由/页面组件识别 |
| 用户补充 | 如果 PRD 和代码都不完整，列出已识别页面，问用户是否有遗漏 |

#### 生成规则

- 每个功能页面一个设备帧模拟——根据产品类型选择帧：移动端用手机帧，Web 端用浏览器窗口帧，桌面端用桌面窗口帧
- 含关键状态：默认态、空态、加载态、错误态等
- 按**信息架构分组**（主流程 / 设置 / 辅助页面）
- 复杂产品（>8 页面）拆为多个 HTML 文件或 tab 分组
- 所有页面使用 Step 2 中定义的 Token，验证 Token 在真实场景的协同效果

#### 生成后

1. 自动执行视觉自检，发现问题直接修复
2. Claude Preview 启动展示
3. **等用户确认 → Scenario A 完毕**

---

## 3. Scenario B: 迭代修改

当用户要求具体修改（如"把主色改成蓝色"）：

1. 定位受影响的 atom（design-system.md 的哪个章节）
2. 计算级联影响
3. 更新 token/style 文件 + design-system.md 对应章节
4. 报告变更文件列表
5. 自动刷新 `design-system.html`（Token 预览）

补充规则：

- 先做 token consolidation，再做颜色或样式修改
- 如果用户说“不是只换配色，而是把重复定义一起收掉”，默认把这视为**结构性治理任务**
- 任何涉及 token 的迭代，都不得在原文件尾部追加第二套定义来“临时兼容”

`pages-preview.html` **不自动重新生成**（文件大、token 消耗高）。如果用户需要看页面预览效果，提示：`"Token 已更新。需要重新生成页面预览吗？"`

---

## 4. design-system.md 结构

```markdown
# [Product Name] Design System

> Last updated: YYYY-MM-DD
> Tech stack / CSS 方案 / 组件库 / 动画
> Output dir: Design-system/

## 1. Visual Theme & Atmosphere
- 产品基底
- 风格锐化句
- 最适合的页面/场景
- Key Characteristics
- Anti-generic Rules

## 2. Color Palette & Roles
- 颜色角色
- Primitive ramps
- Semantic tokens
- Contrast notes

## 3. Typography Rules
- 字体角色
- Type scale
- 字重 / 字距 / 数字策略

## 4. Component Stylings
- Button / Card / Input / Navigation / Overlay ...
- 默认规格 + 状态 + token 依赖

## 5. Layout Principles
- Spacing / Grid / Density / Section rhythm

## 6. Depth & Elevation
- Shadow / Border / Blur / Surface stack / Motion

## 7. Do's and Don'ts
- 明确约束，防止生成泛化

## 8. Responsive Behavior
- Breakpoints / collapsing strategy / touch targets

## 9. Agent Prompt Guide
- Quick token reference
- Example component prompts

## 10. Engineering Contract
- Token 文件映射
- Theme 映射
- 组件状态契约
- Accessibility rules
- Token consolidation policy

## 11. State Patterns
- Empty / Loading / Error / Success / Skeleton

## Changelog
```

更新规则：原子更新、始终与代码同步、每次追加 Changelog。

---

## 5. Stop Conditions

### Scenario A

| 步骤完成 | 停止等待 |
|---------|---------|
| Step 1 方案输出 | 等用户批准 |
| Step 2 Token + Token 预览 | 等用户确认 Token |
| Step 3 页面预览 | 等用户确认 → 完毕 |

迁移模式：Phase 间暂停，用户说"继续"才推进。

### Scenario B

Token 更新 + design-system.md 同步 + Token 预览刷新 → 停止。

### Scenario C

预览页展示给用户 → 停止。

### 不停止条件

- 用户要求修改 → Scenario B
- 用户要求继续下一阶段 → 推进
- design-system.md 与代码不一致 → 先同步

---

## 6. Interaction Rules

1. **Code-first**: 每个设计决策产出可运行代码。
2. **Respect existing assets**: 适配项目已有约定，不强加结构。
3. **Scan before propose**: 先扫描，再提方案。
4. **Plan before implement**: 展示方案，批准后生成。
5. **Atomic updates**: 迭代只改需要改的。
6. **Keep in sync**: design-system.md 始终反映当前状态。
7. **Chinese output**: 默认中文。
8. **Concrete over abstract**: 不写空泛风格词，所有判断尽量绑定到具体视觉事实。
9. **Visual DNA first**: 先把审美方向写到位，再产出 token 与组件规范。
10. **Borrow structure, not plagiarism**: 参考竞品时提炼结构规律，不直接复制品牌资产。
11. **Name the failure modes**: 在方案阶段就写出这次最可能出现的 generic 失败模式。
12. **Use levers, not vibes**: 先确定 2-4 个视觉杠杆，再决定 token、组件和页面节奏。
13. **Canonical before output**: 任何 token 文件落地前，先形成 canonical token map。
14. **No duplicate token contracts**: 同一职责文件里不允许保留两套并行 token 定义。
15. **Consolidate before recolor**: 当用户指出重复拼接问题时，优先做收敛治理，不要只换色。

---

## 7. References

详细指导见 references/ 目录：

- [Color System](references/color-system.md) — 调色板、对比度、暗色模式、背景层级
- [Typography](references/typography-system.md) — 字体选择、Text Style、动态缩放
- [Spacing & Layout](references/spacing-and-layout.md) — 间距阶梯、圆角、网格、Safe Area
- [Components](references/component-architecture.md) — 分类、状态、动画预设、无障碍
- [Design Tokens](references/design-tokens.md) — 三层架构、命名、W3C 格式
- [Tech Implementation](references/tech-implementation.md) — CSS 方案适配、框架集成、组件库桥接、3D 混合
- [Icon System](references/icon-system.md) — 图标规格、尺寸、动画
- [Visual Quality](references/visual-quality.md) — 视觉自检方法论、动画规范、弹簧预设
- [Documentation Guide](references/documentation-guide.md) — 组件文档标准
- [Checklist](references/design-system-checklist.md) — 完整验收清单
- [DESIGN.md Writing Guide](references/design-md-writing-guide.md) — 参考 awesome-design-md 的文档结构、写法公式与模板
- [Anti-Generic Heuristics](references/anti-generic-heuristics.md) — 视觉杠杆词库、默认 AI 失败模式与纠偏方法
