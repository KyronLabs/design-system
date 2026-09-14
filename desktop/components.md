# Desktop components

Geometry for the controls a Kyron desktop application is built from. The
reasoning is in `desktop/philosophy.md`; this is the table.

Every value here is a token from `desktop/tokens.css`. A component that needs
a number not in that file is a component whose spec is wrong.

---

## Buttons

Rectangles at `--radius-control`, not pills.

| Size | Height | Padding X | Gap | Type | Weight | Used for |
|---|---|---|---|---|---|---|
| Large | 32 | 16 | 8 | `--font-2` | 600 | The one primary action in a view |
| Default | 28 | 12 | 6 | `--font-2` | 500 | Everything else |
| Small | 24 | 8 | 4 | `--font-1` | 500 | Inside a dense panel or a row |

| Variant | Rest | Hover | Pressed | Disabled |
|---|---|---|---|---|
| Primary | `--accent` on white | `--primary-400` | `--accent-pressed` | `--accent-disabled` |
| Secondary | `--surface`, 1px `--edge-strong` | `--hover` over it | `--pressed` | 40% opacity |
| Ghost | transparent | `--hover` | `--pressed` | 40% opacity |
| Danger | `--negative-600` on white | `--negative-500` | `--negative-700` | 40% opacity |

An icon-only button is square at its size's height, and **carries a tooltip**.

## Icon buttons and hit area

Drawn size and hit area are separate. A 16px glyph in a 24px button is
correct; a 16px glyph with a 16px hit area is not. Where a control must be
drawn smaller than `--control-min`, pad the hit area out to 24 and leave the
drawing alone.

## Inputs

| | |
|---|---|
| Height | `--control-height` (28), or auto for multi-line |
| Padding | 6 vertical, 8 horizontal |
| Radius | `--radius-control` |
| Border | 1px `--edge-strong` |
| Fill | `--surface-raised` |
| Type | `--font-ui` |
| Focus | 1px `--focus-ring` border **and** the `:focus-visible` ring |
| Invalid | 1px `--negative-600`, with the reason below the field in `--font-1` |

**A field must survive being typed in.** If a keystroke rebuilds the interface,
the element being typed into has to keep its identity, or the caret is lost
and every character costs a click. Rebuild on a change of *shape*; sync values
otherwise, and never write into the element that has focus.

## Choosing between options

Per philosophy §5 — show the choices.

**Six or fewer: a segmented control.** Every option visible.

| | |
|---|---|
| Height | `--control-height` |
| Segment padding | 10 horizontal |
| Radius | `--radius-control` on the group; segments square inside it |
| Rest | `--surface`, 1px `--edge-strong` around the group |
| Selected | `--selected` fill, `--ink` text, `--weight-semibold` |
| Hover | `--hover` on the unselected segment under the pointer |

**More than six: a popover list**, anchored under its trigger, `--radius-panel`,
1px `--edge`, opening in `--motion-panel`. Escape closes it; a click outside
closes it; arrow keys move; Enter chooses. It is never a native `<select>`,
which hands the list to the operating system and takes Kyron's type and colour
with it.

## Sliders

A number with a range is a slider **and a field**: the slider for finding a
value, the field for saying one exactly. A slider alone cannot express 1.35.

| | |
|---|---|
| Track | 4 tall, `--radius-full`, `--edge-strong` |
| Filled | `--accent` |
| Thumb | 14 square, `--radius-full`, white with 1px `--edge-strong` |
| Hit area | 24 tall, centred on the track |
| Readout | `--font-1`, `--ink-soft`, right-aligned in the label row |

## Panels

| | |
|---|---|
| Background | `--surface` |
| Separation | 1px `--edge`, full-bleed. No shadow, no radius where it meets the window edge |
| Padding | `--pane-padding` |
| Title | `--font-1`, `--weight-semibold`, `--ink-faint`, uppercase, letter-spacing 0.04em |
| Resizable | Where content varies in size. 4px splitter, 8px hit area, `col-resize` |

Panel titles are the one place tracking is not zero: at 11.3px uppercase,
zero tracking is unreadable. This is a deliberate exception and the only one.

## Rows in a list

| | |
|---|---|
| Height | 24 minimum, 28 comfortable |
| Padding | 4 vertical, 8 horizontal |
| Gap between items | `--row-gap` |
| Hover | `--hover` across the full row |
| Selected | `--selected`, with a 2px `--accent` bar on the leading edge |
| Right-click | Opens the same actions available elsewhere |

## Context menus

`--radius-panel`, 1px `--edge`, `--surface-raised`, 4px padding. Items are
24 tall, 8 horizontal padding, `--font-ui`. A separator is 1px `--edge` with
4px above and below. Shortcuts are right-aligned in `--ink-faint`.

No submenus. A menu that needs one needs a dialog.

## Dialogs

Centred, `--radius-dialog`, 1px `--edge`, `--surface-raised`. A scrim at
`rgba(0,0,0,0.45)`. Not a bottom sheet — a sheet on a 1440px window is a
phone control that got lost.

| | |
|---|---|
| Padding | `--space-20` |
| Title | `--font-ui-title`, `--weight-semibold` |
| Body | `--font-ui` |
| Actions | Bottom right, primary last, `--space-8` between |
| Escape | Cancels |
| Enter | Confirms, unless the focused control uses it |

Opening focuses the first field, or the primary action when there is none.
Closing returns focus where it was.

## Tooltips

After 500ms of hover, or immediately on keyboard focus. `--surface-raised`,
1px `--edge`, `--radius-control`, 4/8 padding, `--font-1`. Names the action
and its shortcut: `Undo · Ctrl+Z`.

Never the only place a name appears for something a beginner must find.

## Status and problems

A bar along the bottom, `--font-1`, one line, saying whether the document is
publishable and what is stopping it. Each problem carries **the action that
clears it**, not only its description.

| | |
|---|---|
| Fine | `--positive-500` |
| Blocked | `--negative-600` |
| Working | `--ink-soft` |

## Empty states

An empty panel says what goes in it and how to put something there. A panel
that is empty and silent is indistinguishable from one that is broken — which
is also true of a canvas that fails to draw, so **a view that cannot render
says so where the drawing would have been.**
