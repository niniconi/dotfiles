# my-conf-file

配置文件包括了:neovim + zsh + tmux + ranger

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

添加了如下快捷键，以下快捷键都是Normal模式下的

|快捷键     |命令                  |介绍        |
|----------|---------------------|------------|
|<leader>x |:NERDTreeFocus       |打开NERDTree|
|<leader>n |:NERDTreeClose       |关闭NERDTree|
|<leader>t |:FloatermNew         |打开终端     |
|<leader>ff|:Telescope find_files|文件搜索     |

### install

使用以下命令安装，后字体需手动安装
```bash
sh -c "$(wget https://raw.githubusercontent.com/niniconi/my-conf-file/master/install.sh -O -)"
```
