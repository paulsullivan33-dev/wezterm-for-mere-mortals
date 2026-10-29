# Limits

What WezTerm cannot do, stated plainly.
Most of these the lab met directly; the
rest are labelled as documentation.

**A broken config can fail silently.**
The command-line tools fall back to the
defaults without a word when the config
has an error — no message, exit code 0
(chapter 5, transcripts `t06`/`t07`).
Only the window reports the error. Any
script that trusts `show-keys` or
`ls-fonts` to prove a config is healthy
is trusting a witness who has sworn to
say nothing.

**The window wants a graphics stack.**
No display, no window — the program
says so and exits 1. On a display, the
GPU path wants its libraries; the lab's
window refused to open over a missing
`libEGL.so.1` until software-rendering
libraries were fetched by hand
(transcripts `t08`, `t14`). The software
front end widens the door; it does not
remove the wall. A terminal for a
bare server console, WezTerm is not.

**Sessions live and die with their
server.** The multiplexer's panes are
as durable as the mux process: across
your lunch, across your laptop closing
(if the server is elsewhere), but not
across the server's reboot or death.
There is no built-in resurrection of a
layout after the machine restarts.
tmux shares this limit exactly; both
tools' answer is "run the server
somewhere that stays up", and chapter 9
is where that answer costs an install.

**The multiplexer socket is a
master key.** Whoever can write to the
mux socket in your runtime directory
can read your panes and *type into
them* — the lab did both with `cli
get-text` and `cli send-text`, as the
user who owns them. That is by design
(it is a remote control), and the
socket is per-user; but treat any
process running as you as already
inside your terminals, because it is.

**It is one big program.** 125 MB of
binaries for the three executables;
a config API large enough that this
guide teaches a fraction of it; and a
release pace set by essentially one
author's project. The depth is the
feature — and the dependency is real.
The escape hatch is that the config
file is yours, in plain text, and the
defaults (all 268 bindings of them)
are a complete terminal without it.

**The lab's limits, restated as the
guide's.** What WezTerm feels like at
speed — input latency, scroll
smoothness on a real GPU, colour
judgement, the macOS and Windows
builds, WSL and serial domains in the
flesh — is documented-only in this
guide (see `criteria.md`). A guide
that proved everything except the
looking should not be caught grading
the view.
