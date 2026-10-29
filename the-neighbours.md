# The Neighbours

WezTerm sits between two old ideas: the
terminal that only draws, and the
multiplexer that only arranges. Its
neighbours each keep one half of the
job. These are characterisations from
the projects' own documentation, not
benchmarks; the lab ran WezTerm only.

## tmux: the king across the street

tmux is the multiplexer as a way of
life: a server on a machine holds your
sessions; any terminal — a laptop's, a
phone's SSH client, a serial console —
attaches and detaches at will. It runs
everywhere Unix runs, it is scriptable
to the bolts, and it asks nothing of the
machine at the far end beyond a shell
account. If your work lives on servers,
tmux's model is the one to beat, and
this series gives it its own guide.

What WezTerm borrows from tmux is the
shape — panes, tabs (windows, there),
the prefix-key idea behind its leader.
What it cannot borrow is the context:
tmux sessions are *inside* one terminal,
so the terminal knows nothing of the
panes — the mouse negotiates, the
clipboard negotiates, fonts are one
size for every pane because there is,
to the terminal, only text. WezTerm's
multiplexer *is* the terminal, so panes
are native: real per-pane text, real
images, a font system that knows what a
pane is. The price is chapter 9's: a
remote WezTerm session wants WezTerm's
server on the far end; tmux wants
nothing the far end doesn't already
have. Plenty of people run both — tmux
on the servers, WezTerm at the desk —
and lose nothing to the contradiction.

## GNU Screen: the elder

Screen did it first: detaching sessions
before it was fashionable, on systems
where tmux will never be installed.
It is spare, ubiquitous on old iron, and
entirely sufficient for "keep this
running while I log out". This series'
own guide covers it. Against either
modern tool it is the floor, not the
ceiling — and floors are load-bearing:
when you land on a strange server at
3 a.m., Screen (or tmux) is what will
be there. WezTerm will not be, unless
you brought it.

## Alacritty and the minimalists

Alacritty is the terminal as a lens:
GPU-drawn, extremely fast, configured
in a plain file, and deliberately
*without* tabs or panes — its position
is that tmux does that job and a
terminal shouldn't. kitty keeps the GPU
and adds back tabs, splits and a plugin
system of its own ("kittens"), with a
configuration that grows like a program
because it is one. foot and st carry
the minimal flag on Wayland and X
respectively. The whole family shares
WezTerm's renderer-first instinct; they
differ in how much else they agree to
be. WezTerm agreed to be almost
everything; that is its strength and,
chapter 12 will note, its weight.

## The terminals that came with the house

GNOME Terminal and Konsole on Linux,
Terminal.app and iTerm2 on macOS,
Windows Terminal on Windows: free,
installed, integrated with their
desktops in ways third parties can't
match (notifications, profiles, system
themes). iTerm2 and Windows Terminal
are genuinely strong — profiles, splits
in both, deep platform polish. What
they don't offer is the combination
this guide is about: the same config
and the same multiplexer on all three
platforms at once, owned by you rather
than by the OS of the week. For a
one-platform life, the house terminal
plus tmux is a respectable answer; the
moving, or the multiplexing, is what
sends people shopping.

## xterm: the ancestor in the room

Every program in this chapter emulates,
at the protocol level, a DEC terminal
by way of xterm, the X11 original that
defined what the escape sequences mean.
It still runs, it is still the reference
when a sequence behaves strangely, and
its configurability-through-X-resources
is a museum of how we used to live.
WezTerm, tmux, all of them: grandchildren,
drawing faster, remembering more, and
still answering to the same old codes
when the program inside asks what a
terminal is.
