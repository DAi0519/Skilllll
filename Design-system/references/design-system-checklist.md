# 设计系统完整检查清单 (Design System Checklist)

## Phase 1: 策略规划 (Strategy & Planning)

- [ ] 明确团队可用时间和人力资源
- [ ] 选择搭建策略（轻量级/开源基础/企业级自定义）
- [ ] 分析/整理现有设计元素（颜色/字体/图标/组件）
- [ ] 定义 3-5 条设计原则
- [ ] 确定目标平台 (Web/iOS/Android/Cross-platform)
- [ ] 确定技术栈 (React/Vue/SwiftUI/Flutter)
- [ ] 确定规范落地载体（Markdown / HTML 预览 / 文档站）

---

## Phase 2: 颜色系统 (Color System)

### 调色板
- [ ] 确定品牌主色 (Primary Color)
- [ ] 创建主色 10 阶色板 (10-100)
- [ ] 确定辅助色 (Secondary Color/s)（如需要）
- [ ] 创建辅助色色板
- [ ] 创建中性色/灰色色板（10阶 + 纯白/纯黑 = 12阶）
- [ ] 中性色灰色添加微量蓝调（更高级感）
- [ ] 创建语义颜色色板 (Error/Warning/Success/Info)

### 对比度验证
- [ ] 所有文本颜色通过 WCAG AA 对比度检查 (4.5:1)
- [ ] 所有大号文本通过 WCAG AA 检查 (3:1)
- [ ] 所有UI元素/图标通过对比度检查 (3:1)

### 背景层级
- [ ] 定义至少 3 级背景色 (primary → secondary → tertiary)
- [ ] Light/Dark 模式下层级方向正确

### 材质 Token (可选，进阶)
- [ ] 定义模糊度 Token (blur-sm/md/lg)
- [ ] 定义半透明度 Token (chrome/overlay/glass)
- [ ] 材质 Token 适配 Dark mode

### 代码与规范落地
- [ ] 创建 Primitive tokens（基础颜色变量）
- [ ] 创建 Semantic tokens（语义颜色变量）
- [ ] 设置 Light/Dark mode 值
- [ ] 建立 token 分类与命名规范
- [ ] 确保 Primitive token 不直接暴露给业务层
- [ ] 测试暗色模式一键切换

---

## Phase 3: 字体系统 (Typography)

### 字体选择
- [ ] 选定标题字体（确认授权）
- [ ] 选定正文字体（确认授权）
- [ ] 确认所有团队成员安装字体
- [ ] 确保安装所有粗细版本

### 字号系统
- [ ] 定义 5-7 个字号层级
- [ ] 正文字号 14px 或 16px 为基准
- [ ] 字号选取双数
- [ ] 每个层级定义字号 + 行高 + 字重

### 行高与间距
- [ ] 中文行高 = 字号 × 1.5-2
- [ ] 英文行高 = 字号 × 1.5
- [ ] 字间距设置合理

### 代码与规范落地
- [ ] 创建 Typography tokens（6个层级）
- [ ] 建立字号、行高、字重的 token 分组
- [ ] 设置 Mobile/Desktop mode 字号值
- [ ] 建立字体家族 token
- [ ] 在样式规范中绑定 token 值

---

## Phase 4: 间距与圆角 (Spacing & Radius)

### 间距
- [ ] 基准单位 4px
- [ ] 定义完整间距色阶 (0/2/4/8/12/16/20/24/32/40/48/64/80/96)
- [ ] 创建 Spacing variable collection
- [ ] 定义语义间距 token（可选）

### 圆角
- [ ] 定义圆角色阶 (0/2/4/8/12/16/24/full)
- [ ] 创建 Radius variable collection

---

## Phase 5: 图标系统 (Iconography)

- [ ] 确定图标风格（线性/填充/双色）
- [ ] 建立图标网格 (24px 为标准)
- [ ] 统一线条粗细 (2px at 24px)
- [ ] 创建核心功能图标集（最少 20-30 个）
- [ ] 创建图标组件（size 变体: 16/20/24/32/48）
- [ ] 使用语义颜色 token 管理图标颜色
- [ ] 建立图标专门页面
- [ ] 统一命名: `icon-name/size`

