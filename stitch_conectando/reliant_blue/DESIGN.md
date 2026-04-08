# Design System Document: Editorial Trust & Fluid Utility

## 1. Overview & Creative North Star
### The Creative North Star: "The Architectural Curator"
Most service marketplaces feel like cluttered bulletin boards. This design system rejects the "grid of boxes" in favor of an editorial, high-end experience. We treat service providers as curated professionals, not just entries in a database.

**The Aesthetic Strategy:**
The system breaks the "template" look through **intentional asymmetry** and **tonal layering**. By moving away from rigid lines and embracing breathing room (whitespace as a functional element), we create an environment of calm and authority. We use high-contrast typography scales—pairing the structural precision of *Inter* with the expansive, premium feel of *Manrope*—to guide the user’s eye with editorial intent.

---

## 2. Colors: Tonal Depth & The "No-Line" Rule
Our palette is rooted in `primary` (#0040a1), a deep, authoritative blue that signals competence. However, the secret to a premium feel lies in our neutral execution.

### The "No-Line" Rule
**Explicit Instruction:** Designers are prohibited from using 1px solid borders to section content. Boundaries must be defined solely through background shifts.
*   **Method:** A `surface-container-low` (#f3f4f5) section sitting on a `surface` (#f8f9fa) background creates a sophisticated transition that feels architectural rather than "templated."

### Surface Hierarchy & Nesting
Treat the UI as a series of physical layers—stacked sheets of frosted glass.
*   **Base:** `background` (#f8f9fa)
*   **Nesting Level 1:** Use `surface-container` (#edeeef) for large content areas.
*   **Nesting Level 2 (The "Lift"):** Use `surface-container-lowest` (#ffffff) for interactive cards or profile modules. This creates a natural "pop" against the slightly darker container.

### The "Glass & Gradient" Rule
To avoid a flat, "out-of-the-box" look:
*   **Glassmorphism:** Use semi-transparent versions of `surface-container-lowest` with a `backdrop-blur` (16px-24px) for floating navigation bars or sticky action buttons.
*   **Signature Textures:** For main Hero CTAs, use a subtle linear gradient from `primary` (#0040a1) to `primary_container` (#0056d2). This adds "soul" and depth that a flat fill cannot achieve.

---

## 3. Typography: The Editorial Voice
We use a dual-font strategy to balance character with clarity.

*   **Display & Headlines (Manrope):** These are our "Editorial" voices. `display-lg` (3.5rem) and `headline-lg` (2rem) should be used with generous leading. They convey the brand's confidence.
*   **Titles & Body (Inter):** These are our "Functional" voices. `title-md` (1.125rem) is the workhorse for service names and professional titles. `body-md` (0.875rem) provides maximum legibility for service descriptions.

**The Hierarchy Rule:** Never let a Headline and Body share the same weight. If the headline is `Bold`, the body must be `Regular` to ensure a clear visual path.

---

## 4. Elevation & Depth
We convey hierarchy through **Tonal Layering** rather than traditional structural lines.

*   **The Layering Principle:** Place a `surface-container-lowest` card on a `surface-container-low` section. This creates a soft, natural lift without the "heaviness" of a shadow.
*   **Ambient Shadows:** When a floating effect is required (e.g., a "Book Now" floating bar), use extra-diffused shadows. 
    *   *Spec:* `Y: 8px, Blur: 24px, Color: rgba(25, 28, 29, 0.06)`. This mimics natural light.
*   **The "Ghost Border" Fallback:** If a border is essential for accessibility, use `outline_variant` (#c3c6d6) at **20% opacity**. Never use 100% opaque borders.

---

## 5. Components: Precision & Softness

### Buttons (Roundedness: `md` - 0.75rem)
*   **Primary:** `primary` fill with `on_primary` text. Use a subtle 4px vertical gradient for a "pressed" look.
*   **Secondary:** `secondary_container` fill. No border.
*   **Tertiary:** Transparent background with `primary` text. Use for low-priority actions like "View All."

### Cards & Service Lists
*   **The Divider Ban:** Do not use line dividers between list items. Use **Vertical White Space** (from the 1.5rem `xl` scale) or a 2px gap between `surface-container-lowest` tiles to create separation.
*   **Service Card:** A `surface-container-lowest` background with a `lg` (1rem) corner radius. Imagery should be slightly inset to create a "framed" gallery feel.

### Input Fields
*   **Style:** Use `surface-container-high` as the fill. 
*   **Interaction:** On focus, transition the background to `surface-container-lowest` and apply a 2px "Ghost Border" of `primary`.

### Specialized Components
*   **Professional Badge:** A small `tertiary_fixed` chip with `on_tertiary_fixed_variant` text to highlight "Top Rated" or "Verified" pros.
*   **Booking Stepper:** Use `primary_fixed` for inactive steps and `primary` for active, creating a tonal journey rather than a binary one.

---

## 6. Do’s and Don’ts

### Do:
*   **Do** use asymmetrical margins (e.g., 24px left, 32px right) for hero sections to create an editorial, non-template feel.
*   **Do** use the `tertiary` (#822800) color sparingly—only for high-urgency notifications or "Pro" level tags to ensure they stand out against the calm blue/white palette.
*   **Do** use outline-style icons with a consistent 1.5px or 2px stroke weight to match the `inter` typography.

### Don't:
*   **Don't** use pure black (#000000) for text. Always use `on_surface` (#191c1d) to maintain a soft, premium appearance.
*   **Don't** use standard "drop shadows" on every card. Rely on the surface-container tiers first.
*   **Don't** cram content. If a screen feels full, increase the `spacing` and use a scroll-overflow instead of shrinking typography.