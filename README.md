# dotfiles

自用的linux系统的dotfiles

配置文件包括了:neovim + zsh + tmux + ranger + hyprland + waybar + wallpaper

### screenshot

<details>
  <summary>neovim</summary>
  
  1. startup界面
  
  ![startup](./screenshot/Screenshot%202023-01-15%2002-41-50.png)
  
  2. 内嵌终端
  
  ![terminal](./screenshot/Screenshot%202023-01-15%2002-42-53.png)
  
  3. coc lsp
  
  ![lsp](./screenshot/Screenshot%202023-01-15%2002-42-32.png)
  
</details>
<details>
  <summary>ranger</summary>
  
  ![](/screenshot/Screenshot%202023-01-15%2002-40-19.png)
  
  ![](/screenshot/Screenshot%202023-01-15%2002-40-37.png)
  
  ![](/screenshot/Screenshot%202023-01-15%2002-41-06.png)
  
</details>

### neovim

添加了如下快捷键，以下快捷键都是Normal模式下的,`<leader>` 为空格

|快捷键     |命令                  |介绍        |
|----------|---------------------|------------|
|<leader>x |:wq                  |保存关闭    |
|<leader>q |:nvimtreeclose       |关闭nvimtree|
|<laeder>n |:nvimtreeopen        |打开nvimtree|
|<leader>t |:floatermnew         |打开终端     |
|<leader>ff|:telescope find_files|文件搜索     |
|<leader>rn|                     |重命名变量   |
|<leader>l |                     |到行尾      |
|<leader>h |                     |到行首      |

### hyprland

|快捷键            |介绍        |
|------------------|------------|
|SUPER + M         |退出Hyprland|
|SUPER + F         |窗口内全屏  |
|SUPER + SHIFT + F |全屏        |

### install

使用以下命令安装，后字体需手动安装
```bash
sh -c "$(wget https://raw.githubusercontent.com/niniconi/dotfiles/master/install.sh -O -)"
```

#### NixOS 方式（Flake + home-manager）

前提：NixOS 已装好、启用 Flakes、有 root 权限。home-manager 已通过 flake 内置，无需单独安装。

```bash
# 克隆配置文件到 ~/.config/nixos
git clone https://github.com/niniconi/dotfiles ~/.config/nixos
cd ~/.config/nixos

# 生成硬件配置（会生成 hardware-configuration.nix 到当前目录）
sudo nixos-generate-config --dir ~/.config/nixos

# 构建并应用（配置名跟随 hostname 自动匹配）
sudo nixos-rebuild switch --flake ~/.config/nixos
```

> 🔧 换机器前，修改 `flake.nix` 顶部的 `userName` 和 `hostName` 为对应值。

### tip

改动比较多还没做完，暂时无法正常使用。
