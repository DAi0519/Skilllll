# 字体系统完整指南 (Typography System Guide)

## 一、字体选择原则

### 1. 易读性优先 (Legibility First)
- 数字产品中字体选择以**易读性**为最优先考虑因素
- 影响因素: 字体类型、字号、字间距、行间距、颜色对比度
- 目标: 让用户快速轻松阅读

### 2. 避免使用的字体类型
| 类型 | 建议 | 原因 |
|------|------|------|
| 手写体/海报体 | 禁用 | 装饰性过强，严重影响易读性 |
| 宋体/楷体 (衬线字体) | 谨慎使用 | 大面积使用会使页面过于复杂 |
| 黑体 (无衬线字体) | 首选 | 简洁清晰，适合屏幕显示 |

### 3. 平台默认字体
| 平台 | 推荐字体 |
|------|---------|
| Apple (iOS/macOS) | PingFang SC (苹方简体) / SF Pro |
| Android | Noto Sans (思源黑体) / Roboto |
| Windows | Microsoft YaHei (微软雅黑) / Segoe UI |
| Web (通用) | System font stack |

### 4. 字体气质匹配
| 行业 | 推荐风格 | 原因 |
|------|---------|------|
| 政府/金融/科技 | 无衬线字体 | 体现简洁、现代、可靠 |
| 传媒/新闻 | 衬线字体 | 行业传统习惯 |
| 儿童/宠物/游戏 | 标题可稍夸张 | 突出行业氛围和趣味性 |

### 5. 字体数量控制
- **产品中使用的字体数量不超过3种**
- 通常: 1种标题字体 + 1种正文字体即可

### 6. 字体来源与授权
| 字体 | 授权情况 |
|------|---------|
| Google Noto Sans / Roboto | 完全免费 |
| 阿里巴巴惠普字体 | 免费商用 |
| Apple SF Pro / PingFang | 仅限苹果生态 |
| 企业定制字体 | 需购买授权 |

**重要**: 必须确认字体是否可以免费商用或需要授权

---

## 二、字体样式规范

### 1. 字号系统 (Font Size Scale)

#### 基准规则
- 正文字号以 **14px 或 16px** 为基准
- 递增幅度: 以 2 或 4 为增量单位
- 字号通常选取**双数**

#### 推荐层级

| 级别 | 中文名 | 字号 (Desktop) | 字号 (Mobile) | 行高 | 用途 |
|------|--------|--------------|-------------|------|------|
| Title Hero | 展示标题 | 48px | 40px | 56px / 48px | 营销页面、落地页大标题 |
| Title | 主标题 | 32px | 28px | 40px / 36px | 页面主标题 |
| Subtitle | 副标题 | 24px | 20px | 32px / 28px | 区块标题、二级标题 |
| Body Emphasis | 正文强调 | 16px | 16px | 24px / 24px | 重要正文、按钮文字 |
| Body | 正文 | 14px | 14px | 22px / 22px | 主要正文内容 |
| Label | 标签文本 | 12px | 12px | 18px / 18px | 辅助文字、标签、时间戳 |

#### 行业参考

**Apple Dynamic Type Scale (13 级预定义 Text Style)**:

| 样式名 | 字重 | 字号 (pt) | 说明 |
|--------|------|-----------|------|
| Extra Large Title | Bold | 36 | 最大展示标题 |
| Extra Large Title 2 | Bold | 28 | 次级展示标题 |
| Large Title | Regular | 34 | 大标题 |
| Title 1 | Regular | 28 | 一级标题 |
| Title 2 | Regular | 22 | 二级标题 |
| Title 3 | Regular | 20 | 三级标题 |
| Headline | Semibold | 17 | 小标题（加粗） |
| Body | Regular | 17 | 正文 |
| Callout | Regular | 16 | 说明文字 |
| Subheadline | Regular | 15 | 副标题 |
| Footnote | Regular | 13 | 脚注 |
| Caption 1 | Regular | 12 | 辅助说明 |
| Caption 2 | Regular | 11 | 最小辅助文字 |

**Apple 关键设计决策**：
- 每个 Text Style 是**预定义组合**（字重+字号+行高+字距），不允许任意混搭
- SF Pro 分两个变体：Display (≥20pt) 字距更紧、笔画更细；Text (<20pt) 字距更宽、笔画略粗
- 推荐字重：Regular、Medium、Semibold、Bold；不推荐 Ultralight/Thin/Light（可读性差）

**Material Design 3** (5 roles × 3 sizes = 15 styles):
- Display: Large (57/64), Medium (45/52), Small (36/44)
- Headline: Large (32/40), Medium (28/36), Small (24/32)
- Title: Large (22/28), Medium (16/24), Small (14/20)
- Body: Large (16/24), Medium (14/20), Small (12/16)
- Label: Large (14/20), Medium (12/16), Small (11/16)

