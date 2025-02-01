# dotfiles

自用的linux系统配置

配置文件包括了:neovim + zsh + tmux + ranger + hyprland

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
