# 把本仓库当作 flake 模块使用

本仓库既是一台机器的完整配置，也是一套可以被别的 flake 消费的模块集。
私有部署仓库只需提供"关于机器的事实"，桌面本身全部来自这里。

## 导出

| Output | 内容 |
|---|---|
| `nixosModules.desktop` | NixOS 侧的桌面：选项树、sops、`hosts/common/{core,optional,packages}` |
| `nixosModules.impermanence` / `.swap` | 依赖主机布局（`/persist`）的模块，不放进 `desktop` |
| `homeManagerModules.default` | home 侧的桌面：`home/common/{core,optional}` |
| `overlays.default` | `nur` + 从 `nixpkgs-unstable` 取的编码代理（`opencode-unstable` 等） |
| `lib.mkModules` | 完整桌面：上面这些 + disko / lanzaboote / sops-nix / home-manager 接线 |
| `lib.mkDotfilesModule` | 只有选项树，给自带模块列表的配置（测试 VM、容器镜像）用 |
| `templates.deployment` | 消费者骨架，`nix flake init -t <repo>#deployment` |

本仓库自己的 `nixosConfigurations` 也走 `lib.mkModules`，所以导出接口不会被"只在自己身上
能用"的假设养坏：改坏 builder 会立刻让本机配置无法求值。

## `dotfiles.*` 选项

`lib.mkModules` 从参数生成这些选项，其余由使用方通过 `extraModules` 覆盖。

| 选项 | 默认值 | 用途 |
|---|---|---|
| `dotfiles.hostName` | 必填 | 主机名，同时用于选 `profiles` 里对应的条目 |
| `dotfiles.users` | `{}` | 用户名 → `{ home; passwordFile; }` |
| `dotfiles.diskDevice` | `""` | disko 的目标设备 |
| `dotfiles.timeZone` | `"Asia/Shanghai"` | 时区 |
| `dotfiles.locale` | `"zh_CN.UTF-8"` | 默认 locale 与所有 `LC_*` |
| `dotfiles.xkbLayout` / `.xkbVariant` | `"cn"` / `""` | X11 键盘布局 |
| `dotfiles.stateVersion` | `"26.05"` | NixOS state version |
| `dotfiles.persistencePath` | `"/persist"` | 持久卷挂载点（impermanence、swap、zsh 历史） |
| `dotfiles.sops.enable` | `false` | 是否接 sops-nix |
| `dotfiles.sops.defaultFile` | `null` | 默认 sops 文件 |
| `dotfiles.sops.format` | `"yaml"` | 默认 sops 文件格式 |
| `dotfiles.sops.ageKeyPaths` | `[]` | age 密钥来源 |
| `dotfiles.sops.materializePubKey` | `true` | 是否同时落一份 `.pub` |
| `dotfiles.profiles` | `{}` | profiles 数据（见下） |

`dotfiles.profiles` 的结构由 `modules/options.nix` 的类型定义，类型系统会在构建期拒绝
未知字段和类型错误：

```
dotfiles.profiles.<host> = {
  users.<user> = {
    git = { name; email; signingKey; };
    ssh = { authorizedKeys; hosts.<name> = { hostname; user; port; identityFile; sopsSecret; forwardX11; extraOptions; }; };
  };
  sing-box = { enable; settings; };
  wireguard = { enable; interfaces; };
};
```

消费方只有一处写入点：私有 `secrets/default.nix` 里 `dotfiles.profiles = import ./profiles.nix;`。

## 消费方要做什么

见 `templates/deployment/`。概括：

1. `flake.nix`：声明 `dotfiles` input，并让**每一个** input 都 `follows = "dotfiles/<name>"`；
   每个 host 一个 `nixosSystem { modules = dotfiles.lib.mkModules { ... }; }`。
2. `hosts.nix`：`diskDevice`、`users`、可选 `secrets` 目录、`extraModules`。
3. `extraModules`：桌面不覆盖的主机策略 —— 硬件、bootloader、root filesystem、
   NixOS 账户、activation script。

`mkModules` 只提供"桌面"，**不创建 NixOS 账户**：`dotfiles.users` 是数据，账户由主机模块
从它生成（`templates/deployment/host.nix` 是范例）。

## 踩过的坑

- **`inputs` 不能用在 `imports` 里。** `imports` 必须静态可得，只有 `specialArgs` 在
  那个阶段可用；`_module.args` 不行。所以 `inputs.impermanence.nixosModules.impermanence`
  这类导入由 `mkModules` 直接放进模块列表，`impermanence.nix` 自己不再 import 它。
- **不 follows 就等于没同步。** 模块用的是求值环境里的 `pkgs`；input 不 follows 时，
  包版本会悄悄变成使用方自己 pin 的那套。
- **flake 只看得见 git 跟踪的文件。** 未提交的 `secrets/` 对 `./secrets` 不存在，
  本地测试时得 `git add -f`，因此也离"误提交真实密钥"只有一步。`.gitignore` 里有
  `secrets/`，测试完记得 `git restore --staged secrets/`。
- **`home.packages` 的顺序取决于模块收集顺序。** 同一批包、不同顺序会得到不同的
  `home-manager-path` 派生路径。让自用配置改走 `mkModules` 时，五个配置的 drvPath 都因此
  变化过一次，而 `environment.systemPackages` 的集合完全没变。
- **`home.username` / `home.homeDirectory` 由 `mkModules` 生成**（`mkDefault`），
  用户的 `home.nix` 不要写它们。
- home 模块通过 `osConfig.dotfiles.*` 读 NixOS 侧的值，因此 home-manager 必须以
  NixOS 模块的方式使用（`useGlobalPkgs = true`），独立 home-manager 不支持。
