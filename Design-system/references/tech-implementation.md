# 技术实现指南 (Tech Implementation Guide)

## 一、技术栈层级模型

设计系统的代码落地涉及四个技术层级，每层的选择会影响 Token 输出格式和实现策略：

```
Layer 4 — 渲染能力层 (决定设计效果的天花板)
  Three.js / R3F / Lottie / GSAP / Framer Motion

Layer 3 — UI 框架层 (决定组件怎么封装)
  React / Vue / Svelte / Next.js / Nuxt / SwiftUI / Flutter

Layer 2 — CSS 方案层 (决定 Token 怎么接入)
  Tailwind / CSS Modules / styled-components / Vanilla Extract / SCSS

Layer 1 — Token 层 (设计系统的核心输出)
  CSS Variables / design-tokens.json (W3C) / Theme Object
```

---

## 二、CSS 方案层详解

### 方案对比

| 技术 | Token 接入方式 | 主题切换 | 约束强度 | 运行时开销 | 推荐场景 |
|------|--------------|---------|---------|-----------|---------|
| **原生 CSS Variables** | `var(--token)` | 运行时切换 class/attribute | 弱（无编译检查） | 零 | 所有项目的基础层 |
| **Tailwind CSS** | `tailwind.config` 映射 Token → utility class | 内建 `dark:` 前缀 | **强**（只能用定义好的值） | 零（编译时） | 快速开发、强约束 |
| **CSS Modules** | `.module.css` 中引用 CSS Variables | 需额外方案 | 中（作用域隔离） | 零 | 中型项目、避免冲突 |
| **styled-components / Emotion** | JS theme 对象 | `ThemeProvider` 切换 | 弱（任意 JS 表达式） | 有（运行时生成） | 高度动态的样式 |
| **Vanilla Extract / Panda CSS** | 编译时 TS 类型安全 Token | 编译时生成多主题 CSS | **强**（类型检查） | 零 | 需要类型安全的大型项目 |
| **SCSS/Sass** | `$variable` 编译时替换 | 不支持运行时切换 | 中 | 零 | 遗留项目 |

### 各方案的 Token 输出格式

#### Tailwind CSS
```js
// tailwind.config.js
module.exports = {
  theme: {
    colors: {
      primary: {
        10: 'var(--color-primary-10)',
        50: 'var(--color-primary-50)',
        // ... Token 映射为 Tailwind 色阶
      },
      surface: {
        default: 'var(--color-surface-default)',
        brand: 'var(--color-surface-brand)',
      },
      bg: {
        primary: 'var(--color-bg-primary)',
        secondary: 'var(--color-bg-secondary)',
        tertiary: 'var(--color-bg-tertiary)',
      }
    },
    spacing: {
      0: 'var(--space-0)',
      1: 'var(--space-1)', // 2px
      2: 'var(--space-2)', // 4px
      // ...
    },
    borderRadius: {
      sm: 'var(--radius-sm)',
      md: 'var(--radius-md)',
      lg: 'var(--radius-lg)',
      full: 'var(--radius-full)',
    },
    backdropBlur: {
      sm: 'var(--material-blur-sm)',
      md: 'var(--material-blur-md)',
      lg: 'var(--material-blur-lg)',
    }
  }
}
```

使用方式：`<button class="bg-surface-brand text-white rounded-md px-4 py-2">`

Tailwind 的优势：**开发者只能从定义好的 Token 中选择，天然防止硬编码偏离设计系统。**

#### styled-components / Emotion
```js
// theme.js
export const theme = {
  color: {
    primary: { 10: '#F3EAFF', 50: '#8A4CF7' },
    surface: { default: '#FFFFFF', brand: '#8A4CF7' },
    bg: { primary: '#FFFFFF', secondary: '#F2F2F7', tertiary: '#E5E5EA' },
    text: { primary: '#2C2C2E', secondary: '#636366' },
  },
  space: [0, 2, 4, 8, 12, 16, 20, 24, 32, 40, 48, 64],
  radius: { sm: 4, md: 8, lg: 16, full: 9999 },
  material: { blurSm: 8, blurMd: 16, blurLg: 24 },
};

// 使用
const Button = styled.button`
  background: ${p => p.theme.color.surface.brand};
  padding: ${p => p.theme.space[4]}px ${p => p.theme.space[5]}px;
  border-radius: ${p => p.theme.radius.md}px;
