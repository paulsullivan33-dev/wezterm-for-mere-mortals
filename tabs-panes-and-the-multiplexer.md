# Tabs, Panes and the Multiplexer

**Outcome: a window organised the way
you think — tabs for projects, panes for
the shells inside them — and a
multiplexer you can drive from a script
as confidently as from the keyboard.**
Chapter 2 named the parts; this chapter
works them.

## Tabs and panes from the keyboard

The defaults (all verified against
`wezterm show-keys`, transcript `t03`):

- **Ctrl+Shift+T** — new tab;
  **Ctrl+Tab** / **Ctrl+Shift+Tab** —
  next and previous tab; **Ctrl+1…8**
  jump straight to a tab.
- **Ctrl+Alt+"** — split the pane into
  two stacked rows (`SplitVertical`);
  **Ctrl+Alt+%** — split it into two
  side-by-side columns
  (`SplitHorizontal`). The names follow
  tmux's old convention and confuse
  everyone exactly once.
- **Ctrl+Shift+Z** — zoom the current
  pane to fill the tab; again to put it
  back.
- **Ctrl+Shift+W** closes a tab,
  **Ctrl+Shift+N** opens a new window.

Moving between panes is by mouse click
or by bindings you add yourself
(chapter 7 shows the mechanism);
**Ctrl+Alt+Shift+arrows** resize the
current pane. Closing a pane is closing
its program; **Ctrl+Shift+W** closes the
whole tab and asks first
(`CloseCurrentTab { confirm: true }` —
the confirmation is in the default
binding itself).

## Workspaces: one name per job

Tabs group panes; **workspaces** group
windows. A workspace is a name —
`email-server`, `novel`, `default` —
and switching to it swaps the whole set
of windows in and out. The command
palette (chapter 7) holds the switcher;
the config can give a workspace a
startup program of its own. Workspaces
are how a single terminal holds several
jobs without any of them leaking into
each other's tab bars.

## The multiplexer is a server

Here is the part that changes how you
think about the whole tool. The panes
are owned by a **multiplexer process**,
and windows are its clients. That is
why a second window can attach to the
same tabs, and it is why the
multiplexer also ships *without* a
window:

```bash
wezterm-mux-server --daemonize
```

The lab ran exactly this on a machine
with no display, then drove the server
with `wezterm cli` — and everything
below is transcript, not brochure
(`t09` to `t11`).

```bash
wezterm cli list
```

```text
WINID TABID PANEID WORKSPACE SIZE  TITLE CWD
    0     0      0 default   80x24 bash  file:///home/hatch
```

The fresh server holds one window, one
tab, one 80×24 pane running a shell.
Then:

```bash
wezterm cli spawn --pane-id 0 -- bash -c 'echo NEW_TAB_MARKER; sleep 45'
wezterm cli split-pane --pane-id 1 -- bash -c 'echo SPLIT_PANE_MARKER; sleep 45'
```

`spawn` prints the new pane's id (1) and
opens it in a new tab, running the given
program. `split-pane` prints 2 and
divides tab 1: `cli list` now shows the
two panes at 80×11 and 80×12 — the
layout, computed and reported by the
multiplexer itself. And the panes are
not write-only:

```bash
wezterm cli get-text --pane-id 2
```

```text
SPLIT_PANE_MARKER
```

`get-text` reads a pane's screen as
plain text. `send-text` types into one
(the lab's typed `echo` command appeared
in the target pane's `get-text`,
character for character). `kill-pane`
removed the split and the survivor
healed back to 80×24. Spawn, split,
read, type, kill: a complete remote
control for a terminal, in shell
commands, each one returning something
a script can check.

## The fine print the lab stepped on

Two behaviours surprised the lab and
will surprise you once, here, cheaply:

**`cli` spawns a server if none is
running.** The lab's first `cli list` —
meant for a GUI that had failed to
start — quietly launched a mux server
and listed *its* pane. Convenient, and
worth knowing before you conclude a
listing is your window's: `cli` talks to
whatever multiplexer owns the socket in
`$XDG_RUNTIME_DIR/wezterm/`, GUI or
standalone, one at a time.

**`cli spawn` needs to know where.**
Outside a pane there is no "current"
one, so a bare `wezterm cli spawn`
stops with:

```text
ERROR  wezterm > --pane-id was not specified and $WEZTERM_PANE
                 is not set in the environment, and I couldn't
                 determine which pane was currently focused; terminating
```

Inside a pane, `$WEZTERM_PANE` answers
the question; in scripts, pass
`--pane-id` (or `--window-id`) yourself,
as the examples above do.

## Persistent sessions, honestly

A mux server holds its panes until it
stops — across your windows disconnecting
and reconnecting (`wezterm connect`
attaches a GUI to a named **unix
domain** declared in the config). That
is real persistence of the tmux kind,
with one boundary: the server is an
ordinary process on an ordinary machine.
Reboot the machine, or kill the server,
and the panes and their shells end with
it. Chapter 12 puts this in the limits
where it belongs; chapter 10 turns it
into a recipe.
