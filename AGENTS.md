# AGENTS.md

NixOS flake dotfiles. Sources of truth: `flake.nix` (outputs), `hosts/hosts.nix`
(host manifest), `modules/` (profile options, validation, sops).

## Branches

`master` is the only long-lived line and owns the whole repository. There is no second
permanent line and no path-ownership split.

- Short tasks commit straight on `master`.
- Long-running work gets a `feature/<module>/<feature>` branch, e.g. `feature/neovim/lsp`,
  `feature/packages/media`. Merge it back into `master` and delete the branch when it is
  done — a feature branch carries one piece of work, it never becomes a second home for a
  module.
- **Ask the user before creating a branch**, and before switching to one.
- Before editing, run `git branch --show-current`.

Renaming or deleting these breaks the build, because home-manager resolves them by path:

- `hyprland/`, `kitty/`, `niri/`, `ranger/`, `tmux/`, `neovim/` — each is deployed by the
  matching `home/common/optional/<name>.nix` via `xdg.configFile."x".source = ../../../<dir>`.
- `hosts/common/packages/dev/lsp.nix`, `hosts/common/packages/dev/lua.nix` and
  `home/common/optional/neovim.nix` — imported by `hosts/common/packages/dev/default.nix`
  and `home/nixos/administrator/home.nix`. Adding, renaming or removing one needs the
  matching change to the importer in the same commit.

## Layout gotchas

- Raw dotfile dirs live at repo root (`kitty/`, `neovim/`, `niri/`, `tmux/`, `ranger/`,
  `hyprland/`, ...) and hold the XDG directory verbatim, so `niri/config.kdl` is
  `~/.config/niri/config.kdl`. home-manager deploys them via
  `xdg.configFile."x".source = ../../../<dir>` in `home/common/optional/*.nix`.
  Deleting or renaming those dirs breaks the build — see Branches. Note the repo dir name
  is not always the XDG one: `hyprland/` lands on `hypr`, `neovim/` on `nvim`.
- `chromium/`, `gtk/`, `dms/`, `termux/`, `wallpaper/` and `doc/` are not deployed by any
  module. The first four are kept as the source of record for settings that no NixOS module
  installs; `doc/` is Chinese prose that `README.md` links to.
- **Generated output does not belong in this repository** — home-manager deploying a file there
  takes the path, and the generator can no longer write its own. dms-shell writes
  `neovim/lua/plugins/dankcolors.lua`, `niri/dms/`, `kitty/dank-theme.conf`,
  `kitty/dank-tabs.conf` and `hyprland/dms/`; leave every one of those paths empty.
- `README.md` is partly stale: it says to edit `userName`/`hostName` at the top of
  `flake.nix`. The real values live in `hosts/hosts.nix` (`diskDevice`,
  `users.<name>.{home,passwordFile}`); `hostName`/`userName` are derived in `flake.nix` from the
  `"<user>@<host>"` configuration keys and passed in through `specialArgs`. Trust code over docs.
- Only `ranger/plugins/ranger_devicon` is a real git submodule. `.gitmodules` still lists
  removed zsh/powerlevel10k entries (prompt moved to starship) — stale, ignore. `git mv` does
  not update the submodule's section name in `.gitmodules`, only its `path`.
- `.stylua.toml` (2-space, 120 cols) applies to Lua under `neovim/`.

## Flake outputs

| Output | Meaning |
|---|---|
| `nixosConfigurations."administrator@nixos"` | single-user deploy of host `nixos` |
| `nixosConfigurations.nixos` | whole host (all users) |
| `nixosConfigurations.nixos-oci` | the desktop as a container filesystem |
| `nixosConfigurations.nixos-vm` | standalone QEMU test VM |
| `nixosConfigurations.nixos-vm-mini` | the same VM without `oversizedPackages` |
| `templates.flutter` | `nix flake init -t ...#flutter` |

