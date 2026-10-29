# Troubleshooting

The failures the lab met for real, in
roughly the order a new user meets
them. Transcripts are named per entry.

## The window never opens: "XOpenDisplay failed"

```text
ERROR  wezterm_gui > XOpenDisplay failed to open a display. Check the $DISPLAY env var; terminating
```

Exit code 1, no window, no apology
needed: there is no X display to open.
You are on a bare console, an SSH
session without forwarding, or a
headless box. `wezterm` the command
line works fine there (chapters 6 and 8
did their whole jobs in that state);
`wezterm start` does not. Give it a
display — a desktop, X forwarding, or a
virtual one (`Xvfb`) as the lab did —
or use the machine's own terminal for
that session. (Transcript `t13`.)

## "Failed to create window: with_egl_lib failed"

```text
ERROR  wezterm_gui::frontend > Failed to create window: with_egl_lib failed: libEGL.so.1: cannot open shared object file
```

The display exists; the graphics
libraries don't. WezTerm's default
renderer wants EGL. On a desktop this
arrives broken rarely; on minimal
servers and containers, often. Two
doors: install the system's Mesa/EGL
packages, or set the software front end
in the config —

```lua
config.front_end = 'Software'
```

— and let the CPU draw. The lab, on a
machine where package installation was
contended by other work, fetched the
Mesa libraries itself and pointed the
loader at them; the window then opened
under software rendering (transcripts
`t08` for the failure, `t14` for the
success). The two warnings that remain
even then — *error fetching window
manager name* and the xdg-desktop-portal
one — are the bare virtual screen
talking, and are harmless.

## My config change did nothing

The classic. Three suspects, in order:

1. **The file has an error.** Chapter
   5's fork: the CLI won't tell you, the
   window will. Run the chapter 10
   drill — compare `show-keys` line
   counts against your known-good, then
   start a window and read its
   `Configuration Error:` line, which
   names file and line.
2. **The file is not the file.** No
   config at the searched locations
   means defaults, also silently. The
   lab proved the standard home by
   planting an error at
   `~/.config/wezterm/wezterm.lua` and
   watching the GUI name that path
   (transcript `t16`). Note the GUI
   error prints the path it *tried* —
   the fastest way to learn where your
   build looks.
3. **The binding is shadowed.** Yours
   lose to nothing — config keys win
   over defaults — but a `key_tables`
   entry or a mode (copy mode has its
   own table) may be the table actually
   in force. `show-keys --lua` shows the
   merged result to read.

## `wezterm cli` talks to the wrong panes

`cli` connects to the multiplexer that
owns the socket in `$XDG_RUNTIME_DIR/wezterm/`.
If a standalone mux server started
before your GUI did (or an earlier
`cli` command spawned one — it does
that, helpfully, when none exists), the
listing you get is *its* panes, at
80×24, not your window's. The tells are
in transcript `t09`: the WARN line
about spawning the server, and a window
you do not recognise. The fix is to
know which mux you mean: stop the
standalone server, or drive it
deliberately — it is a fine thing to
drive, on purpose (chapter 10).

## `cli spawn` refuses: "--pane-id was not specified"

Full message in chapter 6. Outside a
pane, `cli` cannot guess the target
window: pass `--pane-id` (any live pane
in the window you mean) or `--window-id`,
or run the command from inside a pane,
where `$WEZTERM_PANE` answers for you.

## A symbol draws as an empty box

Not a WezTerm bug until proved
otherwise: run `wezterm ls-fonts --text`
on the exact string (chapter 8). If a
font in the chain claims the glyph, the
box is stale rendering — restart the
pane. If none claims it — the lab's
heart fell to a third font before one
did (transcript `t12`) — install a font
that has it, or add one to your
`font_with_fallback` list. The tool
names the file either way.

## Exit code 101 from a healthy command

`wezterm show-keys | head` can end 101:
the reader closed the pipe, the writer
panicked on the broken pipe, and the
*config* — the thing people usually
suspect at that moment — is innocent.
Check exit codes on un-piped runs, or
write to a file first (the lab's
transcripts are files for exactly this
reason).
