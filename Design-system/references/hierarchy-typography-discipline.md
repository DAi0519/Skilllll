# Hierarchy & Typography Discipline

Use this when writing or reviewing `DESIGN.md` hierarchy, typography, spacing, alignment, text density, or repetition-control rules. This file exists because many otherwise tasteful designs fail by becoming visually noisy: repeated headings, dense text blocks, unclear scan paths, and misaligned controls.

## Core Rule

A screen must answer three questions within three seconds:

1. What is this?
2. What matters most right now?
3. What can I do next?

If the layout, typography, or copy prevents those answers, the design is not finished.

Meaningless information display is design debt. Text is not filler, and metadata is not decoration. Every visible word must earn its place.

Typography is not only font choice. Elegance comes from scale, line-height, measure, spacing, alignment, and restraint.

## 1. Information Hierarchy

Every screen needs a hierarchy ladder:

- Level 1: page purpose or current object
- Level 2: primary state, decision, or action
- Level 3: supporting fields, metadata, filters, secondary actions
- Level 4: logs, timestamps, IDs, helper text, debug detail

Rules:

- Only one thing should be visually dominant in a view.
- The primary action must be visually easier to find than secondary actions.
- Metadata should be available but visually quieter than decisions.
- Status, errors, and blockers can temporarily outrank normal hierarchy.
- Do not make headings, cards, badges, and buttons all visually loud at the same time.

## 2. Repetition Control

Common failure: title, subtitle, card heading, helper text, empty state, and button all restate the same idea.

Before finalizing, remove:

- Repeated section descriptions
- Labels that repeat the table column or surrounding context
- Helper text that explains obvious controls
- Multiple headings that name the same object
- Buttons whose labels duplicate nearby headings without adding action clarity

Prefer:

- One strong heading
- One useful supporting sentence when needed
- Short labels on controls
- Details hidden behind disclosure, tooltip, or secondary area when not needed

## 3. Meaningful Information Only

Ban filler information.

Remove any text, metric, label, badge, caption, helper line, or card if it does not help the user:

- Understand current state
- Compare options
- Make a decision
- Take an action
- Trust provenance or result quality
- Recover from an error

Common offenders:

- Decorative stats that do not affect decisions
- Generic subtitles like "Manage all your items in one place"
- Helper text that explains an obvious input
- Empty marketing copy in tools
- Repeated "quick overview" sections
- Metadata shown before the user needs it
- Badges that classify nothing important
- Long descriptions beside self-explanatory controls

Rules:

- If removing the text changes nothing, remove it.
- If the text only makes the layout feel full, remove it.
- If the same idea appears twice, keep the sharper one.
- If metadata matters only later, hide it behind disclosure or secondary detail.
- Prefer one precise sentence over three vague ones.

## 4. Typographic Roles

Use few styles with clear jobs.

Recommended role set:

- Display / page title: only for the page or primary object
- Section title: groups a meaningful region
- Body: reading and explanations
- Label: form fields, table headers, compact metadata
- Mono: IDs, paths, code, metrics, timestamps, structured values
- Caption: secondary notes, helper text, provenance

Rules:

- Do not create a new text style unless it has a new role.
- Avoid more than 2-3 weights in one view.
- Avoid hero-scale type inside dense tools, dashboards, settings, or review workflows.
- Keep letter spacing at 0 by default.
- Use line-height to create reading comfort, not extra cards or decoration.
- Long paragraphs should be broken into short blocks, bullets, tables, or progressive disclosure.

## 5. Typography Elegance

Most AI-generated UI fails here: text is technically readable, but the rhythm is ugly. Headings are too large, labels shout, line-height is random, paragraphs are too wide, and text blocks become gray slabs.

Rules:

