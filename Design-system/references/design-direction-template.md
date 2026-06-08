# Design Direction Template

Use this when the main output is getting too long or too implementation-heavy.

```markdown
# [Product Name] Design Direction

> Last updated: YYYY-MM-DD
> Purpose: A lightweight visual constitution for future UI work.

## 1. Product Essence

[产品名] 是一个面向 [用户] 的 [产品类型]，帮助他们在 [场景] 中完成 [核心任务]。界面应该让人感到 [3 个具体品质]，而不是 [2-3 个反向气质]。

## 2. Design Philosophy

这个方向借鉴 Apple/Jobs 的不是表面样式，而是设计纪律：

- 内容先于 chrome
- 简化来自取舍，不来自空白
- 每个控件都解释自己的行为
- 一致性帮助用户预测结果
- 细节服务信任感

## 3. Aesthetic Direction

默认审美倾向是安静、高效、去噪：接近 MUJI 与 Dieter Rams 的克制精神，但不照搬任何品牌表面。界面应通过少量颜色、清晰排版、低噪表面、稳定网格和必要控件建立秩序。简约不是空白，而是减少无用装饰后让核心任务更清楚。

## 4. Style Boundary

- Scene: [产品类型、用户、任务、情绪压力、使用环境]
- Core tension: [想要的品质] 但不能 [坏版本]；[另一个品质] 但不能 [坏版本]
- What it wants to be: [真实交集]
- What it must not become: [失败模式]
- Style need name: [新命名，不偷懒用流行风格名]
- Design translation: [布局、字体、颜色、密度、材质、动效如何收敛]

## 5. Visual Levers

- [杠杆 1]: [如何体现在颜色/排版/布局/组件]
- [杠杆 2]: [如何体现在颜色/排版/布局/组件]
- [杠杆 3]: [如何体现在颜色/排版/布局/组件]

## 6. Anti-Generic Rules

- 不要 [...]
- 不要 [...]
- 不要 [...]
- 不要 [...]

## 7. Core Visual Direction

- Color: [主背景、文本、强调色、状态色的方向，不必列完整 token]
- Typography: [字体气质、层级、数字/代码/标题策略]
- Spacing and density: [稀疏/紧凑/信息密度]
- Radius and surfaces: [圆角大小、边框、卡片/面板使用条件]
- Depth and shadow: [何时使用阴影/分层/模糊，何时不用]
- Motion: [速度、用途、禁忌]
- Iconography: [线性/实心、尺寸、使用场景]

## 8. Information Hierarchy & Typography

- Primary hierarchy: [页面/对象/状态/动作/元数据如何分层]
- Alignment: [主对齐轴、表格/表单/列表对齐规则]
- Spacing rhythm: [紧密关系、组关系、section 关系]
- Typography elegance: [字号阶梯、行高、行宽、字距、中英混排、标题换行规则]
- Text density: [段落长度、行内文本、何时折叠]
- Repetition control: [哪些标题、说明、标签不能重复]
- Meaningful information only: [哪些信息必须显示，哪些必须隐藏，哪些属于填充文字要删除]
- Scan patterns: [用户如何扫读和决策]

## 9. Component Direction

- Buttons: [主次按钮如何区分]
- Cards / surfaces: [什么时候需要容器，什么时候内容裸排]
- Inputs: [密度、状态、错误反馈]
- Navigation: [信息架构和当前位置表达]
- Lists / data rows: [扫描、比较、操作区布局]
- Empty / loading / error states: [语气和行动指引]

## 10. Layout Principles

[页面如何组织：主任务、辅助信息、操作区、响应式折叠、移动端优先级。]

## 11. Agent Rules

- [规则 1]
- [规则 2]
- [规则 3]
- [规则 4]
- [规则 5]
- [规则 6]
- [规则 7]
- [规则 8]

## 12. Optional Expansion Points

- Tokens: 仅当需要进入实现时再提取。
- Preview: 仅当需要验证气质时生成一个轻量 HTML。
- Component specs: 仅当同一组件会被复用 3 次以上时细化。
- Dark mode: 仅当产品需要长时间使用或平台默认要求时设计。

## Changelog

- YYYY-MM-DD: Created design direction.
```

Compression rules:

- `DESIGN.md` should usually stay between 120 and 220 lines.
- Prefer direction over exhaustive specs.
- Prefer prohibitions and examples over abstract adjectives.
- Avoid full token scales unless the user asks for implementation.
- Keep Apple/Jobs references as translated principles, not fan language.
