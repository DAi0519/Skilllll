# UI组件架构指南 (Component Architecture Guide)

## 一、组件基础概念

### 1. 组件定义
- **Component**: 具有特定功能或能向用户提供信息的UI元素
- 常见类型: 按钮、输入框、选择器、表格、菜单、卡片、轮播图、弹窗、导航等
- **前提**: 在建立组件前需要先定义颜色、字体、间距等基础设计元素

### 2. 组件库的价值
| 维度 | 说明 |
|------|------|
| 一致性 | 通过复用组件确保产品在不同页面保持视觉和体验一致 |
| 维护性 | 记录组件使用规范，存放设计与代码，便于统一维护 |
| 效率 | 设计师直接调用组件，开发人员直接使用对应代码 |
| 协作 | 是构成设计系统的核心部分，团队效率的决定性因素 |

---

## 二、原子设计层级 (Atomic Design)

| 层级 | 名称 | 说明 | 示例 |
|------|------|------|------|
| 原子 (Atom) | 基础元素 | 不可再分的最小UI单元 | 按钮、图标、输入框、标签 |
| 分子 (Molecule) | 功能单元 | 原子组合形成的功能性单元 | 搜索框(输入框+按钮)、表单项 |
| 组织 (Organism) | 复杂模块 | 分子组合实现更复杂功能 | 页眉、页脚、侧边栏、卡片列表 |
| 模板 (Template) | 布局框架 | 组织构成页面布局 | 产品详情页模板、仪表盘模板 |
| 页面 (Page) | 最终产物 | 模板添加具体内容 | 首页、登录页、设置页 |

---

## 三、组件规范建模

### 1. 组件命名规范
- **直接命名**: 使用最直观的方式（如按钮命名为 `Button`）
- **变体命名**: `组件名称/变体属性1/变体属性2`
  - 这种命名便于在文档、代码和目录结构中统一分组
  - 示例: `Button/primary/large/default`

### 2. 创建步骤
1. 选中需要设为组件的UI元素
2. 抽象稳定的结构、状态和尺寸
3. 定义统一命名、token 依赖和交互状态
4. 在代码和文档中都把组件当作可复用模板维护

---

## 四、组件属性系统 (四种属性)

### 1. 变体属性 (Variants)
- **用途**: 管理同一组件的多个版本
- **常见属性维度**:

| 维度 | 英文 | 常见值 |
|------|------|--------|
| 样式 | Style | primary, secondary, ghost, danger, link |
| 尺寸 | Size | small, medium, large |
| 状态 | State | default, hover, pressed, focused, disabled, loading |

- **创建方法**: 用统一命名法 `Button/primary/large/default` 建模，或在组件 API 中定义对应枚举值
- **管理优势**: 将细微差别的版本合并为一个组件下的不同变体，精简组件数量

### 2. 布尔属性 (Boolean)
- **用途**: 控制组件中元素的显示/隐藏
- **创建步骤**: 添加布尔参数 → 命名 (如 `showCloseButton`) → 设置默认值
- **应用**: 通过开关控制元素显示，避免变体数量翻倍
- **批量操作**: 在文档和代码中保持默认值一致，避免行为分叉

### 3. 文本属性 (Text)
- **用途**: 频繁修改文本内容的组件
- **创建方法**: 添加文本参数 → 命名 (如 `messageBody`) → 设置默认文本
- **优势**: 直接在属性面板修改，无需多次点击选择文本
- **排序**: 参数顺序需与常见使用频率一致

### 4. 插槽/子组件属性 (Slots)
- **用途**: 替换组件中的嵌套内容（如图标、前后缀、空状态插画）
- **创建步骤**: 定义 slot 或子组件接口 → 约束可替换范围
- **注意**: 替换元素必须遵守同一套尺寸、对齐和 token 规范

---

## 五、嵌套组件 (Nested Components)

