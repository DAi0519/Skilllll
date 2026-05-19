# Apple Design Philosophy Reference

Use this only when the user asks for Apple-level design judgment, Steve Jobs philosophy, HIG grounding, or a more opinionated taste pass.

Sources to keep in mind:

- Apple Human Interface Guidelines: https://developer.apple.com/design/human-interface-guidelines/
- Apple Get Started with Design: https://developer.apple.com/design/get-started/
- Apple Color guidance: https://developer.apple.com/design/human-interface-guidelines/foundations/color/
- Apple Accessibility guidance: https://developer.apple.com/design/human-interface-guidelines/accessibility
- Apple Layout guidance: https://developer.apple.com/design/human-interface-guidelines/layout

Do not quote these at length. Translate the principles into product decisions.

## Core Principles To Internalize

### 1. Hierarchy

The interface must make priority obvious. Primary content, primary action, secondary action, and metadata should not compete.

Apply this by deciding:

- What is the one thing the user should notice first?
- Which controls should visually recede until needed?
- Which information can be grouped, delayed, or removed?

### 2. Harmony

The product should feel like one coherent object. Shape language, spacing, material, icon style, motion, and tone should belong together.

Apply this by deciding:

- One dominant surface model
- One radius logic
- One accent role
- One typography rhythm
- One interaction tempo

### 3. Consistency

Consistency is not repetition for its own sake. It is the user's ability to predict what will happen.

Apply this by deciding:

- Same action, same control treatment
- Same content type, same layout behavior
- Same state, same visual language
- Same platform convention unless there is a clear reason to diverge

### 4. Content Before Chrome

The frame should serve the content. Reduce borders, panels, wrappers, shadows, and labels until the user's task becomes easier.

Ask:

- Is this surface helping comprehension or just decorating?
- Can the content carry the layout?
- Can a control appear only when context makes it useful?

### 5. Earned Simplicity

Simplicity is not emptiness. It is the result of ruthless prioritization.

Ask:

- What can be removed without reducing user power?
- What can be combined because users perceive it as one action?
- What can become progressive disclosure?
- What decision is the interface forcing users to make too early?

### 6. Tactility And Feedback

Good interfaces feel responsive and physical without becoming theatrical. Motion and material should confirm cause and effect.

Use:

- Fast acknowledgement for taps, clicks, toggles, and state changes
- Slight depth only to clarify layers or focus
- Motion that preserves orientation
- Reduced motion support

Avoid:

- Delayed animations after every action
- Floating surfaces without hierarchy
- Glass or blur when it harms legibility
- Decorative motion unrelated to state

### 7. Accessibility Is Taste

Legibility, contrast, keyboard behavior, focus visibility, language clarity, and adaptable layouts are part of visual quality.

Check:

- Text remains readable at realistic sizes
- Color is not the only status signal
- Controls have clear focus states
- Touch/click targets are comfortable
- Empty, loading, and error states are understandable

## Jobs-Inspired Product Questions

Use these questions before writing the design direction:

- What is the product saying no to?
- What is the one interaction that must feel inevitable?
- What would make this feel obvious instead of explained?
- Which details create trust because they show care?
- Where is the interface asking the user to think about the system instead of their goal?
- If there were only one screen, what would it have to prove?

## Anti-Imitation Rules

- Do not copy Apple's current visual style unless the product is explicitly for an Apple platform and the user asks for platform-native UI.
- Do not use Liquid Glass, translucent chrome, SF-like typography, macOS traffic lights, or iOS navigation as shortcuts for quality.
- Do not make everything minimal if the product needs density, comparison, or operational control.
- Do not confuse luxury with low contrast.
- Do not confuse simplicity with hiding necessary power.

## Translation Formula

Use this pattern in `DESIGN.md`:

```text
This product borrows Apple's discipline of [principle],
but expresses it through [local product decision],
because the user's main job is [task].
```

Examples:

- This product borrows Apple's discipline of content-first hierarchy, but expresses it through quiet navigation and strong document typography, because the user's main job is reading and deciding.
- This product borrows Apple's discipline of earned simplicity, but expresses it through progressive disclosure and one primary action per state, because the user's main job is moving work forward without configuration anxiety.