- Use a small type scale. A compact product usually needs 4-6 text roles, not 12.
- Body line-height should usually feel open: roughly 1.45-1.65 for reading, tighter for tables and controls.
- Dense rows can use tighter line-height, but never so tight that Chinese characters or mixed English/number strings feel cramped.
- Keep letter spacing at 0 by default. Do not use negative letter spacing. Only use slight positive tracking for tiny uppercase labels when it improves scan quality.
- Keep line length controlled. Long reading text should not run full width; dense metadata can be narrower and structured.
- Do not let headings wrap awkwardly. If a heading wraps, the second line should still feel intentional.
- Avoid mixing too many font sizes and weights in one region. Contrast should be decisive, not noisy.
- Use whitespace around text blocks to create rhythm; do not add boxes just because text needs breathing room.
- Align baselines and optical edges. Icons, tags, numbers, and labels should sit with text, not merely inside the same container.
- Chinese and English mixed UI needs extra care: avoid cramped punctuation, awkward line breaks, and oversized Latin labels next to Chinese body text.

Elegant typography feels inevitable:

- title identifies the object
- subtitle adds real context or disappears
- label names the field
- value carries the data
- helper text appears only when it changes behavior

If two text elements have the same visual weight but different importance, fix the type hierarchy.

## 6. Alignment Discipline

Good alignment creates calm.

Rules:

- Pick one dominant alignment axis per region.
- Align labels, values, controls, and actions predictably.
- Numbers, scores, dates, statuses, and IDs should align for comparison.
- Avoid centered text in operational tools unless it is a true empty state or modal.
- Do not mix left-aligned headings with randomly centered cards.
- In forms, labels and inputs should form a consistent grid.

Check:

- Can the eye scan down a clean left edge?
- Do primary actions sit in predictable positions?
- Are related items grouped by proximity before borders are added?
- Are icons optically aligned with text, not merely mathematically centered?

## 7. Spacing Rhythm

Spacing should explain relationships.

Rules:

- Use fewer spacing values.
- Related items sit closer together than unrelated items.
- Section gaps must be visibly larger than item gaps.
- Dense tools can be compact, but compact does not mean cramped.
- Do not use padding to hide weak hierarchy.
- Avoid card padding so large that content loses relation to its heading or action.

Practical rhythm:

- Tight relation: 4-8px
- Normal field/row relation: 8-12px
- Group relation: 16-24px
- Section relation: 32-48px

These are directions, not mandatory tokens. Adjust for product density.

## 8. Text Density

Dense text is acceptable when it supports expert scanning. Text piles are not.

Rules:

- One paragraph should usually express one idea.
- If a sentence has more than two clauses, consider splitting it.
- Lists should be parallel and action-oriented.
- In cards or rows, text should usually fit in 1-2 lines before metadata takes over.
- Long explanations belong in documentation, disclosure, side panels, or reports.
- Empty states should be short: reason + next action.

Use progressive disclosure when:

- The information is only needed after a user shows intent.
- The detail supports trust but not initial decision.
- Debug/state information is useful but visually heavy.

## 9. Scan Patterns

Choose a scan pattern intentionally:

- Editorial flow: read top to bottom
- Workbench: act left to right, monitor side context
- Comparison table: scan down columns
- Review queue: choose item, inspect detail, decide next action
- Canvas/product view: content first, controls around it

Rules:

- Do not mix scan patterns in the same region.
- Put recurring actions in stable places.
- Keep destructive or irreversible actions spatially separated.
- Use grouping and order before adding color.

## 10. DESIGN.md Output Guidance

When writing `Information Hierarchy & Typography`, include:

```text
Primary hierarchy: [what is level 1/2/3/4]
Alignment: [dominant axis, table/form/list rules]
Spacing rhythm: [tight/group/section behavior]
Typography elegance: [type scale, line-height, measure, letter spacing, mixed-language rules]
Text density: [paragraph length, row text, disclosure rules]
Repetition control: [what to remove or never repeat]
Meaningful information only: [what must be shown, what must be hidden, what is banned as filler]
Scan patterns: [how users move through the screen]
```

Make it product-specific. Avoid generic lines like "use clear hierarchy" unless followed by exact behavior.
