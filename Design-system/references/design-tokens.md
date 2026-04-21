# Design Token 管理指南 (Design Tokens Guide)

## 一、Token 概念

### 1. 定义
- **Design Token** = 小的、可重复使用的设计决策
- 是设计师和开发人员的**共同语言**
- Token 是独立存在的指令，与具体设计工具无关

### 2. Token 可以包含
- 一个属性值 (如颜色: `#8A4CF7`)
- 多个属性值 (如字体样式: fontFamily + fontSize + lineHeight + fontWeight)

---

## 二、三层 Token 架构 (Three-Tier Architecture)

这是 **Apple、Material Design 3、Carbon、Ant Design、W3C 规范** 共同采用的标准架构:

### 第一层: Primitive Tokens (基础指令)
- 直接指向原始值，用描述性名称
- 不表达任何使用意图
- 示例:

| Token | 值 |
|-------|-----|
| color.purple.50 | #8A4CF7 |
| color.grey.70 | #5A5A5C |
| color.red.60 | #D00032 |
| spacing.16 | 16px |
| font.size.14 | 14px |
| radius.8 | 8px |

### 第二层: Semantic Tokens (语义指令)
- 以功能/意图命名，指向 Primitive Token
- 是设计师日常使用的层级
- 支持多模式 (Light/Dark)

| Token | Light Mode 指向 | Dark Mode 指向 | 用途 |
|-------|---------------|---------------|------|
| color.surface.brand | color.purple.50 | color.purple.30 | 品牌色背景 |
| color.surface.brand-pressed | color.purple.70 | color.purple.10 | 按压状态 |
| color.surface.default | color.white | color.black | 默认背景 |
| color.text.primary | color.grey.80 | color.grey.20 | 主要文本 |
| color.text.secondary | color.grey.60 | color.grey.40 | 次要文本 |
| color.border.primary | color.grey.30 | color.grey.70 | 主要描边 |
| color.icon.default | color.grey.70 | color.grey.30 | 默认图标 |
| color.icon.critical | color.red.60 | color.red.40 | 错误图标 |
| color.icon.success | color.green.60 | color.green.40 | 成功图标 |

### 第三层: Component Tokens (组件指令，可选)
- 指向 Semantic Token
- 增加精确度但也增加工作量
- 适合大型团队/复杂产品

| Token | 指向 |
|-------|------|
| button.primary.bg | color.surface.brand |
| button.primary.text | color.text.inverse |
| heading.primary.color | color.text.primary |
| heading.secondary.color | color.text.secondary |
| body.default.color | color.text.primary |
| divider.default.color | color.border.soft |

---

## 三、Token 命名规范

### 1. 层级结构
```
[name] . [category] . [property] . [modifier]
 名称      类别         属性        修饰词
```

| 层级 | 说明 | 示例 |
|------|------|------|
| name | 设计系统名称（多产品时使用） | `atlas` |
| category | 基础属性类别 | color, font, spacing, radius, shadow |
| property | 使用方式或位置 | surface, text, border, icon |
| modifier | 状态、级别、尺寸 | primary, secondary, brand, default, hover, sm |

### 2. 格式规范
- 层级间用 **点(.)、横线(-)、下划线(_) 或斜线(/)** 分隔
- **全部小写**
- 示例: `color.text.primary`, `spacing.component.padding-md`

### 3. 常见命名映射
| CSS Variable / Token Key | Token 名称 |
|-------------|-----------|
| `--color-purple-10` | color.purple.10 |
| `--color-surface-brand` | color.surface.brand |
| `--spacing-16` | spacing.16 |

代码中可用点号、短横线或斜线来表达层级，但同一项目内必须统一

### 4. 常见分类 (Categories)

| Category | 内容 |
|----------|------|
| color | 颜色 (surface, text, border, icon, feedback) |
| font | 字体 (family, size, line-height, weight) |
| spacing | 间距 (padding, gap, margin) |
| radius | 圆角 |
| shadow | 阴影/高度 |
| opacity | 透明度 |
| material | 材质 (blur, glass-opacity, backdrop) — ref: Apple Liquid Glass |
| motion | 动画 (duration, easing) |
| z-index | 层级 |
| breakpoint | 断点 |

---

## 四、代码中的实现

### 0. 单一真源原则 (Single Source of Truth)

在实际项目里，token 最大的失败模式之一不是“值不够”，而是“同一个 token 文件里被拼进两套定义”。

必须遵守三条硬规则：

- **One file, one token contract**
- **One semantic token, one meaning**
- **Update by merge-and-rewrite, never append**

这意味着：

