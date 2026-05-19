# Minimal Efficient Aesthetic

Use this when the user has not provided a strong style preference, when a UI feels visually noisy, or when the user asks for MUJI, Dieter Rams, simplicity, restraint, efficiency, less clutter, or a calmer design system.

This is a default taste bias, not a universal law. User-provided references and product context can override it.

## Core Position

The default design taste is quiet, useful, honest, and efficient.

It is inspired by:

- MUJI: ordinary objects, warm restraint, no loud branding, material calm, enough but not more.
- Dieter Rams: good design is useful, understandable, unobtrusive, honest, long-lasting, thorough, and as little design as possible.
- Functional editorial systems: strong grid, clear hierarchy, disciplined typography, content-first structure.

Do not copy any brand. Translate the spirit into interface decisions.

## Aesthetic Principles

### 1. Reduce Before Decorating

Before adding color, cards, icons, shadows, or animation, remove:

- Duplicate labels
- Redundant containers
- Decorative panels
- Competing CTAs
- Repeated section descriptions
- Layout wrappers that do not group meaning
- Metadata shown before it is useful

The goal is not emptiness. The goal is higher signal per pixel.

### 2. One Clear Structure

A screen should reveal its structure quickly:

- One primary task per view
- One dominant reading direction
- One clear action hierarchy
- One consistent container logic
- One rhythm of spacing

If the user cannot explain the page layout in one sentence, the layout is probably too busy.

### 3. Honest Materials

Avoid fake visual drama:

- No default glassmorphism
- No decorative gradients
- No heavy drop shadows
- No floating card piles
- No fake 3D unless the product meaning needs it

Use solid surfaces, hairline dividers, real spacing, readable type, and meaningful imagery.

### 4. Quiet Color

Default palette:

- Warm white, soft off-white, or neutral paper background
- Deep charcoal or black-brown text
- Muted gray for secondary metadata
- One accent color for action and active state
- Semantic colors only for status

Rules:

- Never make color carry hierarchy alone.
- Do not use multiple accent colors for equal-priority actions.
- Let content, imagery, charts, or product objects provide richness when possible.
- Avoid beige monotony by balancing warmth with crisp contrast and exact spacing.

### 5. Typography As Infrastructure

Typography should make information easy to scan.

Default:

- System sans for most interfaces
- Mono for IDs, paths, code, metrics, timestamps, and structured fields
- Serif only when the product has editorial or cultural reasons
- Few type styles, strong roles

Rules:

- Use size, weight, line-height, and spacing deliberately.
- Avoid too many font weights.
- Avoid oversized hero type inside tools, dashboards, settings, or dense workspaces.
- Keep letter spacing at 0 unless there is a specific typographic reason.

### 6. Layout Without Piling

Common clutter pattern: card inside card, toolbar inside panel, section inside floating surface, with multiple headings saying the same thing.

Prefer:

- Full-width bands or unframed sections
- Hairline dividers instead of nested cards
- Tables or rows for comparable items
- Sidebars only when they hold persistent context
- Progressive disclosure for rare controls
- Dense but aligned control groups for operational tools

Spacing:

- Use fewer spacing values.
- Let proximity show relationships.
- Give important reading areas more line-height, not more decoration.
- Use negative space as structure, not as luxury styling.

### 7. Components Should Feel Inevitable

Buttons:

- Primary action is visually clear but not loud.
- Secondary actions recede.
- Dangerous actions are separated and semantic.

Cards and surfaces:

- Use a surface only when it groups meaning, isolates a state, or creates focus.
- Default to low radius.
- Prefer border-first hierarchy.

Inputs:

- Labels are clear and short.
- Focus state is visible.
- Error copy is specific and recoverable.

Navigation:

- Navigation should orient, not advertise.
- Active state can be restrained but must be obvious.

Motion:

- Fast acknowledgement, no spectacle.
- Motion must shorten comprehension, not extend waiting.

## Visual Levers To Prefer

- Warm paper canvas
- Crisp black/charcoal text
- Hairline separator system
- Low-radius utility controls
- Dense but aligned data rows
- Single accent action color
- Quiet chrome, expressive content
- Border-first surfaces
- Mono utility labels
- Calm responsive collapse

## Anti-Patterns

- Dashboard made of many unrelated rounded cards
- Gradient background used to make a weak layout look designed
- Large decorative icons that do not help recognition
- Repeating labels and descriptions in every panel
- Three or more competing accent colors
- Pale low-contrast luxury styling
- Empty whitespace that hides missing hierarchy
- Minimalism that removes necessary power

## How To Write This Into DESIGN.md

Add an `Aesthetic Direction` section like:

```text
The default visual taste should be quiet and efficient: warm neutral canvas,
deep readable text, low-radius controls, border-first grouping, and a single
accent color reserved for action. The UI should feel designed by subtraction:
less chrome, fewer containers, stronger alignment, and clearer hierarchy.
```

Then make it product-specific:

```text
For this product, restraint should not mean sparse. It should mean every dense
row, tag, and control has a stable place, so users can compare and decide
without visual noise.
```
