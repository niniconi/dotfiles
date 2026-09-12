# Neovim 配置

## 插件管理

使用 [lazy.nvim](https://github.com/folke/lazy.nvim) 作为插件管理器。

## LSP 配置

使用 Neovim 0.11+ 原生 LSP + Mason 进行语言服务器管理。

### 已安装的语言服务器

| 语言服务器 | 语言 |
|-----------|------|
| rust_analyzer | Rust |
| pyright | Python |
| clangd | C/C++ |
| lua_ls | Lua |
| bashls | Bash |
| jdtls | Java |
| phpactor | PHP |
| zls | Zig |
| ts_ls | TypeScript/JavaScript |
| asm_lsp | Assembly |
| sqls | SQL |
| html | HTML |
| cssls | CSS |
| jsonls | JSON |
| yamlls | YAML |
| marksman | Markdown |
| nixd | Nix |
| dartls | Dart |

### LSP 配置文件位置

```
lsp/
├── clangd.lua
├── dartls.lua
├── jsonls.lua
├── lua_ls.lua
├── nixd.lua
├── rust_analyzer.lua
└── yamlls.lua
```

## 快捷键

以下快捷键均为 Normal 模式下，`<leader>` 为空格。

### 基础操作

| 快捷键 | 操作 |
|--------|------|
| `<leader>n` | 打开文件树 |
| `<leader>q` | 关闭文件树 |
| `<leader>y` | 切换浮动终端 |
| `<leader>t` | 打开终端 |
| `<leader>w` | 窗口命令前缀 |
| `<leader>fw` | 保存文件 |
| `<leader>fq` | 退出 |
| `<leader>h` | 到行首 |
| `<leader>l` | 到行尾 |
| `<leader>st` | 重载 DankColors 主题 |

### Telescope 搜索

| 快捷键 | 操作 |
|--------|------|
| `<leader>ff` | 查找文件 |
| `<leader>fg` | 全局搜索内容 |
| `<leader>fb` | 查找缓冲区 |
| `<leader>fh` | 查找帮助标签 |
| `<leader>fc` | 查找命令 |
| `<leader>fk` | 查找快捷键 |
| `<leader>fgs` | 显示 git 状态 |
| `<leader>fs` | LSP 文档符号 |
| `<leader>fS` | LSP 工作区符号 |

### LSP

| 快捷键 | 操作 |
|--------|------|
| `gD` | 跳转到声明 |
| `gd` | 跳转到定义 |
| `K` | 悬停信息 |
| `gi` | 跳转到实现 |
| `<C-k>` | 签名帮助 |
| `<leader>rn` | 重命名 |
| `<leader>ca` | 代码操作 |
| `gr` | 查找引用 |
| `<leader>f` | 格式化缓冲区 |
| `[d` | 上一个诊断 |
| `]d` | 下一个诊断 |
| `<leader>vd` | 诊断浮动窗口 |
| `<leader>vD` | 诊断列表 |
| `<leader>wa` | 添加工作区 |
| `<leader>wr` | 移除工作区 |
| `<leader>wl` | 列出工作区 |
| `<leader>ty` | 类型定义 |

### 调试 (DAP)

| 快捷键 | 操作 |
|--------|------|
| `F5` | 继续执行 |
| `F10` | 单步跳过 |
| `F11` | 单步进入 |
| `F12` | 单步跳出 |
| `<leader>b` | 切换断点 |
| `<leader>B` | 条件断点 |
| `<leader>lp` | 日志点 |
| `<leader>dr` | 打开 REPL |
| `<leader>dl` | 运行上一个 |

### 测试 (Neotest)

| 快捷键 | 操作 |
|--------|------|
| `<leader>tr` | 运行最近测试 |
| `<leader>tf` | 运行当前文件测试 |
| `<leader>ts` | 切换测试摘要 |
| `<leader>to` | 切换输出面板 |

### Git (Gitsigns)

| 快捷键 | 操作 |
|--------|------|
| `]c` | 下一个 hunk |
| `[c` | 上一个 hunk |
| `<leader>hs` | 暂存 hunk |
| `<leader>hr` | 重置 hunk |
| `<leader>hp` | 预览 hunk |
| `<leader>hb` | blame 当前行 |
| `<leader>hB` | blame 全文件 |
| `<leader>hd` | 与 index 对比 |
| `<leader>hS` | 暂存整个缓冲区 |
| `<leader>hR` | 重置整个缓冲区 |
| `<leader>hi` | 内联预览 hunk |
| `<leader>hq` | 将 hunk 放入 quickfix |
| `<leader>tb` | 切换 blame 显示 |
| `<leader>tw` | 切换单词 diff |
| `<leader>tn` | 切换行号高亮 |
| `<leader>tl` | 切换行高亮 |

### Rust Crates

| 快捷键 | 操作 |
|--------|------|
| `<leader>ct` | 切换 crates |
| `<leader>cr` | 重载 crates |
| `<leader>cv` | 显示版本 |
| `<leader>cf` | 显示特性 |
| `<leader>cd` | 显示依赖 |
| `<leader>cu` | 更新 crate |
| `<leader>cac` | 更新所有 crates |
| `<leader>cU` | 升级 crate |
| `<leader>cA` | 升级所有 crates |
| `<leader>cx` | 展开 crate |
| `<leader>cX` | 提取 crate |
| `<leader>cH` | 打开主页 |
| `<leader>cR` | 打开仓库 |
| `<leader>cD` | 打开文档 |
| `<leader>cC` | 打开 crates.io |
| `<leader>cL` | 打开 lib.rs |