### 暴露嵌套能力 (Expose Nested)
- 在父组件层面直接调整子组件属性（而非替换）
- 在组件接口中暴露需要调整的子组件参数
- 场景: 信息组件中直接调整按钮的样式、尺寸等

---

## 六、组件设计最佳实践

### 1. 使用 Design Tokens
- 所有颜色引用 Semantic Token，不使用硬编码色值
- 所有间距使用 Spacing Token
- 所有字体使用 Typography Style/Token
- 圆角使用 Radius Token

### 2. 使用 Auto Layout
- 所有组件都应使用 Auto Layout 实现自适应
- 设置合理的 padding、gap、resize 规则
- 确保组件能够响应内容变化

### 3. 状态设计
每个交互组件必须定义以下状态:

| 状态 | 说明 | 视觉表现 |
|------|------|---------|
| Default | 默认状态 | 正常显示 |
| Hover | 鼠标悬停 | 轻微颜色变化 (8% opacity state layer) |
| Pressed/Active | 按下 | 更深颜色变化 (12% opacity) |
| Focused | 键盘焦点 | 焦点环 (12% opacity + focus ring) |
| Disabled | 禁用 | 降低透明度 (38% opacity) |
| Loading | 加载中 | 旋转图标或骨架屏 |
| Error | 错误状态 | 红色描边/文字 |

### 4. 无障碍设计
- **触控目标**: 最小 44×44pt (Apple) / 48×48dp (Material)
- **焦点指示**: 所有交互元素需有可见的焦点指示器
- **ARIA 标签**: 每个交互元素需要语义化标注
- **键盘导航**: 记录每个组件的键盘交互方式

### 5. 组件管理策略
- **灵活选择**: 根据实际需求决定将相似元素设为变体或独立组件
- **权衡因素**: 考虑团队使用习惯、查找便利性和管理效率
- **核心目标**: 通过合理使用四种属性提升管理效率
- **没有固定规则**: 选择最适合团队工作流程的方式

---

## 七、按功能分类的组件体系 (ref: Apple HIG)

Apple HIG 将组件按**功能用途**而非视觉形态分类，这种方式更有助于在设计评审中做出正确的组件选择：

| 功能类别 | 说明 | 典型组件 |
|---------|------|---------|
| **Content** | 信息展示 | Avatar, Badge, Tag, Image, Video, Divider |
| **Layout & Organization** | 布局与组织 | Card, Accordion, List, Grid, Spacer |
| **Menus & Actions** | 菜单与操作 | Button, Dropdown, ContextMenu, ActionSheet |
| **Navigation & Search** | 导航与搜索 | NavBar, Sidebar, Tab, Breadcrumb, SearchBar, Pagination |
| **Presentation** | 呈现 (弹出层) | Modal/Dialog, Drawer, Sheet, Popover, Tooltip |
| **Selection & Input** | 选择与输入 | Input, Textarea, Checkbox, Radio, Switch, Select, DatePicker, Slider |
| **Status** | 状态指示 | Alert/Message, Toast, Progress, Spinner, Skeleton |

### 原子设计层级仍然适用

按功能分类不取代原子设计，两者是互补关系：
- **原子设计**回答"这个组件有多复杂"（用于拆分和组合）
- **功能分类**回答"这个组件做什么"（用于选择和文档）

### 传统原子设计清单（保留参考）

#### 基础组件 (Atoms)
- Button (按钮)
- Input (输入框)
- Textarea (文本区域)
- Checkbox (复选框)
- Radio (单选框)
- Switch/Toggle (开关)
- Select/Dropdown (选择器)
- Badge (徽标)
- Tag (标签)
- Avatar (头像)
- Divider (分割线)
- Tooltip (提示)

#### 复合组件 (Molecules)
- Search Bar (搜索栏)
- Form Item (表单项: 标签+输入+错误提示)
- Breadcrumb (面包屑)
- Pagination (分页)
- Tab (选项卡)
- Alert/Message (提示消息)

