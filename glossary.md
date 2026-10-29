# Glossary

**Asciicast** — the timed text format
of `wezterm record`/`replay`: a session
stored as text and timing, replayable
on another machine.

**Cell** — one character position in a
pane's grid: the unit panes are sized
in (80×24 is cells, not pixels).

**Colour scheme** — a named, complete
set of colours (foreground, background,
cursor, the ANSI palette) chosen with
`color_scheme`.

**Command palette** — the searchable
action list on Ctrl+Shift+P: every
action the terminal can take now,
without knowing its key.

**Config builder** — `wezterm.config_builder()`:
an empty configuration object that
checks fields as you set them, and is
responsible for chapter 5's helpful
type errors.

**Copy mode** — the keyboard-driven
selection mode (Ctrl+Shift+X), with its
own key table: move a cursor, mark
text, copy without the mouse.

**Domain** — where a pane's program
runs: the local machine, an SSH host, a
serial port, a WSL distribution, or a
mux server. Chosen per tab, independent
of where the window is.

**Fallback chain** — the ordered list
of fonts WezTerm tries per glyph: your
font, then variants, symbols and emoji,
until one claims the character.

**Front end** — the renderer choice:
the GPU paths, or `Software`, drawn by
the CPU. Set with `front_end`.

**Glyph** — one drawn character shape
inside a font. A font lacking a glyph
for your symbol is what an empty box
means.

**GPU rendering** — drawing text with
the graphics card as textured shapes,
which is why heavy output stays smooth.

**Key table** — a named set of key
bindings in force at a time: the
default table, copy mode's, search's,
or one of yours.

**Launcher** — the menu of things to
start: windows in each domain,
workspaces, shells.

**Leader key** — an optional prefix key
that arms a following binding, tmux
style; defined with `config.leader`,
absent by default.

**Live reload** — the running terminal
re-reading `wezterm.lua` when it
changes on disk; verified by the lab
at about two seconds, errors included.

**Multiplexer (mux)** — the part that
owns panes, tabs, windows and
workspaces, as a server its windows
connect to. `wezterm-mux-server` is the
same part with no window of its own.

**Pane** — one terminal: one shell or
program in one rectangle of a tab.

**Scrollback** — the lines that have
scrolled off a pane and are kept for
searching (Ctrl+Shift+F) and reading
back.

**Show-keys / ls-fonts** — the two
inspection commands: the merged key
table, and the font chain with per-glyph
answers. Both work with no display —
and both keep a broken config's secret
(chapter 5).

**Tab** — a set of panes arranged by
splits, shown one at a time in a
window's tab bar.

**Unix domain** — a named, local mux
server declared in the config, which
`wezterm connect` attaches a window to.

**Workspace** — a named set of windows,
switched as a whole: one per job.
