# The Configuration File

**Outcome: a `wezterm.lua` of your own —
found, read live by the running
terminal, and written so that when it
breaks (it will) you know exactly where
the error will and will not be
reported.** This is the chapter the rest
of the guide stands on, because every
later chapter is, at bottom, a line in
this file.

## Where the file lives

WezTerm looks for its configuration in a
fixed order. The ones that matter:

- the file named by `--config-file` on
  the command line, or by the
  `WEZTERM_CONFIG_FILE` environment
  variable — the override, used by this
  guide's lab throughout;
- `~/.config/wezterm/wezterm.lua` — the
  standard home on Linux and macOS (the
  `$XDG_CONFIG_HOME/wezterm/` folder,
  when that variable is set);
- `~/.wezterm.lua` — the older, simpler
  home, still honoured.

The lab proved the standard location
the definitive way: it planted a
deliberately broken file at
`~/.config/wezterm/wezterm.lua`, started
the GUI with no override, and the error
message named that exact path (transcript
`t16-default-location-and-reload.txt`).
On Windows the same two homes exist
under your user profile. No file at all
is also a valid state: WezTerm runs on
its built-in defaults, which is how
chapters 3 and 4 worked.

## The shape of the file

```lua
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font_size = 14.0
config.color_scheme = 'Builtin Solarized Dark'
config.window_background_opacity = 0.95

return config
```

Read it as a tiny program with a
contract. `require 'wezterm'` loads the
API the terminal offers the file.
`wezterm.config_builder()` makes an
empty configuration object that *checks
what you put in it* — chapter 5's error
story below is largely the builder doing
that job. Lines like `config.font_size =
14.0` set fields. The last line hands
the table back: no `return`, no config.

The lab's own working config is kept at
`wezterm-lab/configs/good.lua` — the one
above plus two key bindings (chapter 7)
— and everything this guide claims about
configuration was run against it or
against its three broken siblings.

## Live reload: edit, save, look

A running WezTerm watches its config
file. Save a change and the window
applies it — no restart, usually within
a second or two. The lab verified the
reload in the rudest way available:
mid-run, it replaced a good config with
a broken one, and the terminal reported
the new file's error about two seconds
later, unprompted (transcript `t16`).
Reload is what makes configuring
WezTerm pleasant: the feedback loop is
*edit, glance*, not *edit, restart,
remember what you changed*.

It also means a bad save announces
itself in the window immediately. Which
raises the question this chapter exists
to answer: announced *how*, exactly?

## A tale of two failures

The lab broke its config three ways:
a **syntax error** (a line cut in half),
a **runtime error** (a call to a
function that does not exist), and a
**type error** (`font_size` set to the
string `'enormous'`). Then it asked both
faces of WezTerm what happened.

**The window tells you.** Starting the
GUI with the syntax-broken file prints,
and shows:

```text
ERROR  mux::connui > Configuration Error: syntax error: [string "configs/broken-syntax.lua"]:4: unexpected symbol near 'return'
```

File, line, and the offending symbol.
The type error is better still — the
config builder names the field, the
expected type, the value it got, and a
traceback to the exact assignment:

```text
ERROR  mux::connui > Configuration Error: error converting Lua table to Config (Config::from_dynamic: Error processing Config::font_size: Cannot convert `String` to `f64`.
{
    "font_size": "enormous",
})
stack traceback:
	[C]: in metamethod 'newindex'
	[string "configs/broken-type.lua"]:3: in main chunk
```

(Transcripts `t15-xvfb-broken-config.txt`.)
In both cases the window still opens,
running on the built-in defaults: a
broken config degrades WezTerm, it does
not stop it.

**The command line does not tell you.**
The same broken files, handed to
`wezterm show-keys` — a command whose
whole job is to report the configuration
in force — produce the full default key
table, exit code 0, and *nothing* on
standard error (transcripts `t06` and
`t07`). A missing config file gets the
same silent treatment. The lab proved
the silence was fallback and not
blindness by contrast: with the good
config, the table grew from 268 lines to
270 — the lab's two custom bindings,
present and correct. With a broken one,
268, indistinguishable from no config
at all.

## Working habits the fork teaches

1. **Judge a config by the window, not
   the CLI.** When a setting seems
   ignored, start a window and read its
   first seconds of output — that is
   where configuration errors live.
2. **Change one thing at a time.** Live
   reload makes the loop cheap; a bad
   edit names itself before the next
   one lands.
3. **Keep the builder.** A config made
   with `config_builder()` reports
   misspelled fields and wrong types
   with the messages above. A plain Lua
   table gives up most of that checking.
4. **Keep a known-good copy.** The
   defaults are a safe landing, but your
   last working file is a better one.

Two command-line switches complete the
picture. `--config name=value` overrides
a single field for one run
(`wezterm --config font_size=20 start`),
and `-n` / `--skip-config` ignores the
file entirely — the fastest way to ask
"is it my config?" when something looks
wrong. The lab used both while
calibrating its transcripts.
