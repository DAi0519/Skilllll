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

### 1. Token 分组

| Collection | 内容 | 发布设置 |
|-----------|------|---------|
| Primitives | 基础颜色变量 | 仅基础层引用 |
| Semantic | 语义颜色变量 (含 Light/Dark 两个 mode) | 面向业务使用 |
| Typography | 字号、行高 token (含 Mobile/Desktop mode) | 面向业务使用 |
| Spacing | 间距 token | 面向业务使用 |
| Radius | 圆角 token | 面向业务使用 |

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
