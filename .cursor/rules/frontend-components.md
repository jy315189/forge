---
description: "Frontend component specifications: stat cards, tables, forms, navigation, modals, feedback, empty states"
globs: ["**/*.html", "**/*.vue", "**/*.jsx", "**/*.tsx", "**/*.css", "**/*.scss"]
alwaysApply: false
---
# Frontend Component Specifications

> Defines the structure, dimensions, states, and behavior of every reusable UI component.
> All values MUST reference tokens from `frontend-design-tokens.md`.
> For page-level layout see `frontend-layout.md`; for engineering patterns see `frontend-engineering.md`.

---

## 1. Stat Cards (KPI Cards)

Used in admin dashboards and data overview sections.

### Structure

```
.stat-card
├── .stat-card__icon      (icon in tinted circle)
├── .stat-card__body
│   ├── .stat-card__label (metric name)
│   └── .stat-card__value (metric number)
└── .stat-card__trend     (change indicator)
```

### Specs

| Part | Spec |
|------|------|
| Container | Background: `var(--color-surface)`. Padding: `var(--space-5)`. Border-radius: `var(--radius-md)`. Shadow: `var(--shadow-sm)`. |
| Icon | 40×40px circle with 10%-opacity tinted background matching the metric's semantic color. Icon size: 20px. |
| Label | `var(--font-size-sm)`, `var(--color-text-secondary)`, `var(--font-weight-normal)`. Margin-bottom: `var(--space-1)`. |
| Value | `var(--font-size-2xl)`, `var(--color-text)`, `var(--font-weight-bold)`. `var(--font-family-display)` for pure numbers. |
| Trend | `var(--font-size-xs)`. Up arrow + green (`var(--color-success)`), down arrow + red (`var(--color-danger)`). Format: `↑ 12.5%` or `↓ 3.2%`. |
| Hover | `transform: translateY(-2px)`. Shadow: `var(--shadow-md)`. Transition: `var(--transition-base)`. |
| Grid | Stat cards always appear in a row: 4 columns (desktop), 2 columns (tablet), 1 column (mobile). Gap: `var(--space-6)`. |

---

## 2. Data Tables

Used in admin list pages for CRUD data display.

### Structure

```
.table-container
├── .toolbar
│   ├── .toolbar__left   (search input, filter chips)
│   └── .toolbar__right  (action buttons: Export, New)
├── table.data-table
│   ├── thead  (sticky, shaded header)
│   └── tbody  (data rows)
└── .pagination
    ├── .pagination__info   ("Showing 1-20 of 156")
    └── .pagination__controls (page numbers + prev/next)
```

### Specs

| Part | Spec |
|------|------|
| `.toolbar` | Padding: `var(--space-4)` vertical. Border-bottom: 1px `var(--color-border)`. Search input min-width: 240px. Action buttons: secondary style, small size. |
| `thead` | Background: `var(--color-surface-alt)`. Font: `var(--font-size-xs)`, `var(--font-weight-semibold)`, `var(--color-text-secondary)`, uppercase, `letter-spacing: 0.05em`. `position: sticky; top: 0`. |
| `tbody tr` | Height: 48-56px. Border-bottom: 1px `var(--color-divider)`. Hover: background `var(--color-surface-alt)`. Transition: `var(--transition-fast)`. |
| Cell padding | Horizontal: `var(--space-4)`. Vertical: `var(--space-3)`. |
| Status column | Use `.badge` component (see below). |
| Actions column | Icon buttons (edit, delete, more) aligned right. Delete = `var(--color-danger)`. |
| `.pagination` | Padding: `var(--space-4)`. Border-top: 1px `var(--color-border)`. Info text: `var(--font-size-sm)`, `var(--color-text-secondary)`. Page buttons: 32×32px, border-radius `var(--radius-base)`. Active page: `var(--color-primary)` background, white text. |
| Loading | Overlay with skeleton rows (3-5 rows) pulsing. Never show spinner on table body. |
| Empty | Show `.empty-state` component (see below) centered in table body area. |
| Sortable | Header cell with sort icon (▲▼). Active sort: `var(--color-primary)`, single direction arrow. |

---

## 3. Forms

Used in create/edit pages, settings, and dialogs.

### Structure

```
.form-container
├── .form-section          (logical grouping)
│   ├── .form-section__title
│   └── .form-row          (grid row: 1-3 columns)
│       └── .form-group
│           ├── label      (with optional * for required)
│           ├── input/select/textarea
│           └── .form-hint / .form-error
└── .form-actions          (sticky bottom bar)
    ├── button.secondary   (Cancel)
    └── button.primary     (Submit)
```

### Specs

