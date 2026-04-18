# Design System Specification: The Glacial Archive

## 1. Overview & Creative North Star
The design system for Saiyutong is defined by the Creative North Star: **"The Crystalline Lab."** 

We are moving away from the "boxy" nature of traditional educational platforms. Instead, we treat the interface as a high-end digital gallery—ethereal, breathable, and intellectually stimulating. This system breaks the template look through **intentional asymmetry**, where content isn't just placed on a grid but "floats" within a luminous, ice-blue atmosphere. We utilize overlapping translucent layers and dramatic typographic scales to create a sense of professional authority mixed with innovative accessibility.

## 2. Colors & Tonal Architecture
The palette is rooted in the interplay between crisp ice-blues and deep oceanic tones, mimicking the clarity of a glacier.

### The "No-Line" Rule
**Explicit Instruction:** Prohibit the use of 1px solid borders for sectioning content. Boundaries must be defined solely through background color shifts. To separate a sidebar from a main feed, use a transition from `surface` (#f7f9fb) to `surface-container-low` (#f2f4f6). 

### Surface Hierarchy & Nesting
Treat the UI as physical layers of frosted glass. 
*   **Base:** `surface` (#f7f9fb)
*   **Secondary Sections:** `surface-container-low` (#f2f4f6)
*   **Primary Content Cards:** `surface-container-lowest` (#ffffff)
*   **Active/Floating Elements:** `primary-container` (#7dd3fc) at 40% opacity with a 20px backdrop-blur.

### The "Glass & Gradient" Rule
To avoid a "flat" appearance, main CTAs and Hero sections must utilize a **Signature Texture**. Apply a subtle linear gradient (135°) from `primary` (#006686) to `primary-container` (#7dd3fc). This provides a visual "soul" and depth that static hex codes cannot achieve.

## 3. Typography: Editorial Authority
The typography scale is designed to feel like a modern academic journal—clean, legible, and prestigious.

*   **Primary Typeface:** Inter (Latin) paired with PingFang SC or Noto Sans SC (Simplified Chinese).
*   **Display Scales (`display-lg` to `display-sm`):** Reserved for high-impact educational milestones and hero headlines. Use `on-surface` (#191c1e) with tight letter-spacing (-0.02em).
*   **Body & Labels:** Use `body-md` (#0.875rem) for general content. For secondary metadata, use `on-surface-variant` (#3f484e) to create a clear visual hierarchy without needing bold weights.

The hierarchy communicates the brand’s innovative nature: **Large, light headlines** for vision, and **highly legible, structured body text** for learning.

## 4. Elevation & Depth: Tonal Layering
We do not use shadows to create "pop"; we use light and transparency to create "presence."

*   **The Layering Principle:** Depth is achieved by stacking. Place a `surface-container-lowest` (#ffffff) card on top of a `surface-container-low` (#f2f4f6) background. The subtle shift in hex value creates a natural lift.
*   **Ambient Shadows:** For floating modals or dropdowns, use an ultra-diffused shadow: `box-shadow: 0 12px 40px rgba(0, 102, 134, 0.06);`. The shadow must be tinted with the `primary` hue to mimic the way light passes through ice.
*   **The "Ghost Border" Fallback:** If a container requires a boundary for accessibility, use the `outline-variant` (#bec8ce) at **15% opacity**. Never use 100% opaque lines.
*   **Backdrop Blur:** All overlays (Modals, Navigation Bars) must use a minimum of `16px` backdrop-blur with a background color of `surface-container-lowest` at 70% opacity.

## 5. Component Logic

### Buttons & Interaction
*   **Primary:** Pill-shaped (`rounded-full`). Gradient fill from `primary` to `primary_fixed_dim`. White text. No shadow.
*   **Secondary:** `surface-container-high` background with `on-primary-container` text. 
*   **State Change:** On hover, increase the background opacity or shift the gradient slightly—never use a dark "overlay" state.

### Input Fields & Search
*   **Styling:** Use `surface-container-lowest` as the fill. 
*   **Active State:** Instead of a thick border, use a 2px glow using the `primary-container` color at 50% opacity.
*   **Typography:** Labels should be `label-md` in `on-surface-variant`.

### Cards & Content Modules
*   **Prohibition:** Forbid divider lines within cards. 
*   **Solution:** Use vertical whitespace (1.5rem to 2rem) and `title-sm` headers to separate content sections. 
*   **Educational Snippets:** Use a `primary-fixed` (#c0e8ff) vertical accent bar (4px wide) on the left side of a card to denote "Featured" or "New" content.

### Glassmorphic Chips
*   Used for categories (e.g., "AI Technology," "Pedagogy"). 
*   Background: `primary-container` at 20% opacity. 
*   Text: `on-primary-container`.
*   Shape: `rounded-md`.

## 6. Do’s and Don’ts

### Do:
*   **Embrace Negative Space:** Allow at least 24px of padding between content blocks. Space is a luxury in this design system.
*   **Use Subtle Motion:** Elements should "fade and slide" (200ms Ease-Out) rather than snap into place.
*   **Chinese Readability:** Ensure a line-height of 1.6 to 1.8 for Chinese body text to maintain the "Ethereal" feel.

### Don’t:
*   **No Pure Black:** Never use #000000. Use `on-surface` (#191c1e) for all high-contrast text.
*   **No Hard Shadows:** Avoid the standard "Material Design" shadows. If the shadow is visible as a "grey smudge," it is too heavy.
*   **No Sharp Corners:** Avoid `none` or `sm` roundedness for primary containers. Stick to `md` (0.75rem) or `lg` (1rem) to maintain the "approachable" personality.