# Hyprland 配置

[Hyprland](https://hyprland.org/) 是一个动态平铺式 Wayland 合成器。

## 快捷键

`$mainMod` 为 SUPER 键（Windows 键）。

### 基础操作

| 快捷键 | 操作 |
|--------|------|
| `$mainMod + Q` | 打开终端 (kitty) |
| `$mainMod + C` | 关闭活动窗口 |
| `$mainMod + M` | 退出 Hyprland |
| `$mainMod + E` | 打开文件管理器 (nautilus) |
| `$mainMod + V` | 切换浮动 |
| `$mainMod + R` | 打开启动器 (rofi) |
| `$mainMod + P` | 伪平铺 |
| `$mainMod + J` | 切换分割 |
| `$mainMod + L` | 锁屏 |

### 窗口焦点

| 快捷键 | 操作 |
|--------|------|
| `$mainMod + Left` | 焦点左移 |
| `$mainMod + Right` | 焦点右移 |
| `$mainMod + Up` | 焦点上移 |
| `$mainMod + Down` | 焦点下移 |

### 工作区

| 快捷键 | 操作 |
|--------|------|
| `$mainMod + 1-0` | 切换到工作区 1-10 |
| `$mainMod + SHIFT + 1-0` | 移动窗口到工作区 1-10 |
| `$mainMod + mouse_down` | 下一个工作区 |
| `$mainMod + mouse_up` | 上一个工作区 |

### 特殊工作区

| 快捷键 | 操作 |
|--------|------|
| `$mainMod + S` | 切换特殊工作区 (scratchpad) |
| `$mainMod + SHIFT + S` | 移动窗口到特殊工作区 |

### 全屏

| 快捷键 | 操作 |
|--------|------|
| `$mainMod + F` | 切换全屏状态 |
| `$mainMod + SHIFT + F` | 全屏 |

### 截图

| 快捷键 | 操作 |
|--------|------|
| `$mainMod + SHIFT + P` | 截图 (grim + slurp) |

### 窗口移动和调整大小

| 快捷键 | 操作 |
|--------|------|
| `$mainMod + 鼠标左键拖动` | 移动窗口 |
| `$mainMod + 鼠标右键拖动` | 调整窗口大小 |
| `$mainMod + ALT + 鼠标拖动` | 调整窗口大小 |

### 多媒体键

| 快捷键 | 操作 |
|--------|------|
| `XF86AudioRaiseVolume` | 增加音量 |
| `XF86AudioLowerVolume` | 降低音量 |
| `XF86AudioMute` | 静音 |
| `XF86AudioMicMute` | 麦克风静音 |
| `XF86MonBrightnessUp` | 增加亮度 (5%) |
| `XF86MonBrightnessDown` | 降低亮度 (5%) |
| `XF86AudioNext` | 下一曲 |
| `XF86AudioPrev` | 上一曲 |
| `XF86AudioPlay/Pause` | 播放/暂停 |

### 音量脚本

音量控制使用脚本：
- `$HOME/.config/scripts/up-volume.sh` - 增加音量
- `$HOME/.config/scripts/down-volume.sh` - 降低音量

## 配置文件

配置文件位于 `~/.config/hypr/`：

- `hyprland.conf` - 主配置
- `hyprlock.conf` - 锁屏配置
- `hypridle.conf` - 空闲配置

## 自动启动

- `fcitx5` - 输入法
- `waybar` - 状态栏
- `hypridle` - 空闲管理
- `swww-daemon` - 壁纸管理
- `start-swww.sh` - 壁纸图片加载脚本