#### 复杂组件 (Organisms)
- Navigation Bar (导航栏)
- Sidebar (侧边栏)
- Card (卡片)
- Table (表格)
- Modal/Dialog (弹窗)
- Drawer (抽屉)
- Accordion (折叠面板)
- Carousel (轮播图)
- Calendar/DatePicker (日期选择)

---

## 八、组件动画预设 (ref: Apple SF Symbols)

Apple SF Symbols 7 为图标和组件定义了一套**标准动画预设系统**，值得在通用设计系统中借鉴：

### 动画预设类型
| 预设 | 效果 | 适用场景 |
|------|------|---------|
| Appear/Disappear | 淡入/淡出 | 元素进入/离开 |
| Bounce | 弹跳 | 操作反馈（点赞、收藏） |
| Scale | 缩放 | 按钮按下 |
| Wiggle | 摇晃 | 错误提示、注意力引导 |
| Rotate | 旋转 | 加载、刷新 |
| Breathe | 呼吸 | 等待状态 |
| Pulse | 脉冲 | 通知、提醒 |
| Replace | 交叉切换 | 图标/状态转换 |

### 设计系统中的实现
```css
/* Motion tokens */
:root {
  --motion-duration-instant: 100ms;
  --motion-duration-fast: 200ms;
  --motion-duration-normal: 300ms;
  --motion-duration-slow: 500ms;
  --motion-easing-default: cubic-bezier(0.2, 0, 0, 1);
  --motion-easing-spring: cubic-bezier(0.175, 0.885, 0.32, 1.275);
  --motion-easing-exit: cubic-bezier(0.4, 0, 1, 1);
}

/* Respect user preference */
@media (prefers-reduced-motion: reduce) {
  * { animation-duration: 0.01ms !important; transition-duration: 0.01ms !important; }
}
```

### 关键原则
- 动画是组件的**一等公民**，不是附加装饰
- 每个交互组件应定义进入、离开、状态切换的动画行为
- 必须尊重 `prefers-reduced-motion` 系统设置

---

## 九、组件无障碍属性模板 (ref: Apple HIG)

每个交互组件应定义标准化的无障碍属性：

| 属性 | 说明 | 示例 (Button) |
|------|------|--------------|
| role | ARIA 角色 | `button` |
| aria-label | 可访问名称 | `"提交表单"` |
| aria-disabled | 禁用状态 | `true/false` |
| aria-busy | 加载状态 | `true/false` |
| keyboard | 键盘交互 | `Enter/Space → activate` |
| focus-visible | 焦点指示器 | `2px ring, offset 2px` |

### 非视觉信息传达
- **颜色不能是唯一的信息传达方式** — 错误状态必须同时有图标或文字提示
- **图标必须有文字替代** — 功能性图标需要 `aria-label`
- **动态内容需要通告** — 使用 `aria-live` 区域通知屏幕阅读器

---

## 十、业界参考

### Material Design 3 组件规范
- 每个组件有完整的 token 规格: container, content (label, icon), state layers
- State layer 系统: hover(8%), focus(12%), pressed(12%), dragged(16%)
- 六级高度系统: 0, 1(1dp), 2(3dp), 3(6dp), 4(8dp), 5(12dp)

### Ant Design 组件模式
- 复合组件模式: `Form.Item`, `Table.Column`
- 统一 API: size (small/middle/large), variant, disabled, loading
- ConfigProvider 主题配置

### Carbon 组件架构
- 组件状态: enabled, hover, focus, active, disabled, read-only, error, warning, skeleton
- 组件解剖: container, label, helper text, input, icon, error message

### Apple HIG 组件规范 (2024-2025)
- 组件按功能分类而非视觉形态
- 最小触控目标: iOS 44×44pt, visionOS 60×60pt
- 导航组件与操作组件严格分离（Tab Bar 仅用于导航）
- 组件需支持多种外观模式（Light/Dark/Tinted/Mono）
- 动画作为组件的一等公民