`;
```

#### Vanilla Extract (类型安全)
```ts
// tokens.css.ts
import { createTheme } from '@vanilla-extract/css';

export const [themeClass, vars] = createTheme({
  color: {
    primary50: '#8A4CF7',
    surfaceDefault: '#FFFFFF',
    surfaceBrand: '#8A4CF7',
    bgPrimary: '#FFFFFF',
    bgSecondary: '#F2F2F7',
    bgTertiary: '#E5E5EA',
  },
  space: { sm: '8px', md: '16px', lg: '24px' },
});

// 使用 — 拼写错误会编译报错
import { vars } from './tokens.css';
const button = style({ background: vars.color.surfaceBrand });
```

### 推荐策略

```
所有项目 → 始终生成 CSS Variables 作为基础层 (tokens/*.css)
         ↓ 根据技术栈额外生成：
Tailwind  → tailwind.config.js (映射 CSS Variables)
CSS-in-JS → theme.ts (JS 对象)
Vanilla E → tokens.css.ts (类型安全 Token)
SCSS      → _variables.scss ($variable 定义)
原生项目  → 直接用 CSS Variables
```

---

## 三、UI 框架层详解

### 主题系统对比

| 框架 | 主题机制 | Dark Mode 方案 | SSR 注意事项 |
|------|---------|---------------|-------------|
| **React** | Context + ThemeProvider | CSS Variables + `data-theme` 属性 | 无特殊处理 |
| **Next.js** | 同 React | `next-themes` 库，cookie 存储避免闪烁 | 需防 FOUC (Flash of Unstyled Content) |
| **Vue 3** | provide/inject 或 CSS Variables | CSS Variables 方案最简 | 无特殊处理 |
| **Nuxt** | 同 Vue | `@nuxtjs/color-mode` 模块 | 需防 FOUC |
| **Svelte** | stores + CSS Variables | CSS Variables 方案 | SvelteKit 需 cookie 方案 |
| **SwiftUI** | Environment + Asset Catalog | 系统原生 `@Environment(\.colorScheme)` | 不适用 |
| **Flutter** | ThemeData + MaterialApp | `ThemeMode.system / light / dark` | 不适用 |

### 主题切换防闪烁 (SSR 项目关键问题)

SSR 框架（Next.js/Nuxt）中，页面先在服务端渲染 HTML，再在客户端加载 JS。如果主题状态存在 JS 中，会导致：
1. 服务端渲染 Light 模式
2. 客户端 JS 加载后切换到 Dark 模式
3. 用户看到一次闪白 → 体验很差

**解决方案**：
```html
<!-- 在 <head> 中用阻塞脚本提前注入主题，在 JS 框架加载前执行 -->
<script>
  const theme = document.cookie.match(/theme=(light|dark)/)?.[1]
    || (matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
  document.documentElement.setAttribute('data-theme', theme);
</script>
```

### 组件库集成

当项目使用现成组件库时，设计系统 Token 需要桥接到组件库的主题系统：

| 组件库 | 桥接方式 |
|--------|---------|
| **MUI (Material UI)** | `createTheme()` 中用设计系统 Token 覆盖 MUI 默认值 |
| **Ant Design** | `ConfigProvider` 的 `theme.token` 映射 |
| **Chakra UI** | `extendTheme()` 注入 Token |
| **Shadcn/ui** | 直接修改 CSS Variables（天然兼容，最适合设计系统） |
| **Element Plus (Vue)** | CSS Variables 覆盖 `--el-color-primary` 等 |
| **Radix + Tailwind** | Token 通过 Tailwind config 注入，Radix 负责行为 |

**Shadcn/ui 特别说明**：Shadcn 本质上不是组件库，而是一套可复制到项目中的组件源码。它使用 CSS Variables 定义所有颜色，和设计系统 Token 方案天然兼容——直接替换它的 CSS Variables 即可。

---

## 四、渲染能力层详解

### 技术能力矩阵

