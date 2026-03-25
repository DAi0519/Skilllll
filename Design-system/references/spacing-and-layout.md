# 间距、圆角与网格系统指南 (Spacing, Corner Radius & Grid Guide)

## 一、间距系统 (Spacing System)

### 1. 基本原则
- **基准单位**: 4px（精细间距）和 8px（标准间距）
- 所有间距值应为 4 的倍数（业界通用标准：Apple、Material Design、Carbon）
- 间距用于控制元素间的视觉关系和层次

### 2. 间距色阶 (Spacing Scale)

| Token名称 | 值 | 用途示例 |
|----------|-----|---------|
| spacing/0 | 0px | 无间距 |
| spacing/2 | 2px | 极小间距（图标与文字微调） |
| spacing/4 | 4px | 紧凑间距（标签内边距） |
| spacing/8 | 8px | 小间距（图标与文字间距） |
| spacing/12 | 12px | 中小间距（表单项间距） |
| spacing/16 | 16px | 标准间距（组件内边距） |
| spacing/20 | 20px | 中间距 |
| spacing/24 | 24px | 区块间距 |
| spacing/32 | 32px | 大间距（区块分隔） |
| spacing/40 | 40px | 较大间距 |
| spacing/48 | 48px | 大区块间距 |
| spacing/64 | 64px | 页面区域分隔 |
| spacing/80 | 80px | 大型页面区域 |
| spacing/96 | 96px | 超大间距 |

### 3. 语义间距 Token（可选，进阶）

| Semantic Token | 指向 | 用途 |
|---------------|------|------|
| spacing/component/padding-sm | spacing/8 | 小组件内边距 |
| spacing/component/padding-md | spacing/16 | 标准组件内边距 |
| spacing/component/padding-lg | spacing/24 | 大组件内边距 |
| spacing/layout/gap-sm | spacing/16 | 布局小间距 |
| spacing/layout/gap-md | spacing/24 | 布局标准间距 |
| spacing/layout/gap-lg | spacing/32 | 布局大间距 |
| spacing/layout/section | spacing/64 | 页面区域间距 |

### 4. 代码实现
- 使用统一 token 创建间距体系
- 分组命名: `spacing`
- token 命名: `spacing/4`, `spacing/8`, `spacing/16` ...
- 应用到组件的 padding、gap、margin

---

## 二、圆角系统 (Corner Radius System)

### 1. 圆角色阶

| Token名称 | 值 | 用途示例 |
|----------|-----|---------|
| radius/0 | 0px | 无圆角（直角元素） |
| radius/2 | 2px | 极小圆角（表格单元格） |
| radius/4 | 4px | 小圆角（输入框、小按钮） |
| radius/8 | 8px | 标准圆角（按钮、卡片） |
| radius/12 | 12px | 中圆角（大卡片、弹窗） |
| radius/16 | 16px | 大圆角（大型容器） |
| radius/24 | 24px | 超大圆角（特殊容器） |
| radius/full | 9999px | 全圆角（药丸按钮、头像） |

### 2. Material Design 3 形状参考
- None (0dp), Extra Small (4dp), Small (8dp), Medium (12dp)
- Large (16dp), Extra Large (28dp), Full (circular)

### 3. 代码实现
- 使用 radius token
- 命名: `radius/4`, `radius/8`, `radius/12` ...
- 应用到组件的 `border-radius`

---

## 三、网格系统 (Grid System)

### 1. 网格定义
- 通过将布局划分为行、列和部分来组织页面内容的结构框架
- 帮助排列和对齐元素，建立统一有规律的布局

### 2. 12栅格系统

#### 三个核心元素
| 元素 | 说明 |
|------|------|
| 列 (Column) | 放置和对齐UI元素，通常12列 |
| 水槽 (Gutter) | 列与列之间的距离，通常固定值 |
| 边距 (Margin) | 页面内容到窗口两边的距离，通常固定值 |

**为什么选12列**: 12可以被 2、3、4、6 整除，提供最大布局灵活性

### 3. 响应式断点系统 (Breakpoint System)

| 断点 | 窗口范围 | 列数 | 列宽 | 水槽 | 边距 | 对应设备 |
|------|---------|------|------|------|------|---------|
| XS | 320-479px | 4列 | 百分比 | 12px | 16px | 小手机 |
| S | 480-767px | 8列 | 百分比 | 12px | 16px | 大手机 |
| M | 768-1023px | 12列 | 百分比 | 12px | 24px | 平板 |
| L | 1024-1439px | 12列 | 百分比 | 16px | 32px | 小电脑屏 |
| XL | ≥1440px | 12列 | 百分比/96px固定 | 16px | 32px | 大电脑屏 |

#### 业界参考
- **Carbon**: sm(320, 4col), md(672, 8col), lg(1056, 16col), xlg(1312, 16col)
- **Material**: 手机4col, 平板8col, 桌面12col

### 4. 画框尺寸标准 (Artboard Sizes)

| 断点 | 画框尺寸 | 设备类型 |
|------|---------|---------|
| XS | 320 × 568 | 最小手机屏幕 |
| S | 480 × 853 | 大号手机屏幕 |
| M | 768 × 1024 | 平板设备 |
| L | 1024 × 768 | 电脑屏幕 |
| XL | 1440 × 1024 | 最大电脑屏幕宽度 |

### 5. 双栏布局 (Two-Column Layout)
- **常见于**: 功能型网站、B端设计
- **结构**: 左侧固定宽度导航栏 + 右侧响应式内容区域（12格）
- **设置方法**: 网格设置中将对齐方式改为靠右 (right)

### 6. 移动端说明
- APP设计中因屏幕宽度变化范围小，栅格非必需
- 但仍建议保持4列基础网格用于对齐

### 7. Safe Area 与可读性边距 (ref: Apple HIG)

**Safe Area**：
- 独立于边距的布局概念，确保内容不被系统元素遮挡（刘海、圆角、Home Indicator）
- 所有内容必须在 Safe Area 内
- 背景色/图片可延伸至 Safe Area 外

**可读性边距 (Readability Margins)**：
- 在大屏设备上自动限制文本行宽，避免过长的行导致阅读困难
- 最佳行宽：英文 45-75 字符，中文 25-40 字符
- 实现：`max-width` + 居中，或 CSS `max-inline-size`

**标准尺寸参考 (Apple HIG)**：
| 项目 | 值 |
|------|-----|
| 列表行高度 | 44pt |
| 表单内边距 | 16pt |
| 屏幕边距 (Phone) | 16pt |
| 屏幕边距 (Tablet) | 20pt |
| 最小交互尺寸 | 44×44pt |
| 空间 UI 最小交互尺寸 (visionOS) | 60×60pt |

---

## 四、代码中的网格落地

### 设置步骤
1. 选择画框尺寸
2. 根据断点设置列数和参数
3. 在 CSS 中定义容器宽度、列数和 gutter
4. 将网格规则沉淀为布局工具类或文档规范

### 命名规范
- `layout-grid-xs` (320, 4列)
- `layout-grid-s` (480, 8列)
- `layout-grid-m` (768, 12列)
- `layout-grid-l` (1024, 12列)
- `layout-grid-xl` (1440, 12列)

### 团队协作
- 所有成员直接复用统一断点和布局 token
- 确保新页面创建时使用正确的断点规范
