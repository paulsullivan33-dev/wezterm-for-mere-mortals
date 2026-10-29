# Fonts and Appearance

**Outcome: a font and colour scheme you
chose on purpose, and the tool —
`wezterm ls-fonts` — that proves which
font will draw any character you can
name, before you blame the wrong one.**
This is the chapter where the guide's
handicap is sharpest: the lab could
measure fonts but never see them. It
turns out measuring gets you most of
the truth.

## Meet the fallback chain

Run this with no configuration at all:

```bash
wezterm ls-fonts
```

```text
Primary font:
wezterm.font_with_fallback({
  -- <built-in>, BuiltIn
  "JetBrains Mono",

  -- /usr/share/fonts/truetype/noto/NotoColorEmoji.ttf, FontConfig
  "Noto Color Emoji",

  -- <built-in>, BuiltIn
  "Symbols Nerd Font Mono",
})
```

That is the whole system in one output.
The primary font is **JetBrains Mono**,
compiled into the binary — WezTerm
carries a real font so a fresh install
never opens on a system's worst
monospace. Behind it: the system's emoji
font, and the built-in **Symbols Nerd
Font Mono** for the icons and powerline
glyphs that shells draw. Below the
primary block, `ls-fonts` prints the
variants the chain resolves for bold,
italic and half-intensity text — your
**font rules**, whether you wrote them
or not.

## Asking about one character

The chain earns its keep when a symbol
renders as a box — the universal sign
for "no font in the chain had this
glyph". Ask the tool instead of guessing:

```bash
wezterm ls-fonts --codepoints 2764
```

```text
 0 ❤    \u{2764}     x_adv=10 cells=1  glyph=uni2764
     wezterm.font("DejaVu Sans Mono", …)
     /usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf, FontConfig
```

2764 is the heavy black heart. It is
*not* in JetBrains Mono; on the lab's
machine the chain fell through to the
system's DejaVu Sans Mono, found by
FontConfig, and `ls-fonts` says so to
the file path. `--text "some string"`
answers for a whole string, glyph by
glyph (transcript `t12-fonts.txt`).
Whatever your mystery symbol, this is
the check: either some font in the
chain claims it, or you have found a
genuinely missing glyph and the fix is
a font, not a setting.

## Choosing your font

```lua
config.font = wezterm.font 'DejaVu Sans Mono'
config.font_size = 13.0
```

The lab ran exactly this (kept at
`wezterm-lab/configs/font-dejavu.lua`),
and `ls-fonts` confirmed the new order:
DejaVu Sans Mono first, **JetBrains Mono
demoted to fallback** — setting a font
prepends your choice; it does not fire
the chain behind it. For a list of your
own, `wezterm.font_with_fallback { 'A',
'B' }` spells the whole chain.
`config.font_rules` overrides single
slots — the italic variant, say — and
is documented-only here; the slots
themselves were read off `ls-fonts` in
the lab, which is where most people
meet them.

## Colour schemes and opacity

Colour is one field:

```lua
config.color_scheme = 'Builtin Solarized Dark'
config.window_background_opacity = 0.95
```

WezTerm ships with a large library of
named schemes — the `Builtin …` family
among them — and the lab's config used
the one above; the GUI accepted it and
ran (transcript `t14`). A `config.colors`
table overrides individual colours —
foreground, background, cursor, the
ANSI palette — for people rolling their
own. Opacity below 1.0 lets the desktop
show through the window background; on
some systems it needs the window
compositor's cooperation, which the
project documents per platform.

And here the guide stops and points at
you. *Which* scheme is kind at 2 a.m.,
whether 0.95 opacity is tasteful or a
smudge, whether DejaVu's bold is too
heavy — the lab has no eyes and no
opinion it can back. It verified the
plumbing end to end: fields load, chains
resolve, files are named. The judging
is the reader's pleasure, and it takes
four seconds with live reload
(chapter 5): change the name, save,
look.
