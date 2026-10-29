# WezTerm for Mere Mortals

A terminal emulator is the window your
shell lives in — the frame around every
command you type. Most people use the
one that came with the computer and never
think about it. **WezTerm** is a reason
to think about it: a terminal emulator
written in Rust, rendered on the
**graphics card** so it stays smooth
under heavy output, with **tabs, split
panes and a built-in multiplexer** — the
things people usually bolt on with tmux —
and a configuration file written in
**Lua**, a real programming language,
which it re-reads live every time you
save it.

This guide explains what WezTerm is and
is not, how to install it, how to open
your first window, and how to make the
configuration file your own: fonts,
colours, key bindings, splits and tabs.
Then it does the thing with SSH domains,
shows how to drive the whole terminal
from scripts through its command-line
interface, and is honest about the
edges.

The lab that wrote this guide ran the
real thing — **WezTerm
20240203-110809-5046fc22**, the official
stable release, unpacked from the
project's own tarball on a small Linux
machine — and it ran it in a place with
a peculiar handicap: **the lab has no
display**. No screen, no window, no one
to look at it. So the lab verified what
can be verified without eyes: the
command-line half of WezTerm (fonts,
key tables, configuration loading), the
multiplexer working headless as a
server, and — with a virtual screen
borrowed from Xvfb and software
rendering — the real window opening and
running a real program, proved by the
file that program wrote. What could not
be done that way — judging colours,
watching a cursor blink, feeling whether
the keys are pleasant — is labelled
documented-only wherever it appears,
and `criteria.md` keeps the full ledger.

## What this guide covers

- [**What WezTerm is**](what-wezterm-is.md) —
  the mental model: a window, a shell, a
  graphics card, and a multiplexer that
  lives inside the terminal instead of
  under it
- [**The moving parts**](the-moving-parts.md) —
  the three programs in the box, the
  renderer, the font system, the
  multiplexer and the configuration file —
  and which part holds what
- [**Installing WezTerm**](installing-wezterm.md) —
  the release download, what is inside
  it, and the version check that proves
  it runs
- [**Your first window**](your-first-window.md) —
  opening the window, the shell it
  starts, and reading the screen it
  gives you
- [**The configuration file**](the-configuration-file.md) —
  Lua, the config builder, where the
  file lives, live reload, and the two
  very different ways a broken config
  can fail
- [**Tabs, panes and the multiplexer**](tabs-panes-and-the-multiplexer.md) —
  windows inside windows, workspaces,
  and the multiplexer driven from the
  command line
- [**Keys and the launcher**](keys-and-the-launcher.md) —
  the default key table, adding your
  own bindings, the command palette and
  the launcher
- [**Fonts and appearance**](fonts-and-appearance.md) —
  choosing a font, the fallback chain
  that rescues missing symbols, colour
  schemes and opacity — and the tool
  that shows you all of it without a
  window
- [**SSH domains**](ssh-domains.md) —
  remote machines as first-class tabs:
  the one-off `wezterm ssh`, persistent
  SSH domains, and what the multiplexer
  does on the far end
- [**Recipes**](recipes.md) — a starter
  config worth keeping, catching config
  errors before the window swallows
  them, scripted layouts, and finding
  which font draws a symbol
- [**The neighbours**](the-neighbours.md) —
  tmux the multiplexing king, the
  terminals that refuse to multiplex,
  and the ones your system came with
- [**Limits**](limits.md) — a config
  error the command line will not tell
  you about, a renderer that wants a
  graphics stack, sessions that die
  with their server, and the rest,
  stated plainly
- [**Troubleshooting**](troubleshooting.md) —
  the display that is not there, the
  graphics library that is missing, the
  config that silently did nothing, and
  the traps this guide's lab fell into
- [**Glossary**](glossary.md) — the
  terms, collected in one place

## What it doesn't cover

Writing your own Lua plugins and event
handlers beyond the shapes chapter 5
shows — the configuration API is large
and has its own reference; this guide
teaches the core of it and the habits
that keep it safe. The Windows and macOS
builds are described from the project's
documentation, not run: the lab is a
Linux machine with no screen at all, and
it says so wherever the difference
matters. GPU performance — frames per
second, input latency measured in
milliseconds — is likewise not claimed:
with software rendering on a virtual
screen, the lab could prove the window
works, not how fast it feels.

## How to use this guide

Read chapter 1 for the model and
chapter 2 before installing anything —
knowing which part holds what turns
later confusion into a named problem.
Chapters 3 and 4 get you a program and
a window. Chapter 5 is the one to read
slowly: the configuration file is where
WezTerm becomes *yours*, and it is also
where its one genuinely surprising
behaviour lives — a broken config fails
*loudly* in the window and *silently* on
the command line, and chapter 5 shows
both. The lab's transcripts live in
`wezterm-lab/transcripts/`; its
configuration files — the good one and
the three deliberately broken ones — are
`wezterm-lab/configs/`.

---

## Part of the series

This guide is one of the [For Mere Mortals](https://paulsullivan33-dev.github.io/mere-mortals/) guides: plain-language guides to the tools programmers and makers use.

Related guides:

- [tmux for Mere Mortals](https://paulsullivan33-dev.github.io/tmux-for-mere-mortals/)
- [SSH for Mere Mortals](https://paulsullivan33-dev.github.io/ssh-for-mere-mortals/)
- [Bash for Mere Mortals](https://paulsullivan33-dev.github.io/bash-for-mere-mortals/)

## License

The writing in this guide is licensed under [CC BY 4.0](https://github.com/paulsullivan33-dev/wezterm-for-mere-mortals/blob/main/LICENSE). Code examples and lab scripts are licensed under the [MIT License](https://github.com/paulsullivan33-dev/wezterm-for-mere-mortals/blob/main/LICENSE-CODE).
