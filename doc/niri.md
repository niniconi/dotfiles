# Niri 配置

[Niri](https://github.com/YaLTeR/niri) 是一个可滚动的平铺式 Wayland 合成器。

## 快捷键

`Mod` 键在 TTY 下为 Super，在 winit 下为 Alt。

### 基础操作

| 快捷键 | 操作 |
|--------|------|
| `Mod+T` | 打开终端 (kitty) |
| `Mod+D` | 打开启动器 (dms/rofi) |
| `Mod+E` | 打开文件管理器 (nautilus) |
| `Super+Alt+L` | 锁屏 |
| `Mod+Q` | 关闭窗口 |
| `Mod+Shift+E` | 退出 niri |
| `Ctrl+Alt+Delete` | 退出 niri |
| `Mod+Shift+P` | 关闭显示器 |
| `Super+Alt+S` | 切换屏幕阅读器 (orca) |

### 窗口焦点

| 快捷键 | 操作 |
|--------|------|
| `Mod+Left/H` | 焦点左移 |
| `Mod+Down/J` | 焦点下移 |
| `Mod+Up/K` | 焦点上移 |
| `Mod+Right/L` | 焦点右移 |
| `Mod+Home` | 焦点到第一列 |
| `Mod+End` | 焦点到最后一列 |

### 移动窗口

| 快捷键 | 操作 |
|--------|------|
| `Mod+Ctrl+Left/H` | 窗口左移 |
| `Mod+Ctrl+Down/J` | 窗口下移 |
| `Mod+Ctrl+Up/K` | 窗口上移 |
| `Mod+Ctrl+Right/L` | 窗口右移 |
| `Mod+Ctrl+Home` | 移动列到第一 |
| `Mod+Ctrl+End` | 移动列到最后 |
| `Mod+Ctrl+R` | 重置窗口高度 |
| `Mod+Ctrl+F` | 扩展列到可用宽度 |

### 显示器焦点

| 快捷键 | 操作 |
|--------|------|
| `Mod+Shift+Left/H` | 焦点左显示器 |
| `Mod+Shift+Down/J` | 焦点下显示器 |
| `Mod+Shift+Up/K` | 焦点上显示器 |
| `Mod+Shift+Right/L` | 焦点右显示器 |

### 移动列到显示器

| 快捷键 | 操作 |
|--------|------|
| `Mod+Shift+Ctrl+Left/H` | 移动列到左显示器 |
| `Mod+Shift+Ctrl+Down/J` | 移动列到下显示器 |
| `Mod+Shift+Ctrl+Up/K` | 移动列到上显示器 |
| `Mod+Shift+Ctrl+Right/L` | 移动列到右显示器 |

### 工作区

| 快捷键 | 操作 |
|--------|------|
| `Mod+Page_Down/U` | 下一个工作区 |
| `Mod+Page_Up/I` | 上一个工作区 |
| `Mod+Ctrl+Page_Down/U` | 移动窗口到下工作区 |
| `Mod+Ctrl+Page_Up/I` | 移动窗口到上工作区 |
| `Mod+1-9` | 切换到工作区 1-9 |
| `Mod+Ctrl+1-9` | 移动窗口到工作区 1-9 |
| `Mod+Shift+Page_Down/U` | 移动工作区向下 |
| `Mod+Shift+Page_Up/I` | 移动工作区向上 |

### 窗口布局

| 快捷键 | 操作 |
|--------|------|
| `Mod+F` | 最大化列 |
| `Mod+Shift+F` | 全屏窗口 |
| `Mod+V` | 切换浮动 |
| `Mod+Shift+V` | 切换焦点浮动/平铺 |
| `Mod+W` | 切换标签列 |
| `Mod+R` | 切换预设列宽 |
| `Mod+Shift+R` | 切换预设窗口高度 |
| `Mod+C` | 居中列 |
| `Mod+Ctrl+C` | 居中所有可见列 |

### 调整大小

| 快捷键 | 操作 |
|--------|------|
| `Mod+Minus` | 列宽 -10% |
| `Mod+Equal` | 列宽 +10% |
| `Mod+Shift+Minus` | 窗口高度 -10% |
| `Mod+Shift+Equal` | 窗口高度 +10% |

### 其他操作

| 快捷键 | 操作 |
|--------|------|
| `Mod+O` | 显示概览 |
| `Mod+Shift+Slash` | 显示快捷键帮助 |
| `Mod+BracketLeft` | 吸收/弹出窗口到左侧 |
| `Mod+BracketRight` | 吸收/弹出窗口到右侧 |
| `Mod+Comma` | 从右侧吸收到列底 |
| `Mod+Period` | 从列底弹出到右侧 |
| `Print` | 截图 |
| `Ctrl+Print` | 截图整个屏幕 |
| `Alt+Print` | 截图当前窗口 |
| `Mod+Escape` | 切换键盘快捷键抑制 |

### 鼠标绑定

| 快捷键 | 操作 |
|--------|------|
| `Mod+滚轮下` | 下一个工作区 |
| `Mod+滚轮上` | 上一个工作区 |
| `Mod+Ctrl+滚轮下` | 移动列到下工作区 |
| `Mod+Ctrl+滚轮上` | 移动列到上工作区 |
| `Mod+滚轮右` | 焦点右移 |
| `Mod+滚轮左` | 焦点左移 |
| `Mod+Ctrl+滚轮右` | 移动列右移 |
| `Mod+Ctrl+滚轮左` | 移动列左移 |

### 音量和亮度

| 快捷键 | 操作 |
|--------|------|
| `XF86AudioRaiseVolume` | 增加音量 |
| `XF86AudioLowerVolume` | 降低音量 |
| `XF86AudioMute` | 静音 |
| `XF86AudioMicMute` | 麦克风静音 |
| `XF86MonBrightnessUp` | 增加亮度 |
| `XF86MonBrightnessDown` | 降低亮度 |

## 配置文件

配置文件位于 `~/.config/niri/`，主要配置文件：

- `config.kdl` - 主配置
- `binds.kdl` - 快捷键配置
- `animations.kdl` - 动画配置
- `environment.kdl` - 环境变量
- `input.kdl` - 输入配置
- `layout.kdl` - 布局配置
- `outputs.kdl` - 输出配置
- `rules.kdl` - 窗口规则
- `workspaces.kdl` - 工作区配置
