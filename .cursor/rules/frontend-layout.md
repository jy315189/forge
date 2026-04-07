---
description: "Frontend page layouts: admin console, data dashboard, presentation pages, auth, error pages"
globs: ["**/*.html", "**/*.vue", "**/*.jsx", "**/*.tsx", "**/*.css", "**/*.scss"]
alwaysApply: false
---
# Frontend Layout Architecture

> Defines structural templates for every page type in Forge projects.
> All dimensions, colors, and spacing MUST reference tokens from `frontend-design-tokens.md`.
> For component-level specs see `frontend-components.md`.

---

## 1. Admin Console (B-End Management)

The primary layout for all back-office / management platforms.

### Structure

```
┌─────────────────────────────────────────────────┐
│ .app-container                                  │
│ ┌──────────┬────────────────────────────────────┐│
│ │          │  .header  (h: 64px, z: fixed)     ││
│ │          ├────────────────────────────────────┤│
│ │ .sidebar │  .main-content                    ││
│ │ (w:240px)│    .breadcrumb                    ││
│ │          │    .page-header                   ││
│ │          │    .content  (padding: 24px)      ││
│ │          │      .card / .card-group          ││
│ │          │      ...                          ││
│ └──────────┴────────────────────────────────────┘│
└─────────────────────────────────────────────────┘
```

### Rules

| Element | Spec |
|---------|------|
| `.sidebar` | Width: `var(--size-sidebar)` (240px), collapsed: `var(--size-sidebar-collapsed)` (64px). Background: `var(--color-sidebar)`. Transition: `var(--transition-layout)`. Contains logo (h:64px aligned with header), nav menu, collapse toggle at bottom. |
| `.header` | Height: `var(--size-header)` (64px). Background: `var(--color-header)`. Border-bottom: 1px `var(--color-border)`. Left: collapse toggle + breadcrumb/page title. Right: global search, notifications badge, user avatar dropdown. Z-index: `var(--z-fixed)`. |
| `.main-content` | `margin-left` matches sidebar width. `min-height: 100vh`. Background: `var(--color-bg)`. |
| `.breadcrumb` | Font: `var(--font-size-sm)`. Color: `var(--color-text-secondary)`. Separator: `/` or `>`. |
| `.page-header` | Contains h1 title (`var(--font-size-xl)`, `var(--font-weight-semibold)`) + optional subtitle + right-aligned action buttons. Margin-bottom: `var(--space-6)`. |
| `.content` | Padding: `var(--space-6)`. All data and form sections wrapped in `.card`. |
| `.card` | Background: `var(--color-surface)`. Border-radius: `var(--radius-md)`. Shadow: `var(--shadow-sm)`. Padding: `var(--space-6)`. Margin-bottom: `var(--space-6)`. Optional `.card-header` (border-bottom, title + actions). |

### Sidebar Navigation

- Active menu item: left accent border (3px `var(--color-primary)`) + tinted background (`var(--color-primary-light)` at 10% opacity).
- Sub-menu: indented 16px, revealed with slide-down animation `var(--transition-base)`.
- Icons: 20px, aligned left; text hidden when collapsed; tooltip on hover when collapsed.
- Collapsed state: icons centered at 64px width, text hidden, sub-menus become popovers.

### Responsive (< 1024px)

- Sidebar becomes overlay drawer (z: `var(--z-overlay)`), with backdrop.
- Header hamburger menu toggles drawer.
- `.content` padding reduces to `var(--space-4)`.

---

## 2. Data Dashboard (Full-Screen Display)

For monitoring dashboards, big-screen data visualization, command centers.

### Structure

