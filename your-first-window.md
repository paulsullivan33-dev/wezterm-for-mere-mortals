# Your First Window

**Outcome: a WezTerm window open on your
shell, a command run inside it, and the
knowledge of what you are looking at.**
Everything before this chapter was
preparation; this is the product.

## The command

```bash
wezterm
```

is short for

```bash
wezterm start
```

A window opens. Inside it runs your
**default shell** — on Linux, the shell
from your account (`$SHELL`); the window
is its home now. The frame around it is
WezTerm's: a tab bar along the top with
one tab, and the pane filling the rest.
Type, and the shell answers. The window
is a place, and for the next several
chapters it is the place you will be
configuring.

The lab could not sit in front of this
window — it has no display — so it
borrowed one: a virtual screen from
Xvfb, software rendering, and the same
command with a program attached:

```bash
wezterm start -- bash -c 'echo "gui pane ran this" > gui-proof.txt; sleep 40'
```

The `--` form tells WezTerm to run a
program instead of the shell. The window
opened, the program ran inside the pane,
and its file appeared on disk (transcript
`t14-xvfb-gui.txt`). That is the lab's
evidence that the window works; what it
*looks like* while working — colours,
cursor, the tab bar's manners — is
yours to judge on your own screen, and
this guide does not pretend otherwise.

## The check

Inside the new window, run:

```bash
wezterm --version
```

The same version string as chapter 3
should come back. That sounds trivial
and is not: it proves the shell inside
the pane found the same `wezterm` on its
`PATH`, which is the setup every later
chapter — especially the scripted
multiplexer in chapter 6 — quietly
depends on.

## Starting somewhere, starting something

Two variations cover most real use:

```bash
wezterm start --cwd ~/projects/website
wezterm start -- htop
```

`--cwd` chooses the directory the first
pane opens in; a program after `--`
replaces the shell for that pane (when
the program exits, the pane closes —
which is why the lab's proof command
ends in a `sleep`: without it the window
would have done its work and vanished
before anyone could check). If a WezTerm
window is already running, `wezterm
start` normally asks *it* to open the
new window; `--always-new-process`
starts a separate GUI process instead —
the lab used it throughout, so each
experiment stood alone.

## Closing, and what survives it

Close the tab or let its program exit,
and the pane is gone; close the last
tab and the window closes. For local
windows that is the whole story — the
multiplexer serving a local window ends
with it, and its panes end too. Panes
that must outlive the window live
somewhere else: in a mux server (chapter
6) or on an SSH domain (chapter 9),
where closing your window is a
disconnect, not a death. Hold that
distinction; chapter 12 returns to it.

## If the window does not open

Two failures have names and messages,
and the lab met both. With no display
at all:

```text
ERROR  wezterm_gui > XOpenDisplay failed to open a display. Check the $DISPLAY env var; terminating
```

and on a display whose graphics
libraries are missing:

```text
ERROR  wezterm_gui::frontend > Failed to create window: with_egl_lib failed: libEGL.so.1: cannot open shared object file
```

Chapter 13 works through both. On an
ordinary desktop with a working graphics
stack, neither appears, and the window
simply opens — as it should.
