# dotfiles

自用的 Linux 系统 dotfiles。

## 目录

- [截图](#截图)
- [组件](#组件)
- [安装](#安装)
- [文档](#文档)

## 截图

<details>
  <summary>neovim</summary>
  
  1. startup界面
  
  ![startup](./screenshot/Screenshot%202023-01-15%2002-41-50.png)
  
  2. 内嵌终端
  
  ![terminal](./screenshot/Screenshot%202023-01-15%2002-42-53.png)
  
  3. LSP
  
  ![lsp](./screenshot/Screenshot%202023-01-15%2002-42-32.png)
  
</details>
<details>
  <summary>ranger</summary>
  
  ![](/screenshot/Screenshot%202023-01-15%2002-40-19.png)
  
  ![](/screenshot/Screenshot%202023-01-15%2002-40-37.png)
  
  ![](/screenshot/Screenshot%202023-01-15%2002-41-06.png)
  
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