- Only the two host configs import `disko`, `lanzaboote`, `sops-nix` and
  `modules/{options,validation,sops}.nix`.
- `specialArgs` differ: host configs get `inputs profiles hostName users diskDevice`; the
  VM and image get only `inputs profiles hostName`, so a module either of them imports must
  not reference `users` or `diskDevice`.
- **`hosts/nixos-vm` must stay standalone**: importing `hosts/nixos` hardware (disko,
  tmpfs root, LUKS) collides with build-vm's `mkVMOverride` on `fileSystems` and bricks boot
  ("Failed to start Switch Root"). VM user login is `administrator` / `test`.
- `hosts/nixos-vm-mini` cannot reuse `hosts/nixos-vm` the way it used to: NixOS modules
  accumulate, so a host file cannot import another and then drop part of what it pulled in.
  The two are separate directories that happen to agree.
- home-manager `extraSpecialArgs` are set in `flake.nix`: `hostName`, `profiles`, plus `userName`
  in the per-user block.

## Packages

`hosts/common/packages/` holds nine group directories plus four loose modules a host may take
independently:

| Module | What it is |
|---|---|
| `default.nix` | every group at once, for a host that wants everything |
| `nixpkgs-config.nix` | `allowUnfree` and the rest of the nixpkgs policy |
| `fonts.nix` | the CJK and monospace faces |
| `oversized.nix` | packages behind `oversizedPackages.enable` |

A host picks its groups by importing the directories it wants and the loose modules it wants;
there is no flag that turns groups off from the inside. `hosts/nixos` and `hosts/nixos-vm` take
`default.nix` and so stay a superset of everything.

Two options let a host deviate without editing a group:

- `oversizedPackages.enable` (default `true`, declared in `oversized.nix`) drops the
  heavyweight desktop applications. `nixos-vm-mini` sets it `false`. It also gates
  `virtualisation.libvirtd.enable`, because that daemon reaches `pkgs.libvirt` through a
  store path in its systemd environment — leave the packages without it and libvirt stays in
  the closure anyway.
- `aiCodingAgents.channel` (`"stable"` or `"unstable"`) picks which nixpkgs builds the coding
  agents come from. `"stable"` is the pinned `nixpkgs`; `"unstable"` is a second flake input
  exposed through an overlay as `opencode-unstable` and `pi-coding-agent-unstable`. The VMs
  and the image track `"unstable"`, the desktop stays on `"stable"`.

## Secrets

- Repo builds with no `secrets/` at all: the flake falls back to empty profiles when
  `builtins.pathExists ./secrets/default.nix` is false, and `modules/sops.nix` is gated with
  `lib.mkIf hasSecrets`. The real `secrets/` tree is never committed;
  `secrets.samples/` is the tracked template.

## Commands

```bash
statix check .      # lint (exit 0 expected)
deadnix .           # unused bindings (exit 0 expected)
nixfmt <nix files you touched>
stylua <lua files you touched>
git diff HEAD       # review before commit
```

Required order before every commit: **statix -> deadnix -> nixfmt -> stylua -> git diff HEAD -> ask the user how to commit -> commit**.

- When adding/changing software, verify the attribute against the flake's **pinned** nixpkgs,
  not the registry: `nix eval --raw .#nixosConfigurations.<config>.pkgs.<pkg>.pname` (or
  `.version`; `.pkgs.path` prints the pinned nixpkgs source; that `pkgs` is the pinned nixpkgs
  plus the NUR overlay). `<config>` is any of the `nixosConfigurations` keys above. Flake
  references need `--extra-experimental-features 'nix-command flakes'` unless the host enables
  flakes in `nix.conf`.
  The registry `nixpkgs#...` can be far ahead (dms-shell: registry 1.6.2 vs pinned 1.4.6) and
  already caused a real incompatibility. For discovery by keyword: `nix search nixpkgs <regex>`
  (e.g. `nix search nixpkgs remmina`; needs network and is slow — it enumerates legacyPackages.
  Note `nix search nixpkgs#<term>` errors: a regex arg is mandatory). Package names are often
  non-obvious (`apostrophe`, `freerdp` -> binary `xfreerdp3`, `kdePackages.*`), and an agent
  may be under a longer name than its command (`pi-coding-agent` provides `pi`).
