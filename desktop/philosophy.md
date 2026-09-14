# Kyron on a desktop

`frontend/philosophy.md` is Kyron's design philosophy **for a phone**. Almost
every rule in it is a rule about a thumb: 44-pixel targets, sheets that rise
from the bottom edge because that is where a hand is, haptics on touch-down,
no hover because there is no cursor to hover with.

The lens studio is a Windows application. Somebody sits at it for an hour with
a mouse and a keyboard, on a screen six times the area of a phone, with eight
panels open at once. Applying the phone rules there produces a website that
has been stretched — which is what the first version of the studio was, and
why it was hard to move around in.

This file is the desktop half. It says what carries over unchanged, what
inverts, and why — because "it is a bigger screen" is not a reason for
anything on its own.

---

## What does not change

**The palette.** A brand is not a platform. Every ramp, every semantic
colour, the accent — identical, and `desktop/tokens.css` is checked against
the Dart on every run so the two cannot drift.

**The type scale.** The same 1.125 ratio from a 15px base. What changes is
which step is the default (below).

**Zero tracking.** Still zero. Still no rounding of 16.9 to 17.

**Flat and hairline-separated.** No elevated cards, no drop shadows for
separation. This one is *more* important on desktop, not less: a window with
eight panels and a shadow under each is a pile of paper.

**Optimistic updates.** The finger drives the screen, the network follows —
and so does the disk. A desktop tool that blocks on a save is worse than a
phone that blocks on a request, because the work in front of somebody is
larger.

**Contrast.** 4.5:1 for text, 3:1 for a graphical object. A larger screen is
not a brighter one.

---

## What inverts, and why

### 1. The floor for a target is 24, not 44

44 is the size of a fingertip's uncertainty. A mouse lands within a pixel or
two, and a trackpad within a few, so the constraint is not accuracy — it is
*acquisition*: how hard it is to stop the pointer on the thing. Fitts's law
puts that at a couple of dozen pixels for a control in a dense panel, and
Windows, macOS and every desktop toolkit land in the same place.

So: **24 is the floor, 28 is the default, 32 for a primary action.** Anything
drawn smaller than 24 — a close cross, a drag handle — gets padded out to 24
rather than drawn bigger.

The 44 rule is not softened out of laziness. Keeping it would mean a panel of
six controls is 264 pixels tall, and a tool that shows six panels at once has
nowhere to put them.

### 2. Rectangles, not pills

Mobile's signature is the fully rounded pill. On a desktop it is wrong — a
pill toolbar button beside the square chrome of a window reads as a web page
that wandered into an application.

**Controls are rectangles at `--radius-control` (4).** Panels and popovers at
8, dialogs at 12. The pill is kept only for what is genuinely a chip or a tag,
where the shape carries meaning.

### 3. Hover and focus exist, and carry real information

A phone has neither. A desktop has both, and a control that responds to
neither is indistinguishable from a label.

- **Hover** is an affordance: this is pressable. `--hover` tint, in
  `--motion-state` (90ms).
- **Focus** is a keyboard position, and it must be visible on every focusable
  thing. `tokens.css` defines one ring and applies it with `:focus-visible` so
  no component can forget or invent its own.
- **Press** stays scale + opacity, as on mobile.

### 4. The keyboard is a first-class input, not an accessibility feature

Somebody who uses this tool daily will not reach for the mouse to undo.

- Every action that has a button has a shortcut, and the tooltip on the button
  names it.
- Tab order follows reading order, and nothing focusable is unreachable.
- Escape closes the frontmost transient thing; Enter confirms it.
- A shortcut that exists only in a menu does not exist, because — see below —
  there is no menu.

### 5. Show the choices; do not hide them behind a control

Kyron's phone app has a standing rule: **no drop-down menus, only bottom
sheets.** That rule is about a phone, where a native `<select>` hands the
screen to the operating system.

The desktop rule is the same rule's *reason* rather than its letter: **a
reader should be able to see what their options are without pressing
anything.**

- **Six or fewer options** — draw them all. A segmented control, a row of
  chips, a radio list. Choosing an anchor from `eyes / nose / mouth /
  forehead / chin` is one click and no hidden state.
- **More than six, or a list that grows** — a popover anchored to its
  trigger, opening in `--motion-panel`, dismissed on Escape or a click
  outside. This is what a phone would use a sheet for.
- **Never a menu bar.** File / Edit / View across the top of a window is a
  second copy of controls that are already in the interface, in a strip that
  reads as part of the operating system. Everything it would hold belongs in
  the window, where somebody can see it.

### 6. Panes, not screens

A phone navigates between screens; a desktop shows several things at once and
the relationships between them are the interface.

- **Panes are resizable** where their content varies in size, and remember
  their size between sessions.
- **A pane is never the only route to something.** Hiding a pane must not hide
  an action.
- **The window has a minimum size** at which the layout still works, and it is
  tested at that size rather than assumed.

### 7. Right-click is expected

An object in a list or on a canvas should offer its actions on
`contextmenu` — the same actions that exist elsewhere, not a secret set.

### 8. Tooltips label what an icon cannot

Any control that is icon-only carries a tooltip after a short delay, naming
the action and its shortcut. On a phone this does not exist, so a bare icon is
a guess; on a desktop there is no excuse for one.

### 9. Density: one scale, a lower default

The spacing scale is unchanged — 2 to 40. What changes is which step things
reach for. A list row on a phone is 12 or 16 of padding; in a desktop panel
the same row is 4 or 8. `--pane-padding` and `--row-gap` name the two a
layout reaches for most, so a window is one decision rather than forty.

Type is the same: the scale is identical, and the default is one step down.
`--font-ui` is 13.1 rather than 15, because a pointer sits closer to a larger
screen and a tool showing eight panels cannot set them all in phone type.

Motion is the same numbers, one step faster: `--motion-state` is 90 and
`--motion-panel` is 180. A 260ms panel is a considered transition on a phone
and a stutter on a desktop, where the pointer has already moved on.

### 10. No haptics

There is nothing to vibrate. Every haptic call is a no-op, and a design that
*depends* on one to confirm an action is a design with no confirmation.

---

## What a beginner needs, specifically

The studio was reported as "too difficult to navigate and not beginner
friendly at all". That is a design failure with named causes, not a matter of
taste:

1. **Nothing says what the tool is for.** An empty window with eight panels is
   a cockpit. There should be a first thing to do, visible, with words.
2. **Nothing is labelled with its consequence.** "Publish" is a verb; what it
   *does* — opens a pull request against the lens catalogue — is a sentence,
   and it belongs near the button the first time somebody sees it.
3. **Jargon appears before it is defined.** Anchor, gap, region, frost. Each
   needs its meaning where it is first used, not in a README.
4. **Errors say what is wrong and not what to do.** Every blocker should carry
   the action that clears it.
5. **There is no way back.** Undo exists; discoverable undo does not.

A beginner-friendly desktop tool is not a simplified one. It is one where the
next action is visible, named, and reversible.

---

## Consuming this

```html
<link rel="stylesheet" href="tokens.css">
```

```css
.panel {
  background: var(--surface);
  border: 1px solid var(--edge);
  border-radius: var(--radius-panel);
  padding: var(--pane-padding);
  color: var(--ink);
  font-size: var(--font-ui);
}
```

`desktop/components.md` gives the geometry for each control.

`flutter/test/desktop_css_test.dart` reads `tokens.css` and fails if any
colour, size, spacing step or duration in it disagrees with the Dart. That
test exists because a second copy of a palette is exactly how `#4C8FFF`
shipped in place of `#006AFF` across twenty-six controls, and then survived
the correction in a third place because nothing compared them.
