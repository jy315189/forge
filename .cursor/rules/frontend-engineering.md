---
description: "Frontend engineering: components, state, performance, CSS architecture, bundling"
globs: ["**/*.tsx", "**/*.jsx", "**/*.vue", "**/*.svelte", "**/*.css", "**/*.scss", "**/*.html"]
alwaysApply: false
---
# Frontend Engineering

> Supplements typescript-* rules with framework-agnostic frontend patterns.
> For visual design (colors, typography, layout), see `common-design-system.md`.

## Component Architecture

- **Atomic Design**: atoms → molecules → organisms → templates → pages
- Keep components ≤ 200 lines — split if larger
- Separate concerns: container (data/logic) vs. presentational (UI)
- Co-locate: component + styles + tests + types in same directory

```
Button/
├── Button.tsx        # Component
├── Button.styles.ts  # Styles (or .module.css)
├── Button.test.tsx   # Tests
├── Button.types.ts   # Types (if complex)
└── index.ts          # Public export
```

## State Management

| Scope | Solution | Example |
|-------|----------|---------|
| Local UI | `useState` / component state | Toggle, form input |
| Shared UI | Context / Zustand / Jotai | Theme, sidebar state |
| Server data | React Query / SWR / Apollo | API responses, cache |
| URL state | URL params / search params | Filters, pagination |
| Form | React Hook Form / Formik | Complex forms |

**Rule**: Don't put server data in client state stores. Use a data-fetching library.

## Performance Checklist

- [ ] **Code splitting**: lazy-load routes and heavy components
- [ ] **Image optimization**: WebP/AVIF, responsive `srcset`, lazy loading
- [ ] **Bundle analysis**: run `webpack-bundle-analyzer` or equivalent regularly
- [ ] **Core Web Vitals**: LCP < 2.5s, FID < 100ms, CLS < 0.1
- [ ] **Memoization**: `React.memo`, `useMemo`, `useCallback` — only when measured
- [ ] **Virtual lists**: use virtualization for lists > 100 items

## CSS Architecture

- **CSS Modules** or **Tailwind CSS** — avoid global CSS
- If using Tailwind: extract repeated patterns into `@apply` components
- If using CSS-in-JS: prefer zero-runtime solutions (vanilla-extract, Panda CSS)
- Mobile-first media queries: `min-width` breakpoints
- Use CSS custom properties for theming (not Sass variables)

## Form Patterns

- Client-side validation for UX, server-side validation for security
- Show errors inline next to the field, not in a banner
- Disable submit button during request, show loading state
- Preserve user input on validation failure — never clear the form
- Auto-focus first error field after failed submission

## Error Boundaries

- Wrap route-level components with error boundaries
- Show user-friendly fallback UI, not blank screens
- Log errors to monitoring service (Sentry, etc.)
- Provide "Try Again" action in error fallback

## Accessibility (extends design-system)

- All interactive elements reachable via keyboard
- `aria-live` for dynamic content updates (toasts, form errors)
- Skip-to-content link as first focusable element
- Test with keyboard-only navigation before shipping
