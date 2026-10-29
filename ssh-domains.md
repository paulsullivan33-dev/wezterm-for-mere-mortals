# SSH Domains

**Outcome: a remote machine treated as
a place your terminal can open tabs in
— not a place you visit with a separate
tool and leave.** This chapter is the
guide's most documented one: the lab's
machine had no second host it was
allowed to log into, so the commands
below are verified as far as their help
and their shape, and the connections
themselves are described from the
project's documentation and labelled
as such. The concepts are the verified
ones from chapters 2 and 6 — a domain
is where a pane runs — applied at
network distance.

## The one-off: `wezterm ssh`

```bash
wezterm ssh user@server.example.org
```

opens a window whose pane is a shell on
the far machine, over SSH, with keys,
agents and jump hosts handled by the
SSH implementation inside WezTerm. The
lab read its help closely (transcript
`t13-nodisplay-and-help.txt`): the
target is `[user@]host[:port]`, a
program can replace the shell
(`wezterm ssh user@host -- htop`), and
`-o name=value` passes ssh_config-style
options. WezTerm reads *some* of your
existing `~/.ssh/config` — its help says
"some (but not all!)" in so many words,
and the exclamation is the project's
own. Treat config support as a
convenience with edges, not a promise.

## SSH domains: the connection, kept

A one-off is a visit; a **domain** is a
residence. Declared once in the config:

```lua
config.ssh_domains = {
  {
    name = 'build-server',
    remote_address = 'server.example.org',
    username = 'alex',
  },
}
```

the machine joins the launcher's list
(chapter 7) and the domain menu of every
new tab: open a tab *in that domain*
and its shell runs over there, while
your window, fonts and keys stay home.
Chapter 2's sentence completes itself:
where a pane runs and where it is drawn
are separate choices, and a domain is
the running side, named.

## Multiplexing on the far end

An SSH domain can do the chapter 6
trick at distance. With the domain's
`multiplexing` left at its default
(`'WezTerm'`), connecting starts — or
rejoins — a **mux server on the remote
machine**, bootstrapped over the SSH
connection itself. Tabs and panes opened
in the domain live in that server:
close your laptop, reopen it tomorrow,
reconnect, and the panes are where you
left them, shells and scrollback intact.
The price, stated in the project's
documentation and worth planning for:
the far end runs WezTerm's own server
for this, so the remote machine needs
WezTerm available to it; a domain with
`multiplexing = 'None'` skips all of it
and gives a plain, honest SSH pane that
dies with the connection.

That trade — persistence for
installation — is the same one chapter
11 weighs against tmux, which has been
solving the far-end half of it for
decades with nothing but a shell
account. Neither answer is wrong; they
differ in what the far machine must
have and what your desk must learn.

## The neighbouring domains

Two more domain kinds round out the
picture, both documented-only here.
**WSL domains**: on Windows, each
installed Linux distribution appears as
a domain, so a tab can run inside WSL
while the window runs on Windows — the
same trick, across an OS boundary
instead of a network. **Serial domains**
(and the `wezterm serial` command in the
verified help): a pane connected to a
serial port, for consoles of routers,
switches and microcontrollers — the
terminal emulator remembering the
hardware it was named after.
