# Dividers: solid and dotted

Kyron separates with lines, not shadows ([philosophy.md](../philosophy.md),
pillar 1). It has two lines, and each says something different. Using the wrong
one is a bug, the same as using the wrong colour.

## The rule

**Solid closes. Dotted divides.**

| Line | Says | Use it for |
|---|---|---|
| **Solid hairline** | "Something else starts here." | The edge of a block: a header and what it heads, one post and the next, the end of a post and the start of its comments, one conversation and the next. |
| **Dotted hairline** | "Same thing, next part." | A division *inside* one block, between two parts of the same thing. For example, a post's spelled-out counts ("6 likes · 2 reposts") and its row of action buttons. |

Two checks follow from this:

1. **A dotted line always sits inside a block.** Somewhere above it and
   somewhere below it there is a solid line, or the edge of the screen,
   closing that block. A dotted line at the edge of a block is a solid line
   drawn wrong.
2. **Never put two solid lines inside one block.** If a block needs dividing
   twice, both inner lines are dotted. Three solid lines through one post cut
   it into slabs that read as three different things.

### Example: a post's own page

```
 Weaver  @weaver                         [Follow]
 Good shot of our lovely kudu …
 8:53 PM · 2 Nov 2026
──────────────────────────────────────────────────  solid: the post's body ends
 2 reposts   6 likes   7 replies   6 gifts
··················································  dotted: same block, next part
 💬   🔁   ♡                               ⊞   ⇪
──────────────────────────────────────────────────  solid: the post ends
 7 COMMENTS
```

The counts and the buttons are one block: what has happened to this post, and
what you can do to it. A solid line between them used to split the post into
three pieces. When a post has no counts there is nothing to divide, so the
buttons sit between two solid lines and the dotted line is not drawn at all.

### What is not a divider

- **Thread rails.** The lines down the left of a comment thread connect
  replies and do not separate them, so neither rule applies. Never put a
  hairline between two rows of one thread: it competes with the rails and
  cuts the branch. A solid line goes under a top-level comment *and
  everything hanging off it*, between one conversation and the next.
- **Card outlines.** A quoted post, a link preview or a voice post is outlined
  with the post rule (below). It is an edge, not a division.

## Geometry

### Solid hairline

- **Weight:** one *device* pixel (`1 / devicePixelRatio`), not 0.5 logical. A
  0.5 line on a 3× screen is 1.5 device pixels: drawn as two soft rows, it
  comes out heavier than a hairline.
- **Colour:** `outline` at 22% alpha.
- **Width:** full-bleed between sections. Inside a post it spans the post's
  content inset, the same as the text.

### Dotted hairline

- **Round dots, not dashes.** At this weight a dash reads as a broken solid
  line.
- **Dot:** 1pt across. A device-pixel dot disappears on a 3× screen.
- **Pitch:** 4pt from one dot's centre to the next, so the dots are further
  apart than they are wide.
- **Colour:** `outline` at 50% alpha. The dots cover a quarter of the length,
  so at the solid line's 22% they all but vanish. At 50% the dotted line
  reads *lighter* than the solid one, which is what a subordinate division
  should do.
- **Centred:** the run of dots is centred on its width, so it starts and ends
  the same distance in from both edges and never ends on part of a dot.

### Spacing

Each line has 12pt (`space12`) above and below it inside a post. The line
that closes the action row gets 8pt above, so it closes the row instead of
underlining it.

## Flutter

In the app (`app/lib/widgets/hairline.dart`):

```dart
const Hairline();        // solid: closes
const DottedHairline();  // dotted: divides
```

Do not draw a `Divider`, a `Container(height: 0.5)` or a dashed `Border`
instead. Every screen that drew its own ended up a different weight from the
others. The thickest case was two soft lines stacked a fraction apart, which
looked like one blurry rule.