| Part | Spec |
|------|------|
| `.form-section` | Margin-bottom: `var(--space-8)`. Title: `var(--font-size-lg)`, `var(--font-weight-semibold)`. Border-bottom below title: 1px `var(--color-border)`, padding-bottom `var(--space-3)`. |
| `.form-row` | CSS Grid: `grid-template-columns: repeat(auto-fit, minmax(280px, 1fr))`. Gap: `var(--space-6)` horizontal, `var(--space-5)` vertical. |
| `label` | `var(--font-size-sm)`, `var(--font-weight-medium)`, `var(--color-text)`. Margin-bottom: `var(--space-1)`. Required marker: `*` in `var(--color-danger)`, inline after label text. |
| `input` | Height: `var(--size-input-height)`. Border: 1px `var(--color-border)`. Border-radius: `var(--radius-base)`. Padding: `0 var(--space-3)`. Focus: border `var(--color-primary)`, ring `0 0 0 3px var(--color-primary-light)`. |
| `textarea` | Min-height: 120px. Resize: vertical only. Same border/focus styles as input. |
| `.form-hint` | `var(--font-size-xs)`, `var(--color-text-muted)`. Margin-top: `var(--space-1)`. |
| `.form-error` | `var(--font-size-xs)`, `var(--color-danger)`. Input border changes to `var(--color-danger)`. Background tint: `var(--color-danger-light)`. |
| `.form-actions` | Margin-top: `var(--space-8)`. Padding-top: `var(--space-6)`. Border-top: 1px `var(--color-border)`. Buttons right-aligned. Gap: `var(--space-3)`. On long forms: `position: sticky; bottom: 0` with `var(--color-surface)` background + `var(--shadow-md)` upward. |
| Disabled | Opacity: 0.5. Cursor: `not-allowed`. Do NOT remove from DOM. |

---

## 4. Buttons

### Variants

| Variant | Background | Text | Border |
|---------|-----------|------|--------|
| Primary | `var(--color-primary)` | `var(--color-primary-contrast)` | none |
| Secondary | transparent | `var(--color-text)` | 1px `var(--color-border)` |
| Ghost | transparent | `var(--color-primary)` | none |
| Danger | `var(--color-danger)` | `#FFFFFF` | none |

### States (all variants)

- Hover: darken background 10% or add background tint for ghost.
- Active: darken further, scale `0.98`.
- Focus: `box-shadow: 0 0 0 3px var(--color-primary-light)`. Visible ring always.
- Disabled: opacity 0.5, `pointer-events: none`.
- Loading: replace text with inline spinner (16px), button width fixed to prevent layout shift.

### Sizes

| Size | Height | Font | Padding |
|------|--------|------|---------|
| Small | 28px | `var(--font-size-xs)` | `0 var(--space-3)` |
| Default | `var(--size-button-height)` (36px) | `var(--font-size-sm)` | `0 var(--space-4)` |
| Large | `var(--size-button-height-lg)` (44px) | `var(--font-size-base)` | `0 var(--space-6)` |

---

## 5. Badges / Status Tags

```css
.badge {
  display: inline-flex;
  align-items: center;
  padding: var(--space-1) var(--space-2);
  font-size: var(--font-size-xs);
  font-weight: var(--font-weight-medium);
  border-radius: var(--radius-full);
  /* Color set by variant class */
}
```

| Variant | Background | Text |
|---------|-----------|------|
| `.badge--success` | `var(--color-success-light)` | `var(--color-success)` |
| `.badge--warning` | `var(--color-warning-light)` | `var(--color-warning)` |
| `.badge--danger` | `var(--color-danger-light)` | `var(--color-danger)` |
| `.badge--info` | `var(--color-info-light)` | `var(--color-info)` |
| `.badge--neutral` | `var(--color-surface-alt)` | `var(--color-text-secondary)` |

Optional dot indicator: 6px circle before text, filled with the text color.

---

## 6. Modals / Dialogs

### Specs

| Part | Spec |
|------|------|
| Backdrop | Background: `rgba(0,0,0,0.5)`. Z-index: `var(--z-overlay)`. Click to close (unless `.modal--persistent`). |
| Panel | Z-index: `var(--z-modal)`. Background: `var(--color-surface)`. Border-radius: `var(--radius-lg)`. Shadow: `var(--shadow-xl)`. Max-width: 520px (default), 720px (wide), 960px (full). Max-height: 85vh. |
| Header | Padding: `var(--space-6)`. Title: `var(--font-size-lg)`, `var(--font-weight-semibold)`. Close button (X): top-right, 32×32px. |
| Body | Padding: `0 var(--space-6) var(--space-6)`. Scrollable if content overflows. |
| Footer | Padding: `var(--space-4) var(--space-6)`. Border-top: 1px `var(--color-border)`. Buttons right-aligned. |
| Animation | Fade-in backdrop + scale-up panel from 0.95 → 1.0. Duration: `var(--transition-base)`. |
| Focus trap | Tab key must cycle within modal. Escape closes unless persistent. |

### Confirmation Dialog (Destructive Actions)

