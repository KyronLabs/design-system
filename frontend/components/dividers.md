# Dividers: solid and broken

Kyron separates with lines, not shadows ([philosophy.md](../philosophy.md),
pillar 1). It has two lines, and each says something different. Using the wrong
one is a bug, the same as using the wrong colour.

## The rule

**Solid closes. Broken divides.**

| Line | Says | Use it for |
|---|---|---|
| **Solid hairline** | "Something else starts here." | The edge of a block: a header and what it heads, one post and the next, the end of a post and the start of its comments, one conversation and the next. |
| **Broken hairline** | "Same thing, next part." | A division *inside* one block, between two parts of the same thing. For example, a post's spelled-out counts ("6 likes · 2 reposts") and its row of action buttons. |

Two checks follow from this:

1. **A broken line always sits inside a block.** Somewhere above it and
   somewhere below it there is a solid line, or the edge of the screen,
   closing that block. A broken line at the edge of a block is a solid line
   drawn wrong.
2. **Never put two solid lines inside one block.** If a block needs dividing
   twice, both inner lines are broken. Three solid lines through one post cut
   it into slabs that read as three different things.

### Example: a post's own page

```
 Weaver  @weaver                         [Follow]
 Good shot of our lovely kudu …
 8:53 PM · 2 Nov 2026
──────────────────────────────────────────────────  solid: the post's body ends
 2 reposts   6 likes   7 replies   6 gifts
- - - - - - - - - - - - - - - - - - - - - - - - -   broken: same block, next part
 💬   🔁   ♡                               ⊞   ⇪
──────────────────────────────────────────────────  solid: the post ends
 7 COMMENTS
```

The counts and the buttons are one block: what has happened to this post, and
what you can do to it. A solid line between them used to split the post into
three pieces. When a post has no counts there is nothing to divide, so the
buttons sit between two solid lines and the broken line is not drawn at all.

### What is not a divider

- **Thread rails.** The lines down the left of a comment thread connect
  replies and do not separate them, so neither rule applies. Never put a
  hairline between two rows of one thread: it competes with the rails and
  cuts the branch. A solid line goes under a top-level comment *and
  everything hanging off it*, between one conversation and the next.
- **Card outlines.** A quoted post, a link preview or a voice post is outlined
  with the post rule (below). It is an edge, not a division.

## Geometry

There is one hairline. It is the line that sits above the reply box, between
posts, and around every card drawn inside a post. Every divider in the app is
this line, either whole or broken. A heavier line is not a stronger hairline.
It is a bug.

### The hairline (solid)

| | |
|---|---|
| **Weight** | **0.5pt** (half a logical point) |
| **Colour** | `outline` at **15%** alpha |
| **Width** | Full-bleed between sections. Inside a post it spans the post's content inset, the same as the text. |

Light enough to sit under the content rather than on it. An earlier line, one
device pixel at `outline` 22%, came out darker and read as a bar on a post's
page. Do not use it for new work.

### The broken hairline

The same line with gaps in it: the same weight and the same colour. It is the
hairline saying less, not a different line.

| | |
|---|---|
| **Weight** | **0.5pt**, as the solid line |
| **Colour** | `outline` at **15%**, as the solid line |
| **Dash** | **4pt** |
| **Gap** | **3pt** |
| **Ends** | Whole dashes only, centred on the line's width, so it starts and ends the same distance in from both edges and never ends on a stub. |

The dashes are longer than the gaps, so it still reads as a line rather than a
row of specks. Round dots were tried and rejected: at this weight they read as
dust, not as a division.

### Spacing

Each line has 12pt (`space12`) above and below it inside a post. The line
that closes the action row gets 8pt above, so it closes the row instead of
underlining it.

## Flutter

In the app (`app/lib/widgets/hairline.dart`):

```dart
const RuleLine();        // solid: closes
const BrokenRuleLine();  // broken: divides
// As a border, for a box's edge: Border(top: postRule(scheme))
```

Do not draw a `Divider`, a `Container(height: 0.5)` or a dashed `Border`
instead. Every screen that drew its own ended up a different weight from the
others. The thickest case was two soft lines stacked a fraction apart, which
looked like one blurry rule.
