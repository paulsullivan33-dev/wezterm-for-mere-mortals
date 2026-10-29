# Installing WezTerm

**Outcome: a `wezterm` program that runs
on your machine and can state its
version — before any window enters the
picture.** WezTerm has no installer
wizard to click through on Linux: the
release is an archive, you unpack it,
and the programs inside run where they
stand.

## The release download

The lab installed WezTerm
**20240203-110809-5046fc22** — the
version number is a build date, the
project's habit — from the official
releases at `github.com/wezterm/wezterm`.
For Linux the release offers, per
distribution, a `.deb` package, a
`.tar.xz` archive of the same payload,
and an AppImage. The lab took the
archive:

```bash
curl -LO https://github.com/wezterm/wezterm/releases/download/20240203-110809-5046fc22/wezterm-20240203-110809-5046fc22.Ubuntu22.04.tar.xz
curl -LO https://github.com/wezterm/wezterm/releases/download/20240203-110809-5046fc22/wezterm-20240203-110809-5046fc22.Ubuntu22.04.tar.xz.sha256
sha256sum -c wezterm-20240203-110809-5046fc22.Ubuntu22.04.tar.xz.sha256
```

```text
wezterm-20240203-110809-5046fc22.Ubuntu22.04.tar.xz: OK
```

The checksum matters more than it looks:
the file is 30 MB of other people's
code that you are about to run all day.
One detail the lab can report from its
own run: this release's newest Ubuntu
archive is the 22.04 one, and it ran
unmodified on the lab's Ubuntu 24.04
machine — Linux libraries are
forward-compatible in the direction that
counts here. A 64-bit ARM build and
Debian archives sit on the same page.

Unpacked, the archive is a small
filesystem tree (transcript
`t17-release-contents.txt`):

```text
wezterm/
  usr/bin/wezterm            the command line      (25 MB)
  usr/bin/wezterm-gui        the window            (74 MB)
  usr/bin/wezterm-mux-server the multiplexer alone (26 MB)
  usr/bin/strip-ansi-escapes a helper filter
  usr/bin/open-wezterm-here  a file-manager hook
  usr/share/…                icons, completions, desktop files
```

Nothing is installed into the system:
no package manager, no administrator
rights, and deleting the folder removes
WezTerm completely. In the lab the tree
lives at `wezterm-lab/tool/wezterm/`, so
its commands are written
`tool/wezterm/usr/bin/wezterm` there.
On your machine, put `usr/bin` on your
`PATH` or link the three programs into
`~/bin` — the guide writes plain
`wezterm` from here on.

## The check

```bash
wezterm --version
```

```text
wezterm 20240203-110809-5046fc22
```

That is the whole acceptance test for
this chapter (transcript
`t00-version-and-help.txt`, which also
holds the full `--help`). One command in
that help is worth meeting now, because
chapter 4 leans on it:

```bash
wezterm show-keys | head -3
```

shows the first of the 268 default key
assignments. One warning the lab earned
and passes on: piping `show-keys` into
`head` can end the program with exit
code 101 — a broken-pipe panic when the
pipe closes early. The output is fine;
the exit code is the pipe's fault, not
your configuration's. Chapter 13 lists
it with the other traps.

## The other ways in

The same release page carries a Windows
installer and a macOS build (also
installable with Homebrew), and the
project runs a package repository for
Debian and Ubuntu systems that prefer
`apt`. Those forms were not run by this
guide's lab — the lab is one Linux
machine with no display — and everything
after this chapter is written against
the unpacked archive on Linux. The
configuration file, the key table and
the multiplexer behave the same on the
other platforms, with the differences
(the Windows shell, WSL domains) called
out where they belong, in chapters 5
and 9.