### 2. 字重选择 (Font Weight)

| 数值 | 名称 | 用途 |
|-----|------|------|
| 200 | Thin | 装饰性标题 |
| 300 | Light | 大号展示标题 |
| 400 | Regular | 正文 |
| 500 | Medium | 强调正文、小标题 |
| 600 | SemiBold | 标题、导航 |
| 700 | Bold | 重要标题 |

- 正文使用 **Regular (400)**
- 标题使用 **SemiBold (600)** 或 **Bold (700)**
- 需根据实际预览效果决定

### 3. 颜色规范

| 元素 | 推荐色值 | 说明 |
|------|--------|------|
| 主要文本 | Grey/80 ~ Grey/90 | 深灰色，非纯黑 |
| 次要文本 | Grey/60 ~ Grey/70 | 中灰色 |
| 辅助文本 | Grey/40 ~ Grey/50 | 浅灰色 |
| 禁用文本 | Grey/30 | 更浅灰色 |

**避免使用**:
- 纯黑色 (#000000) — 对比度过强
- 过浅颜色 — 对比度不足

### 4. 间距设置

#### 字间距 (Letter Spacing)
- 正文: 通常设为 0%
- 大标题: 可适当增加 (2%) 以增强可读性

#### 行高 (Line Height)
- 中文: 字号 × **1.5 ~ 2 倍**
- 英文: 字号 × **1.5 倍**
- 简单公式: **行高 = 字号 + 8**

---

## 三、代码中的实现

### 1. 文本样式 (Text Styles)
- 为每个层级创建可复用的文本样式定义
- 样式包含: 字体、字号、行高、字重、字间距
- 命名规范: `Title Hero`, `Title`, `Subtitle`, `Body Emphasis`, `Body`, `Label`

### 2. 字号/行高 token
用于实现响应式字体（Mobile/Desktop 不同值）:

```
分组: font/size/
  - font/size/xs → Mobile: 12, Desktop: 12
  - font/size/sm → Mobile: 14, Desktop: 14
  - font/size/m  → Mobile: 16, Desktop: 16
  - font/size/l  → Mobile: 20, Desktop: 24
  - font/size/xl → Mobile: 28, Desktop: 32
  - font/size/2xl→ Mobile: 40, Desktop: 48

分组: font/line-height/
  - font/line-height/xs → Mobile: 18, Desktop: 18
  - font/line-height/sm → Mobile: 22, Desktop: 22
  ...以此类推
```

### 3. 字体家族 token
```
font/family/title → "SF Pro" (或品牌标题字体)
font/family/body  → "SF Pro" (或品牌正文字体)
```
- 可统一切换全站字体

### 4. 样式 + token 结合
- 用**样式**记录完整文本属性组合
- 用**token**为各属性创建统一来源（可引用、可多模式切换）
- 最佳实践: 在样式中绑定 token 值

### 5. 团队协作
- 所有成员需提前统一安装字体
- 本地字体需单独同步并安装才能在本地预览一致效果
- 确保安装字体所有粗细版本文件

---

## 四、响应式字体设计

### 设备适配
- 桌面端: 更大字号增强视觉冲击力
- 移动端: 较小字号节省空间
- 使用 token mode、媒体查询或主题配置实现 Mobile/Desktop 切换

### 命名规范
- 尺寸级别: xs / sm / m / l / xl / 2xl
- 模式分组: Mobile / Desktop

---

## 五、Dynamic Type 动态缩放 (ref: Apple HIG)

### 核心概念
- 用户可在系统设置中调整偏好字号（7 个档位：xSmall → xxxLarge）
- 所有 Text Style 在不同档位有对应的字号、行高、字距
- 系统自动调整 tracking 和 leading

### 设计系统中的实现
1. **布局不能假设固定文字尺寸** — 容器需要弹性伸缩
2. **文本不能被截断或溢出** — 设计时以默认档位为基准，但需测试极端档位
3. **Web 实现**：使用 `rem` 单位 + 用户浏览器设置 / `font-size` 缩放
4. **关键检查**：在最大字号下，所有文本是否仍然完整可读？布局是否合理？

### 何时必须支持
- 面向大众用户的产品（C端）— **必须**
- 内部工具/B端 — **推荐**，特别是有无障碍合规要求时

---

## 六、Token 输出格式

```
font.title-hero:
  fontFamily: {font.family.title}
  fontSize: {font.size.2xl}      # Desktop: 48px, Mobile: 40px
  lineHeight: {font.line-height.2xl}  # Desktop: 56px, Mobile: 48px
  fontWeight: 700
  letterSpacing: 0%

font.body:
  fontFamily: {font.family.body}
  fontSize: {font.size.sm}       # 14px
  lineHeight: {font.line-height.sm}  # 22px
  fontWeight: 400
  letterSpacing: 0%
```
