# Practical UI Field Guide

This is the condensed practical material from the previous heavier design-system references. Use it to make `DESIGN.md` specific enough to guide future UI without producing a large token/theme/preview package.

## 1. Start With Visual Levers

Do not begin with "make it premium" or "make it modern". Begin with 2-4 variables that will actually change the product's feeling.

Useful lever categories:

- Canvas and surface: warm paper background, cold white gallery, pure black theater, single-color chrome, shallow layers, deep stacked layers, content-as-color-source
- Typography: light-weight large headings, sans + mono utility system, editorial serif title, dense data labels, large readable body text
- Color: single accent, black/white chrome with content color, warm neutrals, cool neutrals, semantic colors only for states, brand color only for CTA and active states
- Shape and borders: low-radius controls, sharp editor-like corners, pill geometry only for tags/status, border-first hierarchy, hairline separators
- Depth: almost no shadow, shadow-as-border, branded shadow, local blur only, no glass by default
- Layout and density: generous editorial rhythm, dense operational grid, dashboard compression, single-column narrative, card matrix, full-bleed media
- Interaction tone: instant tool feedback, calm transitions, playful micro-rewards, no motion that delays the next action

Bad levers:

- Premium
- Clean
- Modern
- High-tech
- Beautiful
- International

These words can describe a result, but they cannot constrain implementation unless paired with visible evidence.

## 2. Common AI Failure Modes

### Decorative Gradient Drift

Symptoms: gradient hero, gradient CTA, gradient cards, no hierarchy.

Fix:

- Ban gradients by default.
- Use a gradient only when the brand or product meaning needs it.
- If used, confine it to one intentional area.

### Oversized SaaS Rounding

Symptoms: every card, button, input, and badge uses 16-24px corners.

Fix:

- Choose one shape language: sharp, low-radius, soft, or pill.
- For serious tools, prefer 4-8px unless the product intentionally needs friendliness.
- Reserve pill shapes for tags, filters, or status chips.

### Weak Gray Shadow Soup

Symptoms: generic black alpha shadow, blurry layers, every surface floats equally.

Fix:

- Decide whether borders or shadows carry hierarchy.
- Use shadows only for overlays, focus, elevation, or tactile feedback.
- Specify shadow color, blur range, and use case.

### Accent Color Competition

Symptoms: CTA, tags, icons, charts, and hover states all use different attention colors.

Fix:

- One primary accent for main action and active state.
- Semantic colors only for success/warning/error.
- Decorative color should not enter the interaction layer.

### Abstract Words Without Evidence

Symptoms: the document says elegant, modern, premium, futuristic, but gives no visual constraints.

Fix:

- Bind every adjective to color, type, density, radius, motion, or component behavior.
- Example: "engineering-like = mono labels, tight data rows, border-first surfaces, restrained shadows."

### Default Glassmorphism

Symptoms: blur panels, translucent chrome, reflective borders, low legibility.

Fix:

- Use glass/blur only when background context matters and text remains legible.
- Do not use it as a shortcut for "premium".
- Prefer solid surfaces for work, reading, finance, legal, health, and dense tools.

## 3. DESIGN.md Writing Rules

Good design direction follows this order:

1. Overall product feeling
2. Visual evidence behind that feeling
3. Direction for components and layouts
4. Anti-rules that prevent drift

Do not start with a full token table. Tokens name values, but they do not explain taste.

Recommended first paragraph:

```text
[产品名] 以 [产品类别/使用场景] 为基底，
通过 [2-4 个视觉杠杆] 强化气质。
它应该让用户感到 [情绪/品质]，
最适合 [核心页面/场景]，
不适合 [反向气质]。
```

For each section, prefer "role + use + boundary":

- Color: what role it plays, where it appears, where it must not appear
- Typography: what hierarchy it creates, when to use each style, what to avoid
- Surface: when to wrap content, when content should stand alone
- Motion: what state change it confirms, how fast it should feel, when to remove it

## 4. Component Direction Checklist

Only write enough to guide future UI. Avoid exhaustive component specs unless requested.

### Buttons

- Primary button should map to the single most important action in the current state.
- Secondary buttons should not visually compete with primary.
- Destructive actions need semantic color, confirmation, or spatial separation.
- Loading and disabled states must preserve layout size.

### Cards / Surfaces

- Do not card-wrap everything.
- Use a surface only when it groups related content, separates state, or creates focus.
- Choose border-first or shadow-first hierarchy; do not mix casually.
- Surface radius should match product tone and density.

### Inputs

- Inputs should explain expected value through label, placeholder, helper, or surrounding context.
- Focus state must be visible without relying only on color.
- Error state should say what happened and what to do next.
- Dense tools can use compact inputs; onboarding and consumer flows need more breathing room.

### Navigation

- Navigation should show where the user is and what the next meaningful places are.
- Do not over-highlight every nav item.
- Collapse based on task priority, not just screen width.

### Lists / Data Rows

- Optimize for scanning, comparison, and repeated action.
- Align numbers, statuses, and actions predictably.
- Metadata should recede until it matters.
- Row height should reflect information density, not visual fashion.

### Empty / Loading / Error

- Empty state should explain why the space is empty and offer one next action.
- Loading should preserve spatial expectations where possible.
- Error should be calm, specific, and recoverable.
- Success should confirm progress without blocking flow.

## 5. Visual Quality Review

Use this quick review after writing a design direction or reviewing a screen.

### Context

- What is this product or screen?
- What is the user's likely emotional state?
- What is the core object: document, chart, task, media, message, canvas, product, place?

### First Impression

Say plainly what stands out and what feels wrong. Avoid vague praise.

### Visual Design

- Color intentionality: every color has a role; accents do not compete.
- Type hierarchy: importance maps to scale, weight, line-height, and spacing.
- Shadow/border quality: depth is purposeful, not a gray blur.
- Visual weight: the heaviest thing is semantically important.
- Alignment and spacing: elements sit on a coherent rhythm.
- Icon consistency: same family, stroke, optical size, and color rule.

### Interface Design

- Focus mechanism: the user knows where to look first.
- Progressive disclosure: complexity appears when useful.
- Information density: density matches context.
- Feedback: action results are acknowledged.
- Redundancy: labels and descriptions do not repeat the obvious.

### Consistency

- Similar actions look and behave similarly.
- Platform conventions are followed unless intentionally improved.
- Components that look the same are actually treated as the same pattern.
- The interface feels made by one designer, not assembled from different kits.

## 6. Practical Token Direction Without Heavy Tokens

When the user has not asked for implementation tokens, describe token direction in prose:

- Color: background, text, accent, surface, border, semantic roles
- Typography: display/body/mono roles, hierarchy, number treatment
- Spacing: dense, moderate, generous; base rhythm such as 4/8px
- Radius: sharp, low, soft, pill-only
- Shadow: none, border-first, local elevation, overlay-only
- Motion: instant, calm, expressive, or reduced

Only generate actual CSS variables when the user asks for implementation assets.
