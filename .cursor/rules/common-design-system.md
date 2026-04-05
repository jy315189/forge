---
description: "UI/UX design system: layout, typography, color, components, responsive, a11y"
globs: "**/*.{tsx,jsx,vue,svelte,html,css,scss,less}"
---
# Design System Standards

## Layout Principles

- Use **8px grid** for spacing (4px for compact elements)
- Standard spacing scale: 4, 8, 12, 16, 24, 32, 48, 64, 96
- Maximum content width: 1200px (prose: 680px for readability)
- Consistent padding: cards 16-24px, sections 32-48px, page 16-64px (responsive)
- Vertical rhythm: maintain consistent spacing between sections

## Typography

- **Heading hierarchy** must be semantic: h1 → h2 → h3 (never skip levels)
- Body text: 16px minimum (14px for secondary/caption text only)
- Line height: 1.5 for body, 1.2-1.3 for headings
- Maximum line length: 65-75 characters for readability
- Font stack: system fonts first, then web fonts (`-apple-system, BlinkMacSystemFont, ...`)

## Color System

- Define semantic color tokens, not raw hex values:
  - `--color-primary`, `--color-secondary`, `--color-accent`
  - `--color-success`, `--color-warning`, `--color-error`, `--color-info`
  - `--color-bg`, `--color-surface`, `--color-text`, `--color-text-muted`
- Contrast ratio: ≥ 4.5:1 for normal text, ≥ 3:1 for large text (WCAG AA)
- Dark mode: use separate token values, never invert colors blindly
- Never rely on color alone to convey information (add icons, text, patterns)

## Component Patterns

- **Buttons**: primary (1 per view), secondary, tertiary/ghost, destructive (red)
- **Forms**: labels above inputs, visible error states, helper text below
- **Cards**: consistent border-radius (8-12px), subtle shadow or border
- **Modals**: backdrop overlay, focus trap, Escape to close
- **Loading**: skeleton screens over spinners; show content progressively
- **Empty states**: illustration + message + action ("No results. Try adjusting filters")

## Interactive States

Every interactive element must have:
- Default, Hover, Active/Pressed, Focus (visible ring), Disabled
- Focus must be visible without mouse — keyboard navigation is required
- Transitions: 150-200ms for micro-interactions, 300ms for layout changes

## Responsive Breakpoints

```
Mobile:   < 640px   (single column, stacked layout)
Tablet:   640-1024px (2 columns, collapsible sidebar)
Desktop:  > 1024px  (full layout)
```

- Mobile-first: design for smallest screen, enhance upward
- Touch targets: minimum 44×44px on mobile
- No horizontal scroll on any breakpoint

## Accessibility (a11y)

- All images: meaningful `alt` text (decorative → `alt=""`)
- Form inputs: associated `<label>` elements (not just placeholder)
- Keyboard navigation: logical tab order, visible focus indicators
- ARIA: use semantic HTML first; `aria-*` only when HTML semantics are insufficient
- Screen reader: test with at least one reader (VoiceOver, NVDA)
- Motion: respect `prefers-reduced-motion` — disable animations when set
