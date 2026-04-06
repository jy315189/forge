---
description: "Project design standard: warm color system, typography, components, shadows, responsive. Apply to all frontend."
globs: ["**/*.tsx", "**/*.jsx", "**/*.vue", "**/*.svelte", "**/*.html", "**/*.css", "**/*.scss"]
alwaysApply: false
---
# Frontend Design Standard — Warm Design System

> This is the project-level visual design standard. ALL frontend implementations MUST follow these specifications.
> For generic UI/UX principles (grid, a11y, interaction states), see `common-design-system.md`.

## 1. Visual Identity

A warm, bold design language that trades the typical blue-screen tech aesthetic for golden amber, burnt orange, and the feeling of late-afternoon sunlight. Every surface glows with warmth.

**Core Characteristics:**
- Golden-amber color universe: every tone from pale cream to burnt orange
- Massive display typography (82px) with aggressive negative letter-spacing
- Warm golden shadow system using amber-tinted rgba values
- Near-zero border-radius — sharp, architectural geometry
- Bold, warm, declarative — confidence through simplicity

## 2. Color Palette

### Primary Brand
| Token | Hex | Usage |
|-------|-----|-------|
| `--color-brand` | `#fa520f` | Core brand color, highest-signal moments |
| `--color-brand-flame` | `#fb6424` | Hover states, secondary brand moments |
| `--color-brand-orange` | `#ff8105` | Gradient system, warm accents |

### Sunshine Scale (Accent)
| Token | Hex | Usage |
|-------|-----|-------|
| `--sunshine-900` | `#ff8a00` | Strong accent moments |
| `--sunshine-700` | `#ffa110` | Core accent for backgrounds, interactive elements |
| `--sunshine-500` | `#ffb83e` | Mid-level emphasis |
| `--sunshine-300` | `#ffd06a` | Subtle warm tints, secondary backgrounds |
| `--sunshine-100` | `#ffe295` | Soft background accents |
| `--sunshine-bright` | `#ffd900` | Brightest tone, gradient top |

### Surface & Background
| Token | Hex | Usage |
|-------|-----|-------|
| `--bg-warm-ivory` | `#fffaeb` | Page background (default) |
| `--bg-cream` | `#fff0c2` | Primary warm surface, secondary button bg |
| `--bg-white` | `#ffffff` | Maximum contrast, popover surfaces |
| `--bg-dark` | `#1f1f1f` | Dark sections, primary button bg |