| 技术 | 平面 UI | 动画/过渡 | 模糊/玻璃 | 3D | 粒子/光效 | 包体积 |
|------|--------|----------|----------|-----|---------|--------|
| **纯 CSS** | ✅ | 基础 | ✅ `backdrop-filter` | ❌ | ❌ | 0 |
| **Tailwind** | ✅ | 基础 | ✅ `backdrop-blur-*` | ❌ | ❌ | ~10KB |
| **Framer Motion** | ✅ | **弹簧/手势/布局** | ✅ | 有限 | ❌ | ~30KB |
| **GSAP** | ✅ | **时间线/滚动驱动** | ✅ | 有限 | ❌ | ~25KB |
| **Lottie** | ✅ | **AE 导出的复杂动画** | ✅ | 有限 | ✅ | ~50KB + JSON |
| **Three.js** | ❌ (不擅长) | ✅ | ✅ | **✅** | **✅** | ~150KB |
| **React Three Fiber** | ❌ | ✅ | ✅ | **✅** | **✅** | ~180KB |

### CSS 原生能实现的效果（大部分产品够用）

```css
/* 1. 玻璃/磨砂效果 — 覆盖 90% 的材质需求 */
.glass-surface {
  background: rgba(255, 255, 255, var(--material-opacity-glass));
  backdrop-filter: blur(var(--material-blur-md));
  -webkit-backdrop-filter: blur(var(--material-blur-md));
  border: 1px solid rgba(255, 255, 255, 0.2);
}

/* 2. 弹簧动画 — CSS 也能做基础的 */
.bounce-in {
  animation: bounceIn 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

/* 3. 渐变 + 动画 */
.gradient-shift {
  background: linear-gradient(135deg, var(--color-primary-50), var(--color-primary-30));
  background-size: 200% 200%;
  animation: gradientMove 3s ease infinite;
}

/* 4. 阴影层级 */
.elevation-1 { box-shadow: 0 1px 3px rgba(0,0,0,0.12); }
.elevation-2 { box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
.elevation-3 { box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
```

### Three.js / WebGL 集成策略

#### 关系
```
WebGL — 浏览器底层 GPU API（手写着色器，几百行画一个三角形）
 └─ Three.js — 封装库（几十行建一个 3D 场景）
      └─ React Three Fiber (R3F) — React 声明式封装
           └─ Drei — R3F 常用组件/Helper 集合
```

实际开发中几乎没人直接写 WebGL，都用 Three.js 或 R3F。

#### 混合架构
```
┌──────────────────────────────────────────┐
│  HTML + CSS (设计系统 Token 控制)          │
│  ┌────────────────────────────────────┐  │
│  │  NavBar / Header (CSS)             │  │
│  ├────────────────────────────────────┤  │
│  │  ┌──────────────────────────────┐  │  │
│  │  │  <canvas> — Three.js         │  │  │ ← 仅此区域是 WebGL
│  │  │  3D 产品展示 / 高级光效      │  │  │
│  │  └──────────────────────────────┘  │  │
│  ├────────────────────────────────────┤  │
│  │  Content / Footer (CSS)            │  │
│  └────────────────────────────────────┘  │
└──────────────────────────────────────────┘
```

**核心原则**：CSS 管 95% 的 UI，Three.js 只负责需要 3D/高级光效的**特定区域**。

#### Token 桥接：设计系统颜色 → Three.js
```js
// 从 CSS Variables 读取 Token，传给 Three.js
function getTokenColor(tokenName) {
  const value = getComputedStyle(document.documentElement)
    .getPropertyValue(tokenName).trim();
  return new THREE.Color(value);
}

const brandColor = getTokenColor('--color-primary-50');
const material = new THREE.MeshStandardMaterial({ color: brandColor });
```

React Three Fiber 版本：
```jsx
function BrandBox() {
  const color = useCSSVariable('--color-primary-50');
  return (
    <mesh>
      <boxGeometry args={[1, 1, 1]} />
      <meshStandardMaterial color={color} />
    </mesh>
  );
}
```

#### 主题切换时同步 3D 颜色
```js
// 监听主题变化，同步更新 3D 材质
const observer = new MutationObserver(() => {
  material.color = getTokenColor('--color-primary-50');
});
observer.observe(document.documentElement, {
  attributes: true,
  attributeFilter: ['data-theme']
});
```

### 动画库选型指南

| 需求 | 推荐方案 | 说明 |
|------|---------|------|
| 简单过渡 (hover/fade) | CSS transition/animation | 无需额外库 |
| 弹簧/手势/布局动画 | Framer Motion (React) | 声明式、体验好 |
| 时间线/滚动驱动 | GSAP + ScrollTrigger | 最强大的通用动画库 |
| 设计师在 AE 制作的动画 | Lottie | 设计师导出 JSON，前端直接播放 |
| 3D 场景/产品展示 | Three.js / R3F | 仅用于特定区域 |
| 微交互 (按钮/图标) | CSS 或 Framer Motion | 保持轻量 |

