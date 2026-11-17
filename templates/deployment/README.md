# deployment template

A minimal deployment repository whose whole desktop comes from the dotfiles
flake. Only facts about the machine live here.

```
nix flake init -t github:niniconi/dotfiles#deployment
```

## Layout

| file | holds |
|---|---|
| `flake.nix` | the input, its `follows`, and one `nixosSystem` per host |
| `hosts.nix` | disk device, users, secrets directory, extra host modules |
| `home.nix` | what the shared home module does not know |

`home.username` and `home.homeDirectory` are derived from the key in
`hosts.nix`, so `home.nix` must not set them.

## What you have to supply

- **`hosts.nix`**: `diskDevice`, `users.<name>.home`, and `extraModules` for
  hardware, the bootloader and any activation script of your own.
- **`secrets/`** (optional): `default.nix` that sets
  `dotfiles.profiles = import ./profiles.nix;`, the `profiles.nix` itself, and
  `hosts/<host>/secrets.yaml`. Then point `hosts.nix` at it — `mkModules`
  imports `secrets/default.nix` on its own, so it must not also be listed in
  `extraModules`.

## Two things that are easy to get wrong

1. **Follow every input.** The modules run against *your* `pkgs`, so an input
   that is not followed silently resolves to a different nixpkgs than the
   dotfiles repository pins. That is why `flake.nix` lists a `follows` for
   every input the dotfiles flake has.
2. **Flakes only see git-tracked files.** A `secrets/` directory that is not
   committed is invisible to `./secrets` inside the flake source. Stage it
   while testing and keep it out of any public repository.

## The options this template feeds

`dotfiles.lib.mkModules` sets these from `hosts.nix` and from the flake
arguments; everything else is inherited from the dotfiles repository.

| option | comes from |
|---|---|
| `dotfiles.hostName` | the key in `hosts.nix` |
| `dotfiles.users` | `users` in `hosts.nix` |
| `dotfiles.diskDevice` | `diskDevice` in `hosts.nix` |
| `dotfiles.sops.*` | `secrets` in `hosts.nix` |
| `dotfiles.profiles` | your `secrets/default.nix` |

`dotfiles.timeZone`, `dotfiles.locale`, `dotfiles.xkbLayout`,
`dotfiles.stateVersion` and `dotfiles.persistencePath` keep the defaults the
dotfiles repository uses; set them in `extraModules` to override.
