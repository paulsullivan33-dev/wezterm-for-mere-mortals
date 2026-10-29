# Recipes

Short jobs, each built only from pieces
the earlier chapters verified. Unless a
recipe says otherwise, the transcripts
quoted are the lab's.

## A starter config worth keeping

The lab's working file
(`wezterm-lab/configs/good.lua`) is a
reasonable first `~/.config/wezterm/wezterm.lua`
for anyone:

```lua
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font_size = 14.0
config.color_scheme = 'Builtin Solarized Dark'
config.window_background_opacity = 0.95

config.keys = {
  {
    key = 'F9',
    mods = 'NONE',
    action = wezterm.action.ToggleFullScreen,
  },
  {
    key = 'h',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
}

return config
```

Install it, then prove it loaded with
the chapter 7 count: `wezterm show-keys
| wc -l` should read 270, not 268. If it
reads 268, the file is broken or in the
wrong place, and this is the moment to
find out — see the next recipe.

## Catch a config error before the window swallows it

Chapter 5's fork, turned into a drill
after every risky edit:

```bash
wezterm --config-file ~/.config/wezterm/wezterm.lua show-keys | grep -c '->'
```

Compare against the count your last
known-good file produced. Dropped back
to the default 268-line table? The file
failed to load, and the CLI will never
say why. For the *why*, give the file to
the face that reports errors:

```bash
wezterm --config-file ~/.config/wezterm/wezterm.lua start
```

and read the first lines: a
`Configuration Error:` with file and
line, as in transcript `t15`. Fix,
close, carry on. The drill takes ten
seconds and converts the guide's
strangest behaviour into a non-event.

## A scripted layout: server, editor, log

Chapter 6's remote control, aimed at a
real shape — a three-pane working tab,
built by a script and checked by one:

```bash
wezterm-mux-server --daemonize
tab=$(wezterm cli spawn --pane-id 0 --cwd ~/project -- bash)
wezterm cli split-pane --pane-id "$tab" --percent 30 -- bash -c 'tail -f ~/project/build.log; bash'
wezterm cli get-text --pane-id "$tab" | head -3
```

The spawn prints the main pane's id; the
split gives the log a 30% strip (the
`--cwd` and `--percent` options are from
the two commands' own help, transcript
`t18` — the lab's own splits used the
default half, 80×11 over 80×12); the
final `get-text` is the
check: the pane's screen, in the
script's hand, assertable. Run it under
a GUI's multiplexer instead of a
standalone server and the same commands
arrange the visible window — the socket
decides whose panes you are driving
(chapter 6's fine print).

## Which font draws this symbol?

The chapter 8 check as a one-liner,
for the symbol your prompt keeps
failing to draw:

```bash
wezterm ls-fonts --text '➜ λ ♥'
```

Each glyph is answered with its font
and file. A glyph answered by nothing
in the chain is a font to install, and
now you know its name is missing rather
than its setting being wrong. The lab's
worked example is transcript `t12`: a
heart that fell through the built-in
font to a system DejaVu, named to the
path.

## Type into another pane from a script

`wezterm cli send-text --pane-id N`
delivers text as if pasted. The lab
typed `echo SENT_TEXT_MARKER` into a
headless pane and read the command back
off the pane's screen with `get-text` —
the round trip is the verification
pattern for any script that drives a
pane: send, then read, then believe.

## Record a session

`wezterm record` runs a session and
saves it as an **asciicast** — a timed
text recording another machine can
replay with `wezterm replay`, pauses
and all. The lab verified these two
commands' help and no more (transcript
`t13`): recording a *window* needs the
window, and this guide's criteria file
lists it as documented-only rather than
borrow a result it did not run. On a
real desktop it is the natural way to
capture a bug report's terminal: what
was typed, what it answered, exactly
when.
