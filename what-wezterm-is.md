# What WezTerm Is

Every command you run in a terminal
happens inside a frame: a window that
draws the letters, remembers what
scrolled past, and turns your keystrokes
into signals the shell understands. That
frame is the **terminal emulator**, and
it is the most-used program on a
developer's machine that nobody chose
on purpose. It came with the operating
system, and it stayed.

**WezTerm is a terminal emulator you
choose on purpose.** It is written by
Wez Furlong in **Rust** — a fast,
memory-safe language — and it draws its
text with the machine's **graphics
processing unit (GPU)** instead of the
ordinary processor, which is why a wall
of log output scrolls like water instead
of tearing. It runs on Linux, macOS and
Windows from the same codebase and the
same configuration file. And it contains
a **multiplexer**: the ability to split
one window into panes, stack windows
into tabs, group them into workspaces,
and keep sessions alive on another
machine — work that traditionally
belongs to a separate program, tmux,
running *inside* the terminal.

That combination is the idea. One
program draws the text, splits the
screen, holds the sessions and connects
to the servers, and all of it is
configured in one file written in
**Lua**, a small programming language
you edit in a text editor. Save the
file, and the running terminal re-reads
it — the lab changed a good config for a
broken one under a running window and
watched the error arrive within seconds,
no restart (transcript
`wezterm-lab/transcripts/t16-default-location-and-reload.txt`).

## A first taste

After installing (chapter 3), the whole
product is one command:

```bash
wezterm
```

A window opens on your shell. From
there the defaults carry you a long way
— they are printed, in full, by the
program itself. The lab ran this on a
machine with no window at all and still
got the whole table:

```bash
wezterm show-keys
```

```text
	SHIFT | CTRL         P                  ->   ActivateCommandPalette
	SHIFT | CTRL         T                  ->   SpawnTab(CurrentPaneDomain)
```

Two of the 268 lines: **Ctrl+Shift+P**
opens the command palette, a searchable
list of everything the terminal can do;
**Ctrl+Shift+T** opens a new tab.
Chapter 7 walks the table properly.

## One program, three hats

The download carries three programs
(transcript `t17-release-contents.txt`):

- `wezterm` — the command-line face:
  starts windows, connects to servers,
  inspects fonts and keys, and drives a
  running multiplexer from scripts.
- `wezterm-gui` — the window itself, the
  renderer and the built-in multiplexer
  that serves your panes.
- `wezterm-mux-server` — the multiplexer
  on its own, with no window at all: it
  holds panes and sessions on a machine
  so terminals can connect, disconnect
  and reconnect. The lab ran this one
  for real, headless, and drove it with
  `wezterm cli` — spawning tabs,
  splitting panes, reading their contents
  back (transcripts `t09` to `t11`).

Chapter 2 takes the parts apart
properly.

## What it is not

WezTerm is not a shell: it hosts bash,
zsh, fish or PowerShell, and when the
shell is slow or strange, that is the
shell, not the frame — chapter 2's table
exists to keep that straight. It is not
an editor, an IDE or a file manager; it
draws text that other programs produce.
It is not a remote-desktop tool: its SSH
support (chapter 9) runs shells on other
machines, it does not carry their
screens home. And its multiplexer is not
tmux: sessions live as long as the
multiplexer process lives, on your desk
or on a server you leave running, but
WezTerm does not pretend to be a
system service — chapter 12 is plain
about that edge, and chapter 11 gives
tmux its due.

## Who it is for

The developer whose terminal is open
all day and who wants it fast, pleasant
and *theirs* — one config that follows
them across Linux, macOS and Windows.
The tmux user who likes panes and tabs
but would rather the terminal itself
knew about them, so the mouse, the
clipboard and the fonts are one system
instead of two negotiating. The
homelabber who keeps sessions on a
server and wants to reconnect to them
from the desk without ceremony. And the
terminal traditionalist who simply wants
to know exactly which font draws which
symbol — chapter 8's tool answers that
to the glyph.

## The honest catch, up front

Three, and this guide will not let you
miss any of them. First: the
configuration is a program, and programs
can be wrong — chapter 5 shows a broken
config failing loudly in the window and,
stranger, *silently* on the command
line, where a tool that should report
the error prints the defaults and says
nothing. Second: GPU rendering wants a
graphics stack; the lab's window refused
to open until software-rendering
libraries were fetched, and on a machine
with no display at all the program says
so and stops (chapter 13 has both
messages). Third: the lab never *saw*
any of it. Every claim here that needed
eyes — colours, smoothness, beauty — is
marked as documentation, not experience.
What the lab could prove, it proved with
transcripts.