### Text
| Token | Hex | Usage |
|-------|-----|-------|
| `--text-primary` | `#1f1f1f` | Primary text (NEVER use pure #000) |
| `--text-secondary` | `hsl(0, 0%, 24%)` | Secondary text on light backgrounds |
| `--text-on-dark` | `#ffffff` | Text on dark surfaces |

### Gradient System
```css
/* Signature gradient: yellow → amber → orange → burnt orange */
background: linear-gradient(
  90deg,
  #ffd900,    /* Bright Yellow */
  #ffe295,    /* Gold */
  #ffa110,    /* Amber */
  #ff8105,    /* Orange */
  #fb6424,    /* Flame */
  #fa520f     /* Brand Orange */
);
```

### Warm Shadow System
```css
/* Golden hour shadow — 5 cascading layers, amber-tinted */
box-shadow:
  rgba(127, 99, 21, 0.12) -8px 16px 39px,
  rgba(127, 99, 21, 0.10) -33px 64px 72px,
  rgba(127, 99, 21, 0.06) -73px 144px 97px,
  rgba(127, 99, 21, 0.04) -130px 256px 115px,
  rgba(127, 99, 21, 0.01) -203px 400px 126px;
```

## 3. Typography

### Font Stack
```css
font-family: 'YourBrandFont', Arial, ui-sans-serif, system-ui, sans-serif;
```

### Hierarchy (ALL weight 400 — size carries authority)

| Role | Size | Line Height | Letter Spacing | Use |
|------|------|-------------|----------------|-----|
| Display / Hero | 82px (5.13rem) | 1.00 | -2.05px | Hero headlines, billboard scale |
| Section Heading | 56px (3.5rem) | 0.95 | normal | Feature section anchors |
| Sub-heading Large | 48px (3rem) | 0.95 | normal | Secondary section titles |
| Sub-heading | 32px (2rem) | 1.15 | normal | Card headings, feature names |
| Card Title | 30px (1.88rem) | 1.20 | normal | Mid-level headings |
| Feature Title | 24px (1.5rem) | 1.33 | normal | Small headings |
| Body / Button | 16px (1rem) | 1.50 | normal | Standard body text |
| Caption / Link | 14px (0.88rem) | 1.43 | normal | Metadata, secondary links |

### Typography Rules
- **Single weight only**: weight 400 everywhere — hierarchy from size and color, never bold
- **Ultra-tight at scale**: line-heights 0.95–1.00 at display sizes for poster-like density
- **Aggressive tracking on display**: -2.05px letter-spacing at 82px
- **Uppercase as emphasis**: `text-transform: uppercase` on button labels and section markers

## 4. Components

### Buttons

| Variant | Background | Text | Padding | Use |
|---------|-----------|------|---------|-----|
| **Primary (Dark)** | `#1f1f1f` | `#ffffff` | 12px | Primary CTA |
| **Secondary (Cream)** | `#fff0c2` | `#1f1f1f` | 12px | Secondary CTA |
| **Ghost** | transparent + `oklab(0,0,0/0.1)` | `#1f1f1f` | 12px | De-emphasized |
| **Text** | transparent | `#1f1f1f` | 8px 0 0 | Tertiary navigation |

All buttons: **sharp corners (no border-radius)**, uppercase labels, weight 400.

### Cards & Containers
- Background: Warm Ivory / Cream / White
- Border: none — defined by background color difference
- Radius: **near-zero** — sharp, architectural corners
- Shadow: warm golden multi-layer (see shadow system above)
- No visible borders — containers are defined by color

### Inputs & Forms
- Border: `hsl(240, 5.9%, 90%)` (the one allowed cool tone)
- Focus: accent color ring (`--color-brand`)
- Minimal styling consistent with sparse aesthetic

### Navigation
- Transparent nav overlaying warm hero
- Dark text on light, white text on dark sections
- CTA: dark solid or cream surface button
- Minimal, wide-spaced layout

## 5. Layout

### Spacing
- Base unit: **8px**
- Scale: 2, 4, 8, 10, 12, 16, 20, 24, 32, 40, 48, 64, 80, 98, 100
- Section vertical spacing: generous (80px–100px)
- Button padding: 12px

### Grid
- Max container width: **1280px**, centered
- Card grids: 2–3 columns
- Hero: full-width with massive typography

### Whitespace
- Huge headlines surrounded by generous whitespace — billboard impact
- Empty space itself feels warm (ivory/cream backgrounds, never pure white)
- Photography as decorative whitespace

## 6. Depth & Elevation

| Level | Treatment | Use |
|-------|-----------|-----|
| Flat (0) | No shadow | Page backgrounds, text blocks |
| Golden Float (1) | 5-layer warm amber shadow | Cards, product showcases, elevated content |

Shadow layers use amber-tinted blacks (`rgba(127, 99, 21, ...)`) — NEVER cool gray shadows.

## 7. Responsive

| Breakpoint | Width | Hero Text |
|------------|-------|-----------|
| Mobile | <640px | 32px |
| Tablet | 640–768px | 48px |
| Small Desktop | 768–1024px | 56px |
| Desktop | >1024px | 82px |

- Navigation collapses to hamburger on mobile
- Multi-column → stacked on mobile
- Warm color grading maintained at all sizes
- Touch targets: 12px minimum padding on buttons

## 8. Do's and Don'ts

### DO
- Use warm color spectrum exclusively: ivory, cream, amber, gold, orange
- Display typography at 82px+ with -2.05px letter-spacing for heroes
- Use the brand gradient (yellow → amber → orange) for accent moments
- Apply warm golden shadows (amber-tinted rgba) for elevation
- Use `#1f1f1f` for text — NEVER pure `#000000`
- Keep font weight at 400 throughout
- Use sharp corners — near-zero border-radius
- Apply uppercase on button labels for formality
- Use warm photography with golden color grading

### DON'T
- Don't introduce cool colors (blue, green, purple) — palette is exclusively warm
- Don't use bold (700+) weight — 400 is the only weight
- Don't round corners — sharp geometry is intentional
- Don't use cool-toned shadows — shadows carry amber warmth
- Don't use pure white page background — always warm-tinted (`#fffaeb` minimum)
- Don't reduce hero text below 48px on desktop
- Don't add gradients outside the warm spectrum
- Don't use generic gray for text — neutrals should be warm-tinted

## 9. Agent Build Guide

### Quick Color Reference
```
Brand Orange:    #fa520f
Page Background: #fffaeb
Warm Surface:    #fff0c2
Primary Text:    #1f1f1f
Sunshine Amber:  #ffa110
Bright Gold:     #ffd900
Text on Dark:    #ffffff
```

### Component Prompts
- Hero: "Warm Ivory (#fffaeb) bg, 82px headline, weight 400, line-height 1.0, letter-spacing -2.05px, #1f1f1f text. Dark CTA (#1f1f1f bg, white text, 12px padding, sharp corners) + cream secondary (#fff0c2 bg)."
- Card: "Cream (#fff0c2) bg, sharp corners, golden shadow system. Title 32px weight 400, body 16px."
- Footer: "Dark (#1f1f1f) bg with warm gradient from #ffa110 fading to dark. White text, links 14px."

### Iteration Principles
1. Shift toward amber, never toward gray
2. Size for hierarchy: 82px → 56px → 48px → 32px → 24px → 16px
3. Never add border-radius — sharp corners only
4. Shadows are always warm golden tones
5. Font weight is always 400 — emphasis through size and color