- Fixed-output derivations (`fetchFromGitHub`): leave a fake hash, run the build, copy the `got:`
  hash from the error. For plain `.nix` files use `nix-build <file>` (`nix build` requires a flake
  path). `postFetch` globs in a FOD are unreliable — lift monorepo subdirs with a `runCommand`
  that copies the subdir to the root (example: `hosts/common/optional/dms.nix`).
- No CI, no task runner, no test suite — lint + eval is the whole verification story.
- Eval targets — pick by what you touched:
  - `nix eval .#nixosConfigurations.nixos-vm.config.system.build.vm.drvPath` for the VM. It does
    **not** import `modules/{options,validation,sops}.nix`, so it cannot catch errors there. Use
    `system.build.vm`, **not** `toplevel`: the VM declares no root filesystem (by design), which
    trips nixpkgs' "fileSystems does not specify your root file system" assertion. Both
    VMs fail that one by design, so read past it and judge the rest of the output.
  - `nix eval .#nixosConfigurations.nixos.config.assertions --apply 'xs: builtins.all (x: x.assertion) xs'`
    for the host path, including `modules/validation.nix` assertions. The same works for
    `nixos-oci`, which has no validation assertions of its own.
- Build tests: `nh os build-vm .#nixos-vm` (or `nixos-rebuild build-vm --flake .#nixos-vm`),
  and `nh os build-image --image-variant oci --hostname nixos .#nixos-oci` for the image, which
  you then run with `docker run -it nixos-oci bash`.
- Tools ship with the config: `statix`/`nixfmt`/`deadnix` in
  `hosts/common/packages/system/nixos.nix`, `stylua` in `hosts/common/packages/dev/lua.nix`. On
  non-NixOS: `nix profile install nixpkgs#statix nixpkgs#deadnix nixpkgs#nixfmt` (binaries in
  `~/.nix-profile/bin`; `statix` has no `--version`, use `statix --help`).

## Neovim / LSP

- Language servers come from `hosts/common/packages/dev/lsp.nix`; per-server commands live in
  `neovim/lua/lsp/<server>.lua`. Dart is the exception — `dartls.lua` reaches the Dart SDK
  through `fvm` even though nixpkgs packages `dart`. Never add a mason-installed server.
- `vscode-langservers-extracted` and `yaml-language-server` need an explicit `--stdio`; without it
  the server starts, throws "Connection input stream is not set" and exits 1, so Neovim reports no
  active client.
- `:checkhealth vim.lsp` only proves a client was created. Verify with a real request
  (`vim.lsp.buf_request`) or the editing feature you actually need, and read
  `~/.local/state/nvim/lsp.log` for server stderr.
- Neovim plugin versions are intentionally unlocked — do not generate `lazy-lock.json`.

## dms-shell

- Plugin revs (`hosts/common/optional/dms.nix`) must satisfy both the plugin's `requires_dms`
  and the pinned dms-shell version, which you can read with
  `nix eval --raw .#nixosConfigurations.nixos-vm.pkgs.dms-shell.version`. Re-audit the plugin
  source on every bump.
- After a rev bump verify the *content* that landed on the host, not just that the path exists.
  A stale install shows up as `"<Type> is not a type"` QML errors: check
  `grep '"version"' /etc/xdg/quickshell/dms-plugins/DankKDEConnect/plugin.json` and
  `journalctl --user -u dms -b | grep -iE 'component error|dankKDE'`, then `dms restart` (or
  `systemctl --user restart dms`) and re-enable the plugin in the UI.

