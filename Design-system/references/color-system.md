# 颜色系统完整指南 (Color System Guide)

## 一、创建调色板的场景

### 1. 成熟品牌
- 已有品牌视觉识别手册 → 从手册获取主色和辅助色的 RGB/HEX 值
- 当品牌色在数字产品中显示效果不理想时，需与品牌部门沟通进行微调
- 保持主色光感的同时优化屏幕显示效果

### 2. 初创公司
- 无品牌手册时，UI设计师需自主寻找和检验颜色方案
- 结合品牌核心价值选择颜色（如有机食品→草绿色，金融→蓝色）
- 建立完整颜色体系

---

## 二、颜色系统的四类颜色

### 1. 主色 (Primary Color)
- **数量**: 通常只有1个主色，90%情况下取自品牌 Logo
- **应用场景**: 主按钮、高亮元素、装饰性文字、插画、品牌关键视觉
- **选色原则**:
  - 基于品牌核心价值（航空→蓝色=安全可靠，服装→黑色=避免干扰产品照片）
  - 选择色板右上方区域（高饱和度+高明度）
  - 高饱和度颜色在UI中更突出，页面整体更有活力

#### 创建同色系色板 (Tonal Palette)
- **方法**: 从主色出发，通过调整明度和饱和度生成 **10个色阶**
- **命名规范**: `ColorName/10` ~ `ColorName/100`（如 Purple/50）
  - 主色较深→定义为60，较浅→定义为40
  - 扩展命名：50-900 的百位数体系
- **生成工具**: 在线色阶生成器（输入主色自动生成）或手动在调色盘中等距取点
- **用途**: 按钮点击状态、禁用状态、悬停状态、背景色等

### 2. 辅助色 (Secondary Color)
- **功能**: 强调特定UI元素（促销标签、数据图表、插画），非装饰用途
- **原则**: 谨慎控制用量，避免干扰主色和品牌形象
- **创建时机**: 根据实际设计需求逐步创建

### 3. 中性色 (Neutral Color)
- **构成**: 以灰色为基础的一系列色阶（通常10阶 + 纯白/纯黑，共12阶）
- **应用范围**: 文本颜色、背景色、描边、分割线（占UI最大使用面积）
- **优化技巧**: 添加少量蓝色使灰色更清澈高级（如 #818385 带蓝调的灰）

### 4. 语义颜色 (Semantic Color)
- **标准四色**:
  | 颜色 | 语义 | 用途 |
  |------|------|------|
  | 红色 | Error 错误 | 表单验证失败、删除操作、系统错误 |
  | 黄色 | Warning 警告 | 提醒注意、风险提示 |
  | 绿色 | Success 成功 | 操作完成、验证通过 |
  | 蓝色 | Info 信息 | 普通提示、帮助信息 |
- **禁忌**: 不得随意更改颜色语义（如紫色表示警告或橙色表示成功）
- 每个语义色也需创建色阶

---

## 三、颜色对比度 (Color Contrast)

### WCAG 标准

| 级别 | 普通文字 (≤17px) | 大号文字 (≥18px 或 ≥14px bold) |
|------|----------------|---------------------------|
| AA (一般软件) | 4.5:1 | 3:1 |
| AAA (政府/高校) | 7:1 | 4.5:1 |

- **测试工具**: WebAIM Contrast Checker、W3C 官方工具
- **注意**: 对比度并非越高越好，纯黑文字+纯白背景（21:1）反而降低易读性
- **推荐**: 正文使用 Grey 70-80（而非纯黑），背景使用 Grey 10-20（而非纯白）

---

## 四、代码中的颜色系统组织

### 1. 使用 Token 而非散落样式值
- Token 是颜色系统的核心载体
- 建立设计系统时优先沉淀为 CSS Variables、JSON Token 或主题对象

### 2. 颜色命名（三级命名法）
| 层级 | 内容 | 示例 |
|------|------|------|
| 第一级 | Token 类别 | color |
| 第二级 | 颜色名称 | Purple / Orange / Grey |
| 第三级 | 色阶 | 10 ~ 100 |

完整示例: `color.purple.50` 或 `--color-purple-50`

### 3. 分层架构

#### Primitive Tokens（基础指令）
- 直接指向颜色值
- 命名: `color.purple.50` → 值: `#8A4CF7`
- 放在 primitives 分组中
- **不建议直接在业务样式中引用**，避免语义缺失

#### Semantic Tokens（语义指令）
- 以功能命名，指向 Primitive Token
- 命名规范: `位置 + 样式/状态`
- 示例:

| Semantic Token | 指向 | 用途 |
|---------------|------|------|
| color.surface.brand | color.purple.50 | 品牌色背景 |
| color.surface.brand-pressed | color.purple.70 | 品牌色按下状态 |
| color.surface.default | color.white | 默认背景 |
| color.surface.light | color.grey.10 | 浅色背景 |
| color.surface.dark | color.grey.90 | 深色背景 |
| color.text.primary | color.grey.80 | 主要文本 |
| color.text.secondary | color.grey.60 | 次要文本 |
| color.text.brand | color.purple.50 | 品牌色文本 |
| color.border.primary | color.grey.30 | 主要描边 |
| color.border.soft | color.grey.20 | 轻描边 |
| color.icon.default | color.grey.70 | 默认图标色 |
| color.icon.brand | color.purple.50 | 品牌色图标 |

#### Component Tokens（组件指令，可选）
- 更精确但工作量更大
- 示例: `button-primary-bg` → 指向 `surface-brand`

### 4. 暗色模式 (Dark Mode)

#### 色阶对应规则
- 亮色 50 → 暗色 60（通常对应关系）
- 需根据实际视觉效果调整

#### 代码实现
- 在语义 token 中分别定义 Light / Dark 值
- 为每个 semantic token 设置暗色模式的映射
- 通过 `data-theme`、class 或主题对象切换页面模式
- 保证组件默认读取当前主题下的语义 token

### 5. Token 使用范围控制 (Scoping)
- surface token → 仅用于背景和容器表面
- border token → 仅用于描边和分割线
- text token → 仅用于文本
- icon token → 仅用于图标和符号类元素

---

## 五、背景色层级体系 (Background Hierarchy)

Apple HIG 和 Material Design 均采用分层背景色体系，用于在信息层级中建立视觉深度：

| 层级 | 用途 | Light Mode | Dark Mode |
|------|------|-----------|----------|
| Primary (bg-primary) | 基底背景 | 纯白 `#FFFFFF` | 纯黑 `#000000` |
| Secondary (bg-secondary) | 次级分组/分区 | `#F2F2F7` | `#1C1C1E` |
| Tertiary (bg-tertiary) | 嵌套内容 | `#E5E5EA` | `#2C2C2E` |

**设计原则**：
- 至少定义 3 级背景色层次
- 嵌套容器逐级使用更深层级的背景色
- Light 和 Dark 模式的层级方向相反（Light 从白到灰，Dark 从黑到深灰）

---

## 六、材质与透明度 Token (Material & Transparency)

Apple 2025 年推出 Liquid Glass 设计语言，将材质属性引入设计系统，成为颜色/字体/间距之外的第四维度。

### 材质 Token 定义

| Token | 值 | 用途 |
|-------|-----|------|
| material-blur-sm | 8px | 轻微模糊（提示框） |
| material-blur-md | 16px | 标准模糊（导航栏） |
| material-blur-lg | 24px | 重度模糊（遮罩层） |
| material-opacity-chrome | 0.92 (Light) / 0.88 (Dark) | 导航栏/工具栏半透明 |
| material-opacity-overlay | 0.6 | 遮罩层 |
| material-opacity-glass | 0.75 | 玻璃效果容器 |

### CSS 实现示例
```css
.surface-glass {
  background: rgba(var(--color-bg-primary-rgb), var(--material-opacity-glass));
  backdrop-filter: blur(var(--material-blur-md));
  -webkit-backdrop-filter: blur(var(--material-blur-md));
}
```

### 何时使用材质 Token
- 导航栏、Tab Bar 等需要半透明模糊效果的固定元素
- 模态遮罩层 (overlay)
- 悬浮卡片或浮层需要与背景产生视觉关联时
- **不要**对所有元素使用——材质效果应用于层级分隔，非装饰

---

## 七、业界参考

### Apple Human Interface Guidelines (2024-2025)
- 动态系统色（systemRed, systemBlue 等）自动适配 Light/Dark
- 语义色（Label, secondaryLabel, systemBackground 等）
- 三级背景色层级（systemBackground → secondary → tertiary）
- 支持 Increased Contrast 模式
- Liquid Glass 材质系统：折射、反射、环境自适应颜色
- 透明度是颜色体系的重要组成部分（separator 用 20-30% opacity）
- Dark Mode 不是 Light Mode 的简单反色——需独立定义

### Material Design 3
- Key Colors: Primary, Secondary, Tertiary, Neutral, Error
- 每个 Key Color 生成 13 步色调色板（0-100）
- 三层 Token: Reference → System → Component
- Dynamic Color 从壁纸自动生成配色

### IBM Carbon
- 四个主题: White, g10, g90, g100
- 分层颜色架构: layer-01/02/03 用于堆叠上下文
- 支持 inline theming（同一页面不同区域不同主题）

### Ant Design
- 算法生成色板: 每个基础色生成 10 个色阶（第6阶为标准色）
- 三层 Token: Seed → Map → Alias → Component
- `ConfigProvider` + `theme.darkAlgorithm` 切换暗色模式