- 同一份 `colors.css` 里不能同时存在两套 semantic color 体系
- 同一个 `color.text.primary` 不能在文件前后被定义成两个不同含义
- 迭代时必须先收敛已有定义，再重写最终结果，不能靠“后定义覆盖前定义”维持表面可用

### 0.1 Canonical Token Map

在落任何具体文件之前，先建立一份 **canonical token map**：

- 它是当前项目唯一认可的 token 真源
- CSS / JSON / theme object / 文档都从它派生
- 发现重复定义时，先更新 canonical map，再回写到各文件

推荐流程：

1. 扫描现有 token 文件
2. 标记重复项、别名、并行命名
3. 选定最终命名和最终值
4. 生成 canonical token map
5. 用 canonical token map 重写 `colors.css` / `typography.css` / `spacing.css` / `design-tokens.json`

不要这样做：

- 在文件底部再追加一套 token
- 先保留旧块，再加一块“new tokens”
- 让 JSON 和 CSS 各自维护不同命名
- 让 semantic token 在不同文件里指向不同 primitive

### 1. Token 分组

| Collection | 内容 | 发布设置 |
|-----------|------|---------|
| Primitives | 基础颜色变量 | 仅基础层引用 |
| Semantic | 语义颜色变量 (含 Light/Dark 两个 mode) | 面向业务使用 |
| Typography | 字号、行高 token (含 Mobile/Desktop mode) | 面向业务使用 |
| Spacing | 间距 token | 面向业务使用 |
| Radius | 圆角 token | 面向业务使用 |

补充约束：

- 同一 collection 内不允许出现两套并行命名系统
- 如果发现旧命名和新命名并存，应先做归并，再发布
- `design-tokens.json` 与 CSS token 文件必须可互相映射，不能各自漂移

### 2. 模式 (Modes)
- **颜色**: Light / Dark
- **字体**: Mobile / Desktop
- 一个 token 在不同 mode 下有不同值
- 使用 `data-theme`、class、主题对象或构建时配置切换模式
- 组件默认读取当前环境下的 token 值

### 3. Token 显示范围 (Scoping)
控制 token 在代码和文档中只用于相关语义范围:

| Token 类型 | 显示范围 |
|-----------|---------|
| surface | 背景、容器表面 |
| border | 描边、分割线 |
| text | 文本颜色 |
| icon | 图标颜色 |
| spacing | padding、gap、margin |
| radius | border-radius |

### 4. 跨平台命名
- 在 `design-tokens.json`、文档或转换脚本中记录 token 在各平台的名称
- 开发人员直接从仓库中的 token 文件和文档读取对应代码

| Token | Web (CSS) | iOS (Swift) | Android |
|-------|-----------|-------------|---------|
| color.surface.brand | `--color-surface-brand` | `Color.surfaceBrand` | `R.color.surface_brand` |

---

## 五、Token 文档化

### 1. 记录方式
- **Excel 表格**: 适合内部记录 (Token名, 值, 平台代码, 说明)
- **设计系统网站**: 建立专门页面展示所有 token
  - 提供 token 描述
  - 亮色/暗色值
  - 各平台代码

### 2. Token 文档应包含
| 字段 | 说明 |
|------|------|
| Token Name | 全名 (如 color.surface.brand) |
| Description | 用途描述 |
| Value (Light) | 亮色模式值 |
| Value (Dark) | 暗色模式值 |
| CSS Variable | Web 平台变量名 |
| iOS Property | iOS 属性名 |
| Android Resource | Android 资源名 |
| Category | 分类 |

---

## 六、W3C Design Token 规范参考

### JSON 格式
```json
{
  "color": {
    "surface": {
      "brand": {
        "$value": "#8A4CF7",
        "$type": "color",
        "$description": "Primary brand surface color"
      }
    }
  }
}
```

### 支持的 Token 类型
color, dimension, fontFamily, fontWeight, duration, cubicBezier, number, strokeStyle, border, transition, shadow, gradient, typography (composite)

### 引用语法
```json
{
  "button-bg": {
    "$value": "{color.surface.brand}",
    "$type": "color"
  }
}
```

---

## 七、Token 工具生态

| 工具 | 用途 |
|------|------|
| **Style Dictionary** (Amazon) | Token 转换为多平台格式 (CSS, SCSS, iOS, Android) |
| **自定义脚本** | 从 `design-tokens.json` 生成项目需要的格式 |
| **Storybook / 文档站** | 展示 token、组件和使用规范 |

---

## 八、建议补充的 Token 输出结构

上面的内容解释了 token 是什么、如何分层、如何命名，但在设计系统生成过程中，还需要更明确的“最终应该产出哪些 token”。如果只写原则，不写输出契约，生成结果容易只停留在颜色、字号和间距，遗漏真正影响界面一致性的层。