## Commits

- After the lint/format chain and `git diff HEAD`, **ask the user how to commit before
  committing**, batching both questions into one message:
  - new commit, or amend/reword an existing one
  - the final commit message
- Propose a ready-to-use conventional-commit message (scope = affected dir) so the answer can
  be a single "yes".
- Without an explicit answer, run neither `git commit` nor `git commit --amend` — never amend
  on your own initiative.
- Once answered, do exactly that: no extra commits, no rewritten wording.
- Stage only the files this change touches; never `git add -A` (untracked scratch files and
  `secrets/` must stay out).
- Don't re-ask what the rules already settle (lint, formatting, message convention) — only the
  two decisions above.
- If the form was already stated earlier in the conversation, do not ask again — only ask what
  is still undecided.
- If there is nothing to commit, do not ask.
- If the user answers only one of the two questions, ask only the remaining one.
- The message body must not count things or enumerate them: no "three headers named X", no
  list of the affected paths, no per-item summary. Counts rot the moment a follow-up commit
  touches the same files, and a reader with `git show` can get the exact list in one command.
  Describe the *kind* of problem instead ("several header comments named a file that does not
  exist"), and name paths only where they locate the problem. Same rule as the one on
  comments, for the same reason: `git show` already spells out what changed.

## Conventions

- Comments/messages in **English only**. Conventional commits
  (`feat(scope):`, `fix(...)`, `style:`), scope = affected dir (`packages`, `nixos-vm`, ...).
- Every comment must earn its place in the *final* file: after each edit, re-read the
  surrounding block and delete comments that restate the code, explain an entry you just
  removed, or duplicate the schema/other docs. Keep only non-obvious *why* (upstream quirks,
  deliberate deviations, footguns) — and put that "why" where the deviation lives, not next
  to a list it no longer belongs to.
- Never enumerate in a comment what the adjacent code already spells out: no
  "subcategories: a, b, c" header above the matching `imports` list, no listing the gated
  groups next to the `imports` that gate them, no naming the keys of an attrset in the
  comment above it. A duplicate list is a second thing to keep in sync and it silently
  rots — the `subcategories` lines had already drifted out of date in four of six groups.
  Name *what* something is for, or *why* it is the way it is; leave *which items* to the
  code. Describing what is deliberately **absent** is fine, since absence is not readable
  from the code.
- statix rules the style: merge repeated attr keys into one nested attrset
  (`boot.a`/`boot.b` -> `boot = { a; b; }`), empty module pattern `{ ... }:` -> `_:`,
  `x = x;` -> `inherit x;`. deadnix: drop unused lambda args or prefix `_`
  (`mapAttrs (_: _: ...)`).
- `modules/options.nix` and `modules/validation.nix` are coupled: validation checks
  hand-written `valid*Fields` string lists, not the option definitions. Adding,
  renaming or removing an option in `options.nix` means updating the matching
  whitelist in `validation.nix` **in the same commit**, otherwise a valid profile
  field is rejected by the "Unknown fields" assertion. Mapping: `sshHostSubmodule`
  -> `validSshHostFields`, `singBoxSubmodule` -> `validSingBoxFields`,
  `wireguardSubmodule` -> `validWireguardFields`, `git`/`ssh` under
  `userProfileSubmodule` -> `validGitFields`/`validSshFields`, `hostProfileSubmodule`
  -> `validHostFields`. The assertion is skipped when `profiles` is empty (no
  `secrets/`), so exercise it with a real `profiles.nix`.
- Nix tooling (statix, nixfmt, deadnix) belongs only in
  `hosts/common/packages/system/nixos.nix` — don't split it out.
- packages are grouped by use case under `hosts/common/packages/*/`; duplicates across
  groups are intentional (independent toggling).
- Don't add packages the user didn't ask for.
- Repo is fully nixfmt-formatted — only format files you touched, never bulk-reformat.
