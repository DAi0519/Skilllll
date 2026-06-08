# Style Boundary Discovery

Use this before naming a visual style. The goal is not to find a trend label; the goal is to identify a real style need: a scene-specific aesthetic boundary where multiple tensions can coexist.

This is adapted from the Scene-Tension-Output pattern:

- Scene: the focused context where the style must work
- Tension: the conflicting qualities the design must reconcile
- Output: the concrete design language that resolves the tension

## Core Principle

Do not ask "what style is this?"

Ask "what style need exists here?"

Style names are answers: minimal, brutalist, editorial, glass, retro, Swiss, cyberpunk.

Style needs are problems:

- Users need control in a high-complexity system without being buried in engineering noise.
- Users need professional trust without the dead feeling of enterprise software.
- Users need warmth without cuteness.
- Users need density without pressure.
- Users need a tool that feels powerful without becoming cold.

Once the style need is clear, color, typography, density, layout, motion, and material decisions naturally narrow.

## 1. Scene

Make the scene concrete:

- Product type
- User group
- Use context
- Emotional state
- Task difficulty
- Content object
- Platform/device

Weak scene:

```text
A modern AI app.
```

Strong scene:

```text
An AI reading workspace for independent researchers who spend long sessions comparing papers, notes, source quotes, and uncertain model outputs.
```

## 2. Tension

The best design needs live inside tension.

Useful tension patterns:

- Professional but not corporate
- Technical but not cyber/glowing/demo-like
- Warm but not cute
- Premium but not luxury-advertising
- Minimal but not empty
- Dense but not oppressive
- Expressive but not chaotic
- Tool-like but not cold
- Trustworthy but not bureaucratic
- Experimental but not gimmicky
- Calm but not passive
- Playful but not childish

Bad tension:

```text
Make it simple, premium, modern, unique, dense, playful, serious, warm, and futuristic.
```

That is not a tension; it is a wish list. If the qualities do not form a believable intersection, say so and force a tradeoff.

## 3. Output

The output is a design language, not a mood board.

Include:

- Style need name
- Real psychological or use problem
- Core aesthetic tensions
- What it wants to be
- What it must not become
- Visual strategies
- Concrete UI decisions
- Anti-patterns
- A short story or scenario when helpful
- A final brief a designer or AI agent can use

## 4. Naming Style Needs

Name the need with a phrase that captures the boundary.

Examples:

- Calm Command Surface
- Warm Expert Tooling
- Quietly Auditable AI
- Dense Without Pressure
- Editorial Control Room
- Humanized Technical Console
- Trustworthy Creative Lab

Avoid existing trend names as the answer:

- Minimalism
- Brutalism
- Glassmorphism
- Swiss style
- Neumorphism
- Cyberpunk

You can reference these only as ingredients or anti-patterns.

## 5. DESIGN.md Guidance

When writing `Style Boundary`, use:

```text
Scene: [specific product/user/task/emotional context]
Core tension: [quality A] but not [bad version A]; [quality B] but not [bad version B]
What it wants to be: [the positive intersection]
What it must not become: [failure modes]
Style need name: [new phrase, not a trend name]
Design translation: [layout/type/color/density/motion/material consequences]
```

Make it concrete enough that a future UI agent can reject bad design choices.

## 6. Example

Scene:

```text
An AI agent workbench for advanced users who run multiple agents, inspect intermediate results, take over failed flows, and need auditability.
```

Core tension:

```text
Powerful but not terminal-oppressive; auditable but not bureaucratic; AI-native but not glowing demo theater.
```

Style need name:

```text
Quietly Auditable Command Surface
```

Design translation:

```text
Use dense but aligned rows, restrained status colors, clear provenance trails, compact controls, sober motion, and a calm surface model. Do not use purple-blue gradients, glass panels, decorative AI orbs, or fake command-line intimidation.
```