```
┌─────────────────────────────────────────────────┐
│ .dashboard-container  [data-theme="dark"]       │
│ ┌───────────────────────────────────────────────┐│
│ │ .dashboard-header  (h: 56px)                 ││
│ │   Logo | Title | Date/Time | Status          ││
│ ├───────────────────────────────────────────────┤│
│ │ .dashboard-grid                              ││
│ │ ┌─────────┬─────────┬─────────┬─────────┐   ││
│ │ │ KPI-1   │ KPI-2   │ KPI-3   │ KPI-4   │   ││
│ │ ├─────────┴────┬────┴─────────┴─────────┤   ││
│ │ │  Chart (lg)  │     Chart (lg)         │   ││
│ │ ├──────────────┼────────────┬────────────┤   ││
│ │ │  Table/List  │  Map/Geo   │  Alerts   │   ││
│ │ └──────────────┴────────────┴────────────┘   ││
│ └───────────────────────────────────────────────┘│
└─────────────────────────────────────────────────┘
```

### Rules

| Element | Spec |
|---------|------|
| Container | `data-theme="dark"` on root. Full viewport (`100vw × 100vh`), `overflow: hidden`. Background: `var(--color-bg)`. |
| Header | Height: 56px. Transparent or `var(--color-surface)` at 80% opacity + `backdrop-filter: blur(12px)`. Slim, non-intrusive. |
| Grid | CSS Grid with `gap: var(--space-3)`. Padding: `var(--space-3)`. Cells fill remaining viewport height (`1fr`). |
| Panel/Cell | Background: `var(--color-surface)`. Border: 1px `var(--color-border)` or subtle glow (`var(--shadow-glow)`). Border-radius: `var(--radius-md)`. Padding: `var(--space-4)`. |
| Typography | Numbers: `var(--font-family-display)`, `var(--font-weight-bold)`. Labels: `var(--font-size-xs)`, `var(--color-text-secondary)`. |
| Charts | Must respect dark theme palette. Grid lines: `var(--color-border)` at 50% opacity. Tooltips: `var(--color-surface)` with `var(--shadow-lg)`. |
| Auto-refresh | Data polling interval displayed in header. Last-updated timestamp always visible. |

### Visual Effects (Dashboard Only)

- Subtle gradient borders on featured panels: `border-image: linear-gradient(...)`.
- KPI cards may use accent glow on value change (`var(--shadow-glow)` with animation).
- Animated number transitions via `counter` or JS tween (duration ≤ 800ms).
- Reduce motion: respect `prefers-reduced-motion` — disable all animations.

---

## 3. Presentation / Marketing Pages (C-End)

For product showcases, landing pages, feature introductions, corporate websites.

### Structure

```
┌─────────────────────────────────────────────────┐
│ .page-container                                 │
│ ┌───────────────────────────────────────────────┐│
│ │ .nav-bar  (h: 72px, sticky, backdrop-blur)   ││
│ │   Logo | Nav Links | CTA Button              ││
│ ├───────────────────────────────────────────────┤│
│ │ .hero-section  (full-width, min-h: 80vh)     ││
│ │   Headline | Sub-headline | CTA | Visual     ││
│ ├───────────────────────────────────────────────┤│
│ │ .section  (max-w: 1200px, centered)          ││
│ │   Section heading | Content grid             ││
│ ├───────────────────────────────────────────────┤│
│ │ .section.alt-bg  (full-width tinted bg)      ││
│ │   ...                                        ││
│ ├───────────────────────────────────────────────┤│
│ │ .cta-section  (centered, prominent)          ││
│ ├───────────────────────────────────────────────┤│
│ │ .footer  (full-width, dark)                  ││
│ │   Columns: links | contact | social | legal  ││
│ └───────────────────────────────────────────────┘│
└─────────────────────────────────────────────────┘
```

### Rules

