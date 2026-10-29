# The Moving Parts

WezTerm arrives as one download and
presents as one program, but six parts
do six different jobs inside it. Nearly
every surprise in this guide — including
most of the troubleshooting chapter —
is one of these parts behaving exactly
as designed while the reader expected
another part's behaviour. This chapter
names them.

## The three programs

The release unpacks to three executables
(transcript `t17-release-contents.txt`):

| Program | Size | The job |
| --- | --- | --- |
| `wezterm` | 25 MB | The command line: start, ssh, ls-fonts, show-keys, cli |
| `wezterm-gui` | 74 MB | The window: rendering, input, and the multiplexer that serves local panes |
| `wezterm-mux-server` | 26 MB | The multiplexer alone, windowless, for holding sessions on a machine |

`wezterm start` is `wezterm` asking
`wezterm-gui` to open a window.
`wezterm-mux-server --daemonize` runs the
third one in the background; the lab did
exactly that on a machine with no
display, and it held panes happily.

## The renderer: text on the graphics card

The GUI draws text as textured shapes on
the **GPU** rather than painting pixels
with the CPU. That is the "GPU-accelerated"
in the one-line descriptions, and it is
why heavy output stays smooth: the card
does what cards are for. The renderer
has a **front end** you can choose in
the config — the GPU paths, or a
**software renderer** that draws with
the CPU. The software path is not a
punishment detail: it is what let the
lab's window open under a virtual screen
at all, once Mesa's software libraries
were present (chapter 13 tells that
story with the error messages attached).
On a machine with a working graphics
stack you will never think about this
part, which is the point of it.

## The font system: shaping and fallback

Terminal text is not one font. It is a
**fallback chain**: your chosen font
first, then helpers for whatever it
lacks — bold and italic variants, symbols,
emoji. WezTerm shapes text with the
HarfBuzz library (the same shaper your
browser uses) and rasterizes glyphs with
FreeType on Linux. Two fonts are built
into the binary itself: **JetBrains
Mono**, the default, and **Symbols Nerd
Font Mono**, which carries the powerline
and icon glyphs shells like to draw.

The chain is not a theory — the lab read
it. With no configuration at all,
`wezterm ls-fonts` reports the primary
font as JetBrains Mono (built-in), with
the system's Noto Color Emoji behind it.
Asked which font draws a heavy black
heart (U+2764), it answered: not
JetBrains Mono — **DejaVu Sans Mono**,
found on the system by FontConfig
(transcript `t12-fonts.txt`). When a
symbol renders as an empty box in any
terminal, this chain is where the answer
lives, and chapter 8 teaches the tool.

## The multiplexer: windows, tabs, panes, workspaces

The **multiplexer** (mux for short) is
the part that owns what is running. Its
vocabulary, smallest first:

- A **pane** is one terminal: one shell
  or program, one rectangle of text.
- A **tab** is a row of panes arranged
  by splits, shown one tab at a time.
- A **window** is the rectangle on your
  screen holding tabs.
- A **workspace** is a named set of
  windows — one for the mail server, one
  for the novel, switched as a whole.

Panes live in the multiplexer, not the
window — which is why a second terminal
can connect and see the same panes, and
why `wezterm cli` can list, split,
read and even type into them from a
script. The lab's headless session
(transcript `t10-mux-panes.txt`) shows
the shape of it: a split divided one
tab's 80×24 into panes of 80×11 and
80×12, and killing the new pane healed
the survivor back to 80×24.

A pane's shell runs in a **domain** —
the local machine by default, an SSH
server, a serial port, or a mux server
elsewhere. Domains are chapter 9's
subject; the moving part to remember is
that *where a pane runs* and *where it
is drawn* are separate choices.

## The configuration: a Lua program

Everything above takes its orders from
one file, `wezterm.lua`, written in the
Lua programming language. It is not a
list of settings in the usual sense: it
is a small program that runs at startup,
builds a table of values, and returns
it. That is why it can compute, branch
and call helper functions — and why it
can be *wrong* in the ways programs are
wrong: syntax errors, wrong types,
functions that do not exist. The running
terminal watches the file and **reloads
it live** when it changes (verified in
transcript `t16`). Chapter 5 is devoted
to this part, including the fork in its
behaviour that this guide keeps coming
back to: the GUI reports a bad config
with file and line; the command-line
tools quietly use the defaults instead.

## The command line: the other face

The `wezterm` program's subcommands
(transcript `t00-version-and-help.txt`)
are the parts list from another angle:
`start`, `ssh`, `serial`, `connect`,
`ls-fonts`, `show-keys`, `cli`,
`imgcat` (draw an image file in the
terminal), `record` and `replay`
(session recordings in asciicast
format), `set-working-directory` and
`shell-completion`. Two properties
matter for everything after chapter 4:
the inspection commands (`ls-fonts`,
`show-keys`) load your config to answer,
and they work with no display at all —
the lab did its whole font and key
investigation through them.

## Which part holds what

| Question | The part that answers it |
| --- | --- |
| Why is this output tearing or slow? | The renderer (GPU path, or the software front end) |
| Why is this symbol a box? | The font fallback chain |
| Why did my splits survive the window closing? | The multiplexer — panes live there, not in the window |
| Why is this tab on another machine? | Its domain |
| Why did my setting do nothing? | Usually the config: an error the GUI reported and the CLI swallowed |
| Why can't a script find my window? | The multiplexer socket — `wezterm cli` talks to one mux at a time |
| Why did the window refuse to open? | The renderer again: no display, or no graphics libraries |

Keep this table in mind. When WezTerm
surprises you, the surprise has an
address, and the address is one of
these six.