---

## 五、技术选型决策树

根据产品类型和设计需求，推荐以下组合：

### A. 标准 B 端产品
```
Token:    CSS Variables + design-tokens.json
CSS:      Tailwind CSS
框架:     React/Vue + Next.js/Nuxt
组件库:   Shadcn/ui 或 Ant Design (桥接 Token)
动画:     CSS transitions (够用)
材质:     backdrop-filter (如需要)
3D:       不需要
```

### B. 标准 C 端产品
```
Token:    CSS Variables + design-tokens.json
CSS:      Tailwind CSS
框架:     Next.js / Nuxt
组件库:   Shadcn/ui + 自定义组件
动画:     Framer Motion / CSS
材质:     backdrop-filter
3D:       不需要
```

### C. 品牌营销站 / 创意展示
```
Token:    CSS Variables + design-tokens.json
CSS:      Tailwind CSS
框架:     Next.js / Astro
动画:     GSAP + ScrollTrigger (滚动叙事)
材质:     backdrop-filter + CSS gradient animations
3D:       Three.js / R3F (局部 — Hero、产品展示)
特殊:     Lottie (品牌动画)
```

### D. 数据可视化产品
```
Token:    CSS Variables + design-tokens.json
CSS:      Tailwind / CSS Modules
框架:     React + Next.js
图表:     D3.js / ECharts / Recharts (桥接 Token 颜色)
动画:     Framer Motion
3D:       Three.js (如需 3D 图表)
```

### E. 移动端 App
```
Token:    design-tokens.json → 平台转换
iOS:      SwiftUI + Asset Catalog (Token 转为 Color Set)
Android:  Jetpack Compose + MaterialTheme (Token 转为 Theme)
跨平台:   Flutter ThemeData / React Native + Unistyles
```

---

## 六、Token 多平台转换

设计系统的 Token (design-tokens.json) 需要转换为各平台格式：

### 工具链
```
design-tokens.json (W3C 标准)
  ├─ Style Dictionary → CSS Variables / SCSS / iOS / Android
  ├─ 自定义脚本 → 直接生成各平台代码
  └─ 手动 → 直接写各平台代码
```

### Style Dictionary 转换示例
```json
// tokens/color.json (输入)
{
  "color": {
    "primary": {
      "50": { "value": "#8A4CF7", "type": "color" }
    }
  }
}
```

输出：
```css
/* CSS */
:root { --color-primary-50: #8A4CF7; }
```
```swift
// iOS
extension UIColor {
    static let primaryColor50 = UIColor(hex: "#8A4CF7")
}
```
```xml
<!-- Android -->
<color name="color_primary_50">#8A4CF7</color>
```
```js
// JS
export const colorPrimary50 = '#8A4CF7';
```

---

## 七、兼容性参考

### CSS 特性浏览器支持

| 特性 | Chrome | Safari | Firefox | 注意事项 |
|------|--------|--------|---------|---------|
| CSS Variables | ✅ 49+ | ✅ 9.1+ | ✅ 31+ | 全面支持 |
| `backdrop-filter` | ✅ 76+ | ✅ 9+ | ✅ 103+ | Safari 需 `-webkit-` 前缀 |
| `color-mix()` | ✅ 111+ | ✅ 16.2+ | ✅ 113+ | 可用于透明度计算 |
| Container Queries | ✅ 105+ | ✅ 16+ | ✅ 110+ | 组件级响应式 |
| `@layer` | ✅ 99+ | ✅ 15.4+ | ✅ 97+ | CSS 层级管理 |
| View Transitions | ✅ 111+ | ❌ | ❌ | 页面过渡动画，需回退方案 |
| Scroll-driven Animations | ✅ 115+ | ❌ | ❌ | 滚动驱动动画，需回退方案 |

### 回退策略
```css
/* backdrop-filter 回退 */
.glass-surface {
  background: rgba(255, 255, 255, 0.95); /* 回退：不透明背景 */
}
@supports (backdrop-filter: blur(1px)) {
  .glass-surface {
    background: rgba(255, 255, 255, 0.75);
    backdrop-filter: blur(16px);
    -webkit-backdrop-filter: blur(16px);
  }
}
```