| Element | Spec |
|---------|------|
| `.nav-bar` | Height: 72px. `position: sticky; top: 0`. Background: `rgba(255,255,255,0.85)` + `backdrop-filter: blur(12px)`. Z-index: `var(--z-sticky)`. Inner content `max-width: var(--size-content-max)`, centered. |
| `.hero-section` | Full viewport width. Min-height: 80vh. Generous padding (`var(--space-24)` vertical). Heading: `var(--font-size-5xl)`, `var(--font-weight-bold)`, `var(--line-height-tight)`. Sub-heading: `var(--font-size-lg)`, `var(--color-text-secondary)`. |
| `.section` | `max-width: var(--size-content-max)`. `margin: 0 auto`. Vertical padding: `var(--space-16)` to `var(--space-24)`. Alternate sections use `.alt-bg` with `var(--color-surface-alt)` full-width background. |
| Section gap | Adjacent `.section` blocks maintain `var(--space-16)` minimum vertical separation. |
| `.footer` | Background: `var(--color-sidebar)` (dark). Text: `var(--color-text-inverse)`. Padding: `var(--space-12)` vertical. Multi-column grid (4 columns desktop, 2 tablet, 1 mobile). |
| CTA Buttons | Primary: large size (`var(--size-button-height-lg)`), `var(--radius-base)`, strong shadow. Always high contrast against background. |
| Images | `object-fit: cover`. Lazy-loaded (`loading="lazy"`). Responsive `srcset` when possible. Rounded: `var(--radius-lg)` or `var(--radius-xl)`. |

### Typography Rules (Presentation)

- Body font size: `var(--font-size-md)` (16px) — larger than admin pages.
- Paragraph max-width: `var(--size-prose-max)` (680px) for comfortable reading.
- Heading scale: h1 = `var(--font-size-5xl)`, h2 = `var(--font-size-3xl)`, h3 = `var(--font-size-xl)`.
- Letter-spacing on large headings: `-0.02em`.

---

## 4. Authentication Pages (Login / Register / Reset)

### Structure

```
┌─────────────────────────────────────────────────┐
│ .auth-page  (full viewport, centered)           │
│ ┌──────────────────┬────────────────────────────┐│
│ │  .auth-branding  │  .auth-form-panel          ││
│ │  (illustration   │  ┌────────────────────┐    ││
│ │   or gradient)   │  │ Logo               │    ││
│ │                  │  │ Title              │    ││
│ │                  │  │ Form fields        │    ││
│ │                  │  │ Submit button      │    ││
│ │                  │  │ Alt links          │    ││
│ │                  │  └────────────────────┘    ││
│ └──────────────────┴────────────────────────────┘│
└─────────────────────────────────────────────────┘
```

### Rules

| Element | Spec |
|---------|------|
| Layout | Two-column split: left branding (55%), right form (45%). Mobile: single column, branding hidden or collapsed to logo-only header. |
| `.auth-branding` | Full height. Background: gradient using `var(--color-primary)` → `var(--color-primary-dark)`, or brand illustration. |
| `.auth-form-panel` | Background: `var(--color-surface)`. Vertically centered content. Max-width: 420px inner form area. Padding: `var(--space-10)`. |
| Form | Single column. Input height: `var(--size-input-height-lg)`. Submit button: full width, `var(--color-primary)`, `var(--size-button-height-lg)`. |
| Links | "Forgot password", "Register" links below form, `var(--font-size-sm)`, `var(--color-primary)`. |

---

## 5. Error Pages (404 / 403 / 500)

### Rules

| Element | Spec |
|---------|------|
| Layout | Full viewport centered (flexbox). Background: `var(--color-bg)`. |
| Error code | `var(--font-size-5xl)` or larger, `var(--font-weight-bold)`, `var(--color-text-muted)`. |
| Message | `var(--font-size-lg)`, `var(--color-text-secondary)`. Brief, human-friendly ("The page you're looking for doesn't exist"). |
| Action | "Back to Home" primary button + optional "Contact Support" text link. |
| Illustration | Optional SVG illustration above error code. Style must match brand. Max-width: 320px. |

---

## Cross-Page Consistency Rules

1. **Header height is ALWAYS 64px** (admin) or 72px (presentation) — never arbitrary.
2. **Content container** always has `max-width` + `margin: 0 auto` — content never touches viewport edge on desktop.
3. **Background layering**: page `var(--color-bg)` → card `var(--color-surface)` → nested element `var(--color-surface-alt)`. Never skip a layer.
4. **Scroll behavior**: `scroll-behavior: smooth` globally. Fixed header must not overlap anchored scroll targets (`scroll-margin-top` = header height + 16px).
5. **Print styles**: admin pages must hide sidebar/header and expand content to full width on `@media print`.
