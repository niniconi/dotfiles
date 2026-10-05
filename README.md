# dotfiles

自用的 Linux 系统 dotfiles。

## 目录

- [截图](#截图)
- [组件](#组件)
- [安装](#安装)
- [文档](#文档)

## 截图

<details>

![](./screenshot/Screenshot%20from%202026-10-05%2021-20-56.png)

![](./screenshot/Screenshot%20from%202026-10-05%2021-25-45.png)

![](./screenshot/Screenshot%20from%202026-10-05%2021-27-40.png)

![](./screenshot/Screenshot%20from%202026-10-05%2021-28-03.png)

![](./screenshot/Screenshot%20from%202026-10-05%2021-28-15.png)

![](./screenshot/Screenshot%20from%202026-10-05%2021-28-33.png)

![](./screenshot/Screenshot%20from%202026-10-05%2021-28-41.png)

</details>

## 组件

| 组件 | 说明 | 文档 |
|------|------|------|
| Neovim | 文本编辑器，使用原生 LSP + Mason | [文档](./doc/neovim.md) |
| Niri | 可滚动平铺式 Wayland 合成器 | [文档](./doc/niri.md) |
| Hyprland | 动态平铺式 Wayland 合成器 | [文档](./doc/hyprland.md) |
| Tmux | 终端复用器 | [文档](./doc/tmux.md) |
| Kitty | GPU 加速终端 | - |
| Ranger | 终端文件管理器 | - |

## 安装

前提：NixOS 已装好、启用 Flakes、有 root 权限。home-manager 已通过 flake 内置，无需单独安装。

```bash
# 克隆配置文件到 ~/.config/nixos
git clone https://github.com/niniconi/dotfiles ~/.config/nixos
cd ~/.config/nixos

# 构建并应用（配置名跟随 hostname 自动匹配）
sudo nixos-rebuild switch --flake ~/.config/nixos
```

> 换机器前，修改 `flake.nix` 顶部的 `userName` 和 `hostName` 为对应值。

## 文档

详细配置请查看 [doc/](./doc/) 目录。

- [Neovim 配置](./doc/neovim.md) - 插件、LSP、快捷键
- [Niri 配置](./doc/niri.md) - 快捷键、窗口管理
- [Hyprland 配置](./doc/hyprland.md) - 快捷键、窗口管理
- [Tmux 配置](./doc/tmux.md) - 快捷键、面板操作
