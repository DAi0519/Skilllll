# 图标系统指南 (Icon System Guide)

## 一、图标的作用
- 帮助用户快速识别操作、功能或产品
- 提供视觉引导
- 品牌视觉的重要元素
- 设计系统的核心组成部分

---

## 二、图标类型

### 1. 功能性图标 (Functional Icons)
- 具有明确功能指向（如菜单、箭头、搜索、设置）
- 需保持**简洁清晰**，不宜过度设计
- 用户熟知的图标不应轻易替换视觉元素
- 应用场景: 导航栏、功能按钮、工具栏

### 2. 装饰性图标 (Decorative Icons)
- 包含更丰富的视觉元素和情感体验
- 能更好表达品牌性格和形象
- 应用场景: 内容分类、导航、营销页面

---

## 三、图标设计原则

### 1. 一致性 (Consistency)
- 同一套图标需保持 **尺寸、颜色、粗细、风格** 的一致性
- 在数字产品中建立统一的视觉体验

### 2. 简洁易懂 (Clarity)
- 让用户在最短时间内理解图标含义
- 使用**矢量格式** (SVG) 方便导出和开发
- 慎用半透明或渐变色效果

### 3. 传递品牌价值 (Brand Expression)
- 结合品牌颜色进行设计
- 颜色使用不当会打乱 UI 视觉规律

---

## 四、图标规格

### 1. 尺寸系统

| 尺寸 | 用途 | 备注 |
|------|------|------|
| 16px | 紧凑场景 | 表格内、密集UI |
| 20px | 小图标 | 按钮内图标、标签 |
| 24px | **标准尺寸** | 最常用，导航、操作 |
| 32px | 中等图标 | 卡片图标、列表图标 |
| 48px | 大图标 | 空状态、功能入口 |
| 64px | 超大图标 | 插画型图标、引导页 |

### 2. 网格与比例
- 每个尺寸的图标应在对应的网格内绘制
- 确保图标具有一致的**视觉比例**
- 建立辅助线与网格后再开始绘制

### 3. 线条规范 (Stroke/Outline Icons)
- 标准线宽: **2px** (在 24px 尺寸下)
- 其他尺寸按比例缩放
- 圆角统一（与设计系统圆角保持一致）

---

## 五、图标创建

### 1. 自主绘制
1. 确定需求尺寸和风格
2. 建立辅助线与网格
3. 绘制图标，确保视觉比例一致
4. 使用 Flatten 合并路径
5. 命名: `图标名/尺寸` 格式（如 `Bell/24`）

### 2. 网络资源
- **来源**: 开源图标库、品牌资源库
- **推荐**: Mono Social Icons, Health Icons, Magicons, Phosphor Icons, Heroicons
- **使用方法**: 找到基础图标后进行细节调整（颜色、线条粗细、圆角等）

---

## 六、代码中的图标管理

### 1. 组件化
- 将不同尺寸合并为**同一图标组件**的 size 参数
- 变体值: 16, 20, 24, 32, 48
- 每个尺寸使用一致的 viewBox、stroke 和对齐规则

### 2. 颜色管理
- 使用预设颜色变量（Semantic Token）
- 常用图标颜色 token:

| Token | 用途 |
|-------|------|
| icon-default | 默认图标颜色 (Grey/70) |
| icon-brand | 品牌色图标 (Purple/50) |
| icon-inverse | 反色图标 (White) |
| icon-critical | 错误图标 (Red/60) |
| icon-success | 成功图标 (Green/60) |
| icon-warning | 警告图标 (Yellow/60) |
| icon-info | 信息图标 (Blue/60) |
| icon-disabled | 禁用图标 (Grey/30) |

### 3. 文件管理
- 统一命名图层和打包方式
- 为图标建立**专门目录或文档页面**
- 图标按功能分组: Navigation, Action, Status, Social, File, etc.

### 4. 命名规范
```
icon-name/size
```
示例: `close/24`, `search/24`, `arrow-right/16`

---

## 七、图标动效 (Animation)

### 标准动画预设 (ref: Apple SF Symbols 7)

SF Symbols 7 定义了一套成熟的图标动画预设体系，可作为通用设计系统的参考标准：

| 预设 | 效果 | 典型场景 |
|------|------|---------|
| Appear | 淡入出现 | 图标首次显示 |
| Disappear | 淡出消失 | 图标移除 |
| Bounce | 弹跳 | 点赞/收藏反馈 |
| Scale | 缩放 | 按下/释放 |
| Wiggle | 摇晃 | 错误/注意力引导 |
| Rotate | 旋转 | 加载/刷新 |
| Breathe | 呼吸脉动 | 等待/后台进行中 |
| Pulse | 脉冲 | 新通知/提醒 |
| Variable Color | 可变颜色 | 进度/信号强度 |
| Replace (Magic Replace) | 交叉切换 | 两个图标间切换（播放→暂停） |
| Draw On/Off | 笔画描入/擦除 | 引导动画、完成确认 |

**播放模式**：
- By Layer: 分层错开播放
- Whole Symbol: 整体同步播放
- Individually: 逐层完成后进入下一层

### 分层渲染 (Layered Rendering, ref: Apple Liquid Glass)

现代图标架构支持多层分离，允许单一图标资产适配多种外观模式：

| 渲染模式 | 说明 |
|---------|------|
| Default | 标准多色渲染 |
| Dark | 暗色模式适配 |
| Mono (Monochrome) | 单色渲染 |
| Tinted | 用户着色渲染 |
| Gradient | 从单一源色自动生成平滑渐变 |

**图标分层架构**：
- 最少两层：前景 + 背景
- 每层代表 Z 轴深度
- Liquid Glass 环境下，边缘高光和半透明效果自动添加

### 工具选择
| 工具 | 适用场景 |
|------|---------|
| After Effects + Lottie | 复杂动画 |
| LottieFiles | 预览和导出动画资源 (MP4/GIF/JSON) |
| Icon Composer (Apple) | Liquid Glass 分层图标创建 |
| SF Symbols App | 符号浏览与动画预览 |
| Fable / Motion | 替代方案 |

### 动效原则
- 动画是图标的**一等公民**，不是附加装饰
- 增加趣味性和注意力吸引
- 不要过度使用
- 尊重 `prefers-reduced-motion` 设置
- 图标设计需考虑"材质交互"而非仅视觉形态

---

## 八、无障碍 (Accessibility)

### 功能性图标
- 有明确操作含义 → 需要 `aria-label` 描述
- 键盘可聚焦

### 装饰性图标
- 纯视觉装饰 → 使用 `aria-hidden="true"`
- 不影响屏幕阅读器

### SVG 图标
- 使用 `currentColor` 以支持主题切换
- 设置 `role="img"` (功能性) 或 `role="presentation"` (装饰性)