- Title: clear action statement ("Delete this record?")
- Body: consequence description ("This action cannot be undone. All associated data will be permanently removed.")
- Cancel button: secondary. Confirm button: danger variant with explicit verb ("Delete", not "OK").

---

## 7. Toast / Notifications

| Part | Spec |
|------|------|
| Position | Top-right, offset: `var(--space-6)` from edges. Stack vertically with `var(--space-2)` gap. |
| Container | Min-width: 320px, max-width: 420px. Background: `var(--color-surface)`. Border-radius: `var(--radius-md)`. Shadow: `var(--shadow-lg)`. Left border: 4px solid semantic color. |
| Content | Icon (20px) + message text (`var(--font-size-sm)`) + optional close button. |
| Duration | Info/Success: auto-dismiss after 4s. Warning: 6s. Error: manual close only (persist). |
| Animation | Slide-in from right + fade. Exit: slide-out right. |
| Z-index | `var(--z-toast)`. |

---

## 8. Empty State

Displayed whenever a list, table, or content area has zero items.

| Part | Spec |
|------|------|
| Container | Centered (flex column, align-items center). Padding: `var(--space-12)` vertical. |
| Illustration | Optional SVG/icon, max 160×160px, muted colors (`var(--color-text-muted)` at 40% opacity). |
| Title | `var(--font-size-lg)`, `var(--font-weight-medium)`, `var(--color-text)`. E.g. "No records found". |
| Description | `var(--font-size-sm)`, `var(--color-text-secondary)`. E.g. "Try adjusting your filters or create a new entry." |
| Action | Optional primary button ("Create New") or text link. |

---

## 9. Loading States

| Context | Pattern |
|---------|---------|
| Page load | Full-page skeleton: gray rectangles pulsing at content positions. Match actual layout shape. |
| Table data | Skeleton rows: 5 rows with pulsing gray bars matching column widths. |
| Button submit | Inline spinner replaces button text, button width locked. |
| Card content | Skeleton matching card internals (title bar, value block, chart placeholder). |
| Overlay | Semi-transparent overlay on existing content with centered spinner. Used for in-place refresh. |
| Rule | NEVER show a blank screen. Every async boundary must have a loading representation. |

Skeleton pulse animation: `background-color` oscillating between `var(--color-surface-alt)` and `var(--color-border)`, duration: 1.5s, ease-in-out, infinite.

---

## 10. Tabs / Segmented Navigation

| Part | Spec |
|------|------|
| Container | Border-bottom: 2px `var(--color-border)`. |
| Tab item | Padding: `var(--space-3) var(--space-4)`. Font: `var(--font-size-sm)`, `var(--font-weight-medium)`. Color: `var(--color-text-secondary)`. Cursor: pointer. |
| Active | Color: `var(--color-primary)`. Border-bottom: 2px `var(--color-primary)` (overlapping container border). `var(--font-weight-semibold)`. |
| Hover | Color: `var(--color-text)`. |
| Disabled | Opacity: 0.4. Cursor: `not-allowed`. |
| Badge on tab | Small count badge after text (e.g. "Pending (3)"). Use `.badge--neutral`. |

---

## AI Code Generation Checklist

When generating any frontend page or component, verify EVERY item before outputting code:

### Layout Check
- [ ] Page uses a defined layout template from `frontend-layout.md` (admin / dashboard / presentation / auth / error)
- [ ] Content wrapped in correct container hierarchy (`.app-container` → `.main-content` → `.content` → `.card`)
- [ ] Responsive behavior defined for all three breakpoints (mobile / tablet / desktop)

### Token Check
- [ ] Zero hardcoded HEX/RGB color values — all reference `var(--color-*)`
- [ ] Zero hardcoded px spacing — all reference `var(--space-*)` or `var(--size-*)`
- [ ] Border-radius uses `var(--radius-*)`
- [ ] Shadows use `var(--shadow-*)`
- [ ] Font sizes use `var(--font-size-*)`

### Component Check
- [ ] Tables include `.toolbar` (search + actions) and `.pagination` (count + page controls)
- [ ] Forms include validation states (required marker, error message, error border)
- [ ] Buttons have all states defined (hover, active, focus ring, disabled, loading)
- [ ] Stat cards include icon, label, value, and trend indicator

### Interaction Check
- [ ] API requests show loading state (skeleton or overlay) during fetch
- [ ] API errors caught and displayed via toast (`var(--color-danger)` border)
- [ ] API success confirmed via toast (`var(--color-success)` border)
- [ ] Destructive actions trigger confirmation modal with explicit consequence text
- [ ] Empty data states show `.empty-state` component with action button

### Accessibility Check
- [ ] All form inputs have associated `<label>` elements
- [ ] Interactive elements have visible focus indicators
- [ ] Modals trap focus and close on Escape
- [ ] Images have meaningful `alt` text
- [ ] Color is not the sole indicator of status (icons or text accompany color)