---

## Phase 6: 网格与布局 (Grid & Layout)

- [ ] 选择栅格系统 (12列/16列)
- [ ] 定义 4-5 个响应式断点 (XS/S/M/L/XL)
- [ ] 为每个断点设置列数/水槽/边距
- [ ] 创建对应画框尺寸
- [ ] 沉淀为统一布局规范或 CSS 工具类
- [ ] 双栏布局支持（B端产品）

---

## Phase 7: UI 组件 (Components)

### 基础组件
- [ ] Button（主/次/Ghost/Danger/Link + 大/中/小 + 所有状态）
- [ ] Input（默认/错误/禁用/聚焦）
- [ ] Select/Dropdown
- [ ] Checkbox
- [ ] Radio
- [ ] Switch/Toggle
- [ ] Badge
- [ ] Tag
- [ ] Avatar
- [ ] Divider
- [ ] Tooltip

### 复合组件
- [ ] Search Bar
- [ ] Form Item
- [ ] Breadcrumb
- [ ] Pagination
- [ ] Tab
- [ ] Alert/Message

### 复杂组件
- [ ] Navigation Bar
- [ ] Sidebar
- [ ] Card
- [ ] Table
- [ ] Modal/Dialog
- [ ] Drawer

### 组件质量
- [ ] 所有组件使用 Auto Layout
- [ ] 所有颜色引用 Semantic Token
- [ ] 所有间距使用 Spacing Token
- [ ] 所有字体使用 Typography Style
- [ ] 合理使用四种属性（变体/布尔/文本/实例交换）
- [ ] 所有交互组件定义完整状态
- [ ] 触控目标 ≥ 44×44pt
- [ ] 命名规范统一

---

## Phase 8: Design Tokens

- [ ] 建立三层 Token 架构（Primitive → Semantic → Component）
- [ ] 统一命名规范 (`category.property.modifier`)
- [ ] Primitive tokens 隐藏发布
- [ ] 所有 Semantic tokens 配置 Light/Dark mode
- [ ] Typography tokens 配置 Mobile/Desktop mode
- [ ] 配置 Code Syntax（CSS/iOS/Android 平台名称）
- [ ] 创建 Token 文档（表格或网站）
- [ ] Token 显示范围 (Scoping) 设置完成

---

## Phase 9: 说明文档 (Documentation)

- [ ] 设计原则页面
- [ ] 颜色系统文档 + Do/Don't
- [ ] 字体系统文档 + Do/Don't
- [ ] 间距系统文档
- [ ] 网格系统文档
- [ ] 图标系统文档
- [ ] 每个组件的完整文档（13项标准）
- [ ] 无障碍指南
- [ ] Token 参考页面
- [ ] 更新日志 (Changelog)
- [ ] 团队培训/推广

---

## 最终验收标准

### 无障碍 (Accessibility)
- [ ] 所有颜色对比度通过 WCAG AA
- [ ] 所有触控目标 ≥ 44pt (空间 UI ≥ 60pt)
- [ ] 支持键盘导航
- [ ] 支持屏幕阅读器
- [ ] 尊重系统偏好设置（暗色模式/减少动效/高对比度）
- [ ] 信息不仅依赖颜色传达（需有图标/文字辅助）
- [ ] 文本支持动态缩放且不截断/溢出
- [ ] 每个交互组件定义了无障碍属性模板

### 一致性 (Consistency)
- [ ] 零硬编码色值（全部引用 token）
- [ ] 零自定义间距（全部使用 spacing scale）
- [ ] 零自定义字号（全部使用 type scale）
- [ ] 命名规范 100% 统一

### 可扩展性 (Scalability)
- [ ] 新组件可无缝融入现有体系
- [ ] 新主题/品牌可通过切换 primitive tokens 实现
- [ ] 多平台输出 token 格式就绪

### 文档化 (Documentation)
- [ ] 所有基础模块有文档
- [ ] 所有组件有文档
- [ ] Do/Don't 示例完整
- [ ] 文档保持更新
