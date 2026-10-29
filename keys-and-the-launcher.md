# Keys and the Launcher

**Outcome: the default key table read
and understood, two bindings of your own
added and *proved* added, and the two
menus — palette and launcher — that make
the rest of the keyboard optional.**

## The table that is already there

WezTerm ships with 268 default key
assignments, and it will print them:

```bash
wezterm show-keys
```

The highlights (all from the lab's
capture, transcript `t03`):

| Keys | What happens |
| --- | --- |
| Ctrl+Shift+C / Ctrl+Shift+V | copy / paste |
| Ctrl+Shift+T | new tab |
| Ctrl+Shift+N | new window |
| Ctrl+Shift+P | command palette |
| Ctrl+Shift+F | search the scrollback |
| Ctrl+Shift+X | copy mode (keyboard-driven selection) |
| Ctrl+Shift+L | debug overlay |
| Ctrl+Shift+U | character selector (emoji and symbols) |
| Ctrl+Shift+Z | zoom the current pane |
| Ctrl+Tab / Ctrl+Shift+Tab | next / previous tab |
| Ctrl + / Ctrl − / Ctrl 0-ish | font size up, down, reset (`+`, `-`, `)`) |
| Alt+Enter | full screen |

Two honest notes. The table is long
because it also binds the keypad, mouse
actions and the shifted twins of most
combinations (Ctrl+Shift+C and Ctrl+C
both copy, on the default table). And
one commandment falls out of chapter 3:
never pipe this into `head` and judge
the exit code — a closed pipe ends the
program at 101, which is the pipe's
verdict, not the table's.

## Adding your own

Bindings are a list in the configuration
file, and they *add to* the defaults —
yours win where they collide. The lab's
config (kept at `wezterm-lab/configs/good.lua`)
added exactly two:

```lua
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
```

An entry is three facts: the `key`, the
`mods` it needs (`CTRL`, `SHIFT`, `ALT`,
`SUPER`, joined with `|`), and the
`action` — a value from the
`wezterm.action` family, some of which
take arguments in braces, as
`SplitHorizontal` takes its domain.

And here the lab's favourite check
returns: you do not have to take the
file's word that the bindings loaded.
Point `show-keys` at the config and
count:

```bash
wezterm show-keys | wc -l                        # 268
wezterm --config-file good.lua show-keys | wc -l # 270
```

268 + your 2 = 270, and the F9 line is
there to be read (transcript `t07`).
Chapter 5's warning rides along: if the
file is *broken*, the count quietly
stays 268 — the check proves presence,
and its failure mode is silence, so a
missing binding means "read the
window's error output", not "type it
again louder".

`wezterm show-keys --lua` prints the
table as Lua statements — the fastest
way to steal a default binding's exact
spelling into your own file.

## The leader key

For bindings you want in families —
all your pane moves under one prefix —
the config can declare a **leader**: a
key that arms the next one.

```lua
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
```

Press Ctrl+A, release, and within the
timeout the next key is read as a
leader binding (`key = 'h', mods =
'LEADER'`). It is the tmux prefix idea,
borrowed openly. There is no leader by
default; the lab describes this from
the documentation and did not bind one.

## The palette and the launcher

Two menus sit above the table:

**Ctrl+Shift+P — the command palette.**
A searchable list of the actions
WezTerm can take in this moment: type a
few letters, press Enter. It is the
answer to "which key did they bind that
to?" being *none of your business any
more* — and it is verified above, in the
default table's own line.

**The launcher** is the palette's
outward-facing sibling: a menu of
things to *start* — new windows in each
domain (chapter 9's SSH machines appear
here), workspaces, shells. It opens from
the palette, from the window's
right-click menu, or from a binding you
give the `ShowLauncher` action. The
debug overlay (Ctrl+Shift+L) deserves
its sentence too: it is where the GUI
shows its log and your config's
identity — the first place to look when
chapter 13 sends you hunting.

Beyond the default table there are
named **key tables** for the modes —
copy mode has its own, search has its
own — and `config.key_tables` can add
yours. The lab read those from the
documentation; the default table and
the two added bindings are its
transcripts' ground.