同时，输出契约除了“该有哪些 token”，还必须包含“如何避免重复拼接”。

### 0. 输出前的收敛检查

在真正生成 token 文件前，先检查：

- 是否已有同名 semantic token 的重复定义
- 是否已有旧命名和新命名并存
- 是否 `colors.css` 与 `design-tokens.json` 不一致
- 是否 theme 文件与基础 token 文件映射漂移

如果存在任一情况，先执行 **merge-and-rewrite**，不要直接生成新块。

下面这组结构可作为默认输出基线。

### 1. Color Ramps 不只要主色，还要完整梯度

建议至少产出三类 primitive ramp：

| 类别 | 建议梯度 | 用途 |
|------|---------|------|
| Neutral | 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950 | 背景、文字、描边、层级 |
| Brand | 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950 | 主品牌色、弱强调、强强调 |
| Status | 50 / 500 / 900 | success, warning, error 的背景 tint、前景和深色模式映射 |

建议明确要求 neutral / brand / status 各自产出什么粒度，这样生成结果会更稳定。

### 2. Typography Token 不应只是一组字号

除了 `font-family / size / line-height / weight`，建议显式要求：

| 维度 | 说明 |
|------|------|
| Display / Body / Mono 三角色 | 区分标题、正文、技术信息 |
| Letter spacing | 特别是 display / label / caption |
| Mono usage policy | 明确 mono 是否用于 code、是否用于 metrics |

推荐补充两个布尔规则：

- `mono_for_code`: mono 是否用于代码、路径、命令、技术标识
- `mono_for_metrics`: mono 是否用于价格、数字、时间、百分比、计数

这两个规则很小，但会直接影响产品气质，建议显式写入规范。

### 3. Semantic Color 建议固定成一套最小契约

建议要求每个 mode 至少产出这些 token：

| 层级 | 建议 token |
|------|-----------|
| Background | `background` |
| Surface | `surface1`, `surface2`, `surface3` |
| Border | `border`, `border-visible` |
| Text | `text1`, `text2`, `text3`, `text4` |
| Accent | `accent`, `accent-subtle` |
| Status | `success`, `warning`, `error` |
| Status BG | `success-bg`, `warning-bg`, `error-bg` |

其中最值得补的是：

- `surface1/2/3`
- `border-visible`
- `text4`
- `accent-subtle`
- `success-bg / warning-bg / error-bg`

这些层常常被遗漏，但它们对界面一致性非常关键。

### 4. Radius 不要只列数值，要列语义层

建议同时保留：

- Primitive radii：如 `2 / 4 / 8 / 12 / 16 / 999`
- Semantic radii：如 `element / control / component / container / pill`

这样在组件层可以直接说“按钮用 `radius-control`，卡片用 `radius-component`”，而不是每次回填具体像素。

### 5. Shadow / Elevation 应作为独立 token 层

当前文档在 category 表里提到了 `shadow`，但没有规定最小输出结构。建议要求：

| Level | 用途 |
|------|------|
| Elevation 0 | 扁平元素 |
| Elevation 1 | 标准卡片、容器 |
| Elevation 2 | 浮层、菜单、较高卡片 |
| Elevation 3 | Modal / Dialog / Sheet |

并且 light / dark 分别定义，不要只给一套阴影。

### 6. Motion Token 需要从“有无”变成“合同”

建议最少产出：

| 维度 | 建议 token |
|------|-----------|
| Duration | `instant`, `fast`, `normal`, `slow` |
| Easing | `default`, `emphasis`, `exit` |
| Interaction buckets | `micro`, `standard`, `emphasis` |

如果只写“支持动画”，生成结果很容易最后只输出一句原则，而不是实际可用 token。

### 7. Iconography 也值得列入 token / spec 范围

即使不做品牌分析，也建议至少要求：

| 维度 | 内容 |
|------|------|
| Icon size tokens | inline / button / nav |
| Stroke or fill style | outline / solid |
| Color rule | 默认跟随 text、accent 或 semantic color |

这一层可以不进入 `design-tokens.json` 的核心类型里，但应进入设计系统文档和预览约束。

### 8. 推荐的最小 Token 产物清单

生成结果建议至少覆盖：

1. Primitive color ramps
2. Semantic color tokens for light / dark
3. Typography roles + type scale + mono usage policy
4. Spacing scale
5. Radii primitive + semantic mapping
6. Elevation / shadow levels
7. Motion durations + easing
8. Icon size / color rules

如果缺少 5-8，系统依然能工作，但会停留在“基础 token 整理”阶段，而不是“完整设计语言”。
