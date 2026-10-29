# Writing criteria for this guide

Every "for Mere Mortals" guide is written to the same nine-point
standard, so a reader who trusts one can trust the rest. Here it
is, with the verification notes for this particular guide below.

1. **Fix it first.** Reader outcomes lead, not action items: each
   chapter opens by naming the outcome it delivers, shows a check
   the reader can run to confirm they got it, and a reasonable
   reader finishes able to state what was done, what it means,
   and what to try next.
2. **Plain language.** Short sentences, everyday vocabulary,
   technical terms defined on first use. No slang, and no
   idioms that only make sense in one country — the reader may
   be translating as they go.
3. **No dead ends.** A guide never tells the reader to do
   something it cannot show them how to verify. Every claim a
   reader relies on — an install, a command, an output — is
   something this guide demonstrates or clearly labels
   documented-only below.
4. **Live-verified where it matters.** Procedures are run for
   real in the guide's lab wherever the build machine allows it,
   and the transcripts kept in the repository are the evidence.
   What could not be run is listed honestly below, never
   presented as if it had been.
5. **General audiences.** Nothing in this guide — examples,
   fixtures, names, addresses — is modelled on any particular
   reader or author's real life, network, or organisations.
   The lab's configurations are stock shapes and its example
   hosts are example hosts.
6. **Standalone.** A reader needs this guide, its lab, and
   nothing else. Where another guide would genuinely help, it
   is pointed to once, by name, and the chapter still completes
   without it.
7. **Honest about limits.** Chapter 12 names what the tool
   cannot do: silently swallowed config errors on the command
   line, a window that needs a display and a graphics stack,
   sessions that end with their multiplexer, a per-user socket
   that is a master key to your panes, and the weight of one
   large program.
8. **The ethics rule is in the text, early.** A configuration
   file is executable code, and chapter 5's habits say so in
   effect from the start: only use a `wezterm.lua` you have
   read, because Lua config can run programs. Chapter 12 adds
   the matching fact for the multiplexer — anything that can
   write to its socket can read and type into your terminals —
   stated where the feature is taught, not buried.
9. **Builds clean.** The site builds with MkDocs in strict mode
   with no warnings, and a fresh reader following the chapters
   in order reaches the stated outcome of each.

## Verification notes for this guide

The build machine is an Ubuntu 24.04 sandbox with **no
display** — the defining constraint of this lab, stated here
as plainly as the guide states it in chapter 1. WezTerm
**20240203-110809-5046fc22** (the current stable release) was
downloaded from the project's official GitHub releases as the
Ubuntu 22.04 `.tar.xz` — this release's newest Ubuntu archive;
it ran unmodified on 24.04 — and its SHA-256 was checked
against the project's published checksum before anything ran
(transcript `t17`). All transcripts live in
`wezterm-lab/transcripts/`; the configuration fixtures (one
good, three deliberately broken, one font variant) live in
`wezterm-lab/configs/`.

The sandbox also shares its package manager with other work,
and system installation of the Mesa graphics libraries was
blocked by lock contention and stale package lists. The lab
therefore fetched the library `.deb` files directly from the
Ubuntu archive, unpacked them into the lab folder, and used
them only via `LD_LIBRARY_PATH` for the GUI runs. Nothing was
installed system-wide, and that detour is part of the record,
not hidden by it.

Run for real, with transcripts as evidence:

- Version and the full top-level help — every subcommand
  named in chapter 2 (t00); the release archive's contents
  and the three binaries' sizes; the checksum match (t17).
- `ls-fonts` headless: the default fallback chain (built-in
  JetBrains Mono, system Noto Color Emoji, built-in Symbols
  Nerd Font Mono) and the bold/italic rule blocks (t01).
- `show-keys` headless: the full 268-line default table
  (t03), including every default binding quoted in chapters
  6 and 7.
- Configuration loading via the CLI: the lab's good config
  grows the key table 268 → 270 with its two bindings present
  (t04, t07); `--config font_size=20` overrides parse (t04).
- Configuration failure via the CLI: syntax-, runtime- and
  type-broken configs — and a missing file — all produce the
  untouched default table, exit 0, empty stderr (t05, t06).
- The multiplexer headless: `wezterm-mux-server --daemonize`
  on a display-less machine; `cli list`, `cli spawn` (new tab,
  pane id returned), `cli split-pane` (layout reported as
  80×11 over 80×12), `cli get-text` reading both marker
  strings back, `cli send-text` typing a command whose text
  was read back from the target pane, `cli kill-pane`
  healing the survivor to 80×24 (t09, t10, t11). The
  `--pane-id` error for a targetless spawn is quoted from
  t09; `cli spawn --help` and `cli split-pane --help`
  (for `--cwd` and `--percent`) are t18.
- Fonts per glyph: `ls-fonts --text` and `--codepoints`,
  including U+2764 falling back from the built-in font to a
  system DejaVu file, named to the path; a config choosing
  DejaVu Sans Mono reorders the chain with JetBrains Mono
  kept as fallback (t12).
- No display at all: `wezterm start` exits 1 with the
  XOpenDisplay message quoted in chapters 4 and 13 (t13).
- The GUI under Xvfb (a virtual 1280×800 screen): first
  refused with the `libEGL.so.1` failure quoted in chapters
  4 and 13 (t08); then, with the Mesa software libraries
  present, the window opened under software rendering and
  the program inside its pane ran and wrote its proof file
  (t14).
- Config errors in the GUI: the syntax and type errors
  reported at startup with file, line and (for the type
  error) the offending value and traceback (t15).
- The default config location, proved by planting a broken
  file at `~/.config/wezterm/wezterm.lua` and reading its
  path in the GUI's error; live reload, proved by breaking
  the config under a running GUI and timing the error's
  arrival at about two seconds (t16).
- The broken-pipe exit: `show-keys | head` ending 101 while
  the un-piped run ends 0 (t13, rechecked after the table
  was regenerated in full for t03).

Documented only — described from the project's documentation,
not run, and the text does not claim otherwise:

- Everything a window *looks like*: colour judgement,
  opacity's effect, cursor and tab-bar manners, scroll
  smoothness, input latency, and GPU performance in any
  form. The GUI ran under software rendering on a virtual
  screen and proved function, never appearance.
- Interactive keyboard use of the GUI — copy mode, search,
  the palette and launcher as experiences; their bindings
  are verified in the table, their use is not.
- SSH connections of both kinds (the `wezterm ssh` help was
  read in full, t13; no remote host was available to the
  lab), SSH-domain multiplexing on a far machine, WSL and
  serial domains, and `wezterm connect` to a unix domain.
  The standalone mux server that chapter 6 drives is the
  same code on the local machine; the network forms are
  documentation.
- `wezterm record`/`replay` beyond their help text (t13),
  image display via `imgcat`, the leader key (no leader was
  bound in the lab), named key tables beyond the default,
  `font_rules` overrides, and the Windows and macOS builds
  and installers.
- The neighbour tools of chapter 11 (tmux, GNU Screen,
  Alacritty, kitty, the platform terminals, xterm) —
  characterised, not run or benchmarked here.

Fixtures are this guide's own and deliberately generic: a
starter configuration with a font size, a scheme name and
two key bindings; three broken variants of it (a line cut in
half, a call to a function that does not exist, a number
field given a word); marker strings echoed by throwaway
panes; and one example SSH host (`server.example.org`, a
fictional user) that exists only in chapter 9's config
snippet. No real machine, account or network appears
anywhere in the guide or the lab.
