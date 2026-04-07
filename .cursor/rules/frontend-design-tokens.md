---
description: "Frontend design tokens: colors, typography, spacing, shadows, borders, transitions — the single source of truth"
globs: ["**/*.css", "**/*.scss", "**/*.less", "**/*.html", "**/*.vue", "**/*.jsx", "**/*.tsx"]
alwaysApply: false
---
# Frontend Design Tokens

> The canonical CSS custom property definitions for all Forge frontend projects.
> Every color, size, and visual property MUST reference these tokens — hardcoded HEX/RGB/px values are forbidden.
> For layout rules see `frontend-layout.md`; for component specs see `frontend-components.md`.

## Token Naming Convention

```
--{category}-{property}-{variant}

Categories: color, space, font, radius, shadow, z, transition, size
```

## Color Tokens

### Primary Palette

```css
:root {
  --color-primary:          #4F46E5;   /* Indigo-600 — brand anchor */
  --color-primary-dark:     #3730A3;   /* Indigo-800 — hover / active */
  --color-primary-light:    #E0E7FF;   /* Indigo-100 — tinted backgrounds */
  --color-primary-contrast:  #FFFFFF;   /* Text on primary */
}
```

### Semantic Colors

```css
:root {
  --color-success:       #16A34A;
  --color-success-light: #DCFCE7;
  --color-warning:       #F59E0B;
  --color-warning-light: #FEF3C7;
  --color-danger:        #DC2626;
  --color-danger-light:  #FEE2E2;
  --color-info:          #2563EB;
  --color-info-light:    #DBEAFE;
}
```

### Neutral / Surface / Text

```css
:root {
  /* Backgrounds */
  --color-bg:            #F9FAFB;   /* Page body */
  --color-surface:       #FFFFFF;   /* Cards, panels */
  --color-surface-alt:   #F3F4F6;   /* Zebra rows, hover fill */
  --color-sidebar:       #1E293B;   /* Sidebar (dark) */
  --color-header:        #FFFFFF;   /* Top bar */

  /* Text */
  --color-text:          #111827;   /* Primary text */
  --color-text-secondary:#6B7280;   /* Descriptive text, labels */
  --color-text-muted:    #9CA3AF;   /* Placeholder, disabled */
  --color-text-inverse:  #FFFFFF;   /* Text on dark surfaces */

  /* Borders */
  --color-border:        #E5E7EB;
  --color-border-strong: #D1D5DB;
  --color-divider:       #F3F4F6;
}
```

### Dark Theme Overrides (Data Dashboards)

```css
[data-theme="dark"] {
  --color-bg:            #0F172A;
  --color-surface:       #1E293B;
  --color-surface-alt:   #334155;
  --color-text:          #F1F5F9;
  --color-text-secondary:#94A3B8;
  --color-text-muted:    #64748B;
  --color-border:        #334155;
  --color-header:        #1E293B;
}
```

## Typography Tokens

```css
:root {
  /* Font Families */
  --font-family-base:    'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  --font-family-heading: var(--font-family-base);
  --font-family-mono:    'JetBrains Mono', 'Fira Code', 'Consolas', monospace;
  --font-family-display: 'DIN Alternate', 'Oswald', var(--font-family-base); /* numbers on dashboards */

  /* Font Sizes — modular scale (1.25 ratio) */
  --font-size-xs:   0.75rem;   /* 12px */
  --font-size-sm:   0.8125rem; /* 13px */
  --font-size-base: 0.875rem;  /* 14px — admin default */
  --font-size-md:   1rem;      /* 16px — presentation default */
  --font-size-lg:   1.125rem;  /* 18px */
  --font-size-xl:   1.25rem;   /* 20px */
  --font-size-2xl:  1.5rem;    /* 24px */
  --font-size-3xl:  1.875rem;  /* 30px */
  --font-size-4xl:  2.25rem;   /* 36px */
  --font-size-5xl:  3rem;      /* 48px — hero headings */

  /* Font Weights */
  --font-weight-normal:   400;
  --font-weight-medium:   500;
  --font-weight-semibold: 600;
  --font-weight-bold:     700;

  /* Line Heights */
  --line-height-tight:    1.25;  /* headings */
  --line-height-normal:   1.5;   /* body */
  --line-height-relaxed:  1.75;  /* long-form reading */
}
```

## Spacing Scale (8px grid)

```css
:root {
  --space-0:   0;
  --space-1:   0.25rem;  /*  4px */
  --space-2:   0.5rem;   /*  8px */
  --space-3:   0.75rem;  /* 12px */
  --space-4:   1rem;     /* 16px */
  --space-5:   1.25rem;  /* 20px */
  --space-6:   1.5rem;   /* 24px */
  --space-8:   2rem;     /* 32px */
  --space-10:  2.5rem;   /* 40px */
  --space-12:  3rem;     /* 48px */
  --space-16:  4rem;     /* 64px */
  --space-20:  5rem;     /* 80px */
  --space-24:  6rem;     /* 96px */
  --space-32:  8rem;     /* 128px */
}
```

## Border Radius

```css
:root {
  --radius-sm:   4px;
  --radius-base: 6px;   /* inputs, buttons */
  --radius-md:   8px;   /* cards, panels */
  --radius-lg:   12px;  /* modals, large cards */
  --radius-xl:   16px;  /* featured sections */
  --radius-full: 9999px; /* avatars, pills */
}
```

## Shadows (Elevation Levels)

```css
:root {
  --shadow-xs:  0 1px 2px rgba(0,0,0,0.05);
  --shadow-sm:  0 1px 3px rgba(0,0,0,0.1), 0 1px 2px rgba(0,0,0,0.06);
  --shadow-md:  0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -1px rgba(0,0,0,0.06);
  --shadow-lg:  0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -2px rgba(0,0,0,0.05);
  --shadow-xl:  0 20px 25px -5px rgba(0,0,0,0.1), 0 10px 10px -5px rgba(0,0,0,0.04);
  --shadow-glow: 0 0 20px rgba(79,70,229,0.15);  /* data dashboard accent glow */
}
```

## Z-Index Scale

```css
:root {
  --z-base:      0;
  --z-dropdown:  100;
  --z-sticky:    200;
  --z-fixed:     300;   /* sidebar, header */
  --z-overlay:   400;   /* backdrop */
  --z-modal:     500;
  --z-popover:   600;
  --z-toast:     700;
  --z-tooltip:   800;
}
```

## Transition Tokens

```css
:root {
  --transition-fast:    150ms ease;
  --transition-base:    200ms ease;
  --transition-slow:    300ms ease;
  --transition-layout:  350ms cubic-bezier(0.4, 0, 0.2, 1);
}
```

## Dimension Tokens

```css
:root {
  /* Layout widths */
  --size-sidebar:          240px;
  --size-sidebar-collapsed: 64px;
  --size-header:            64px;
  --size-content-max:      1200px;
  --size-prose-max:         680px;
  --size-content-padding:   var(--space-6);  /* 24px */

  /* Touch targets */
  --size-touch-min:         44px;
  --size-input-height:      36px;
  --size-input-height-lg:   44px;
  --size-button-height:     36px;
  --size-button-height-lg:  44px;
}
```

## Breakpoints (reference — use in media queries)

```
--bp-sm:   640px     /* Mobile landscape */
--bp-md:   768px     /* Tablet portrait */
--bp-lg:  1024px     /* Tablet landscape / small desktop */
--bp-xl:  1280px     /* Desktop */
--bp-2xl: 1536px     /* Large desktop */
```

## Enforcement Rules

1. **No raw values**: every color, spacing, radius, shadow MUST use a token variable.
2. **Project override**: projects MAY reassign token values in a project-level `:root {}` block — but MUST NOT rename or remove tokens.
3. **Dark theme**: use `[data-theme="dark"]` selector — never create separate stylesheets per theme.
4. **New tokens**: add to this file first, then reference — never inline one-off `--custom-xyz` variables in component CSS.
