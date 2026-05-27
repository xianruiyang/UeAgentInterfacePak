# Audio Insights

---
title: "Audio Insights"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/audio-insights-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "处理音频", "Audio Insights"]
---

# Audio Insights

> 路径：虚幻引擎5.7文档 / 处理音频 / Audio Insights

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/audio-insights-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

## 简介

**音频洞察** 提供 a suite 的 工具 到 分析, 调试, 和 monitor 运行时 aspects 的 音频 在 Unreal 引擎 (UE). 使用 多个 tabbed 窗口, 音频洞察 提供 visualizations 和 numerical 值 用于 当前 pitch, volume, 和 其他 参数 值 用于 [源](../sound-source/index.md), [音频总线](../audio-mixing/audio-bus-overview/index.md), [子混音](../submixes/index.md), 和 更多 期间 实时 Gameplay. 它 可以 提供 信息 用于 两者 [Play 在 编辑器 (PIE)](../../building-virtual-worlds/level-editor/ineditor-testing-play-and-simulate/index.md#play-in-editor) sessions 和 独立运行 games.

![Audio Insights main window](../../../assets/images/41/4191856ca0fb44979c40516baa578274d0ed0a39f7a862485779b8ba82523f56.jpg)

音频洞察 主要 窗口

## 该 音频洞察 插件

音频洞察 是 启用 通过 默认 在 UE. 如果 它 是 禁用, 你 可以 re-启用 它 通过 selecting **编辑 > 插件** 在 该 主要 菜单, 然后 searching 用于 和 启用 该 **音频洞察 插件**. 之后 re-启用 该 插件 在 你的 项目, 你 需要 到 restart 该 编辑器.

![Audio Insights plugin](../../../assets/images/51/51773b1c15a657bcdb42f57f58a95465bae018bfa3f646cc68e3b1b27fb539f6.jpg)

## 使用 音频洞察 在 该 编辑器

一次 启用 用于 你的 项目, 你 可以 打开 一个 音频洞察 窗口 从 该 **工具**菜单.

![Audio Insights in the UE Tools menu.](../../../assets/images/03/03e44406ba20a007e5e77e097c39dabe405374433188bc9995fd87373ea99341.jpg)

- 通过 默认, 音频洞察 begins 监控 该 事件 生成 通过 该 音频 引擎 当 你 开始 a PIE 会话 和 presents 该 数据 在 a series 的 标签页.
- 如果 你 禁用 此 默认 行为, 你 可以 begin 监控 使用 该 **开始 监控** 按钮 在 该 upper 左侧 corner.
- 音频洞察 是 a tabbed 窗口; 你 可以 dock 它 anywhere 在 该 编辑器 用于 你的 convenience.

  ![Audio Insights tab](../../../assets/images/1c/1ce541832f6deb8d4910874c4ce721df5032d5d2abf1cc79e118c0edd08dc8ea.png)

编辑器 追踪 录制 概要:

1. 在 该 主要 菜单, 选择 **工具 > 音频洞察**.
2. Confirm 监控 是 激活 (显示 a green icon).

   1. 如果 necessary, 点击 **开始 监控**.
3. Enter **PIE 模式** 在 你的 项目.

### Saving a 追踪

通过 默认, 监控 数据 执行 不 保存 数据:

![Monitoring icon Audio Insights](../../../assets/images/73/7310918e0c1331258dc71e062fee4617803d48581df5d4e8a630674ad7aa867f.png)

点击 **开始 录制** 到 begin saving a 追踪:

![Recording icon Audio Insights](../../../assets/images/cf/cff7a74323ac7d77bf4686f6bde5144edbe7114e907c0163e6be0a4ae5cc212e.png)

两者 的 这些 states (监控 和 录制) 显示 a 追踪 流 生成 在 虚幻编辑器. 使用 该 录制 按钮's 状态 到 validate 是否 音频洞察 是 saving 该 数据 到 磁盘.

## 使用 音频洞察 使用 独立运行 构建

你 可以 还 使用 音频洞察 使用 独立运行 构建, 任一 在 该 相同 设备 在 该 情况 的 窗口 构建, 或 connected 超过 该 网络 用于 控制台 构建. 使用 音频洞察 使用 a 独立运行 构建 需要 你 到 还 使用 Unreal Insights.

1. 在 该 **追踪**菜单 在 该 lower 右侧 端 的 该 编辑器 窗口, 选择 **Unreal Insights (会话 Browser)**, 然后 exit 该 编辑器 之后 Unreal Insights starts.

   追踪 菜单 选择 Unreal 引擎 (会话 Browser)

   1. Alternatively, 你 可以 运行 Unreal Insights 从 该 命令 行 使用:

      `/Engine/Binaries/Win64/UnrealInsights.exe -DisableFramerateThrottle`

      该 extra 标志 启用 Unreal Insights 到 运行 在 60fps even 当 不 在 focus.
2. 此 connects 到 该 当前-运行 游戏 在 该 localhost. 在 该 **追踪 存储**, 找到 该 追踪 使用 实时 (在 red) 在 该 **状态**列, 然后 double-点击 它 到 bring 上 该 追踪 会话 窗口.

   ![trace Store tab LIVE session](../../../assets/images/d6/d634cb1e0623e7a13889e4a2eb358b49c233bd1d78d8bb82cbc868e9ec5b7537.jpg)
3. 在 该 **菜单**, 选择 该 **音频洞察** 选项.

   ![Select Audio Insights in the Menu](../../../assets/images/c7/c742652df9a71d8bcbd4a2fbab3e2acd8a04ce8b937de263c1204d0941229687.jpg)
4. 此 opens 一个 音频洞察 窗口 该 函数 similarly 到 该 窗口 该 connects 到 a PIE 会话 described 上方.

   1. If you do not specify `audio,audiomixer` trace channels when you are connecting, Audio Insights asks you to enable them as the window opens.
5. Start your standalone game with the `-Messaging` flag and connect to it from Unreal Insights by using the **连接**tab. Enter `audio,audiomixer` (with no space after the comma) in the **初始 通道** field, 然后 点击 **连接**.

   > 图片已省略：Connection tab set Initial Channels and Connect

A 独立运行 实例 的 音频洞察 执行 不 具有 该 相同 messaging 作为 当 你 使用 它 使用 PIE. 该 differences 为 documented 下方 用于 每个 标签页.

独立运行 追踪 录制 概要:

1. Run `/Engine/Binaries/Win64/UnrealInsights.exe -DisableFramerateThrottle`
2. Enter `audio,audiomixer` in the **初始 通道** field 的 该 **连接**标签页.
3. Start your game using the command `MyGame.exe -messaging`.
4. 在 Unreal Insights, 点击 **连接**.
5. Go 到 该 **追踪 存储** 标签页 和 double-点击 在 该 **实时 会话**.
6. 在 该 新增 窗口's 菜单, 选择 **音频洞察**.

### 控制 追踪 Recordings 在 独立运行 模式

当 运行 音频洞察 在 独立运行 模式 从 Unreal Insights, 你 需要 到 使用 该 会话 Frontend 标签页 到 控制 该 录制 的 你的 追踪 文件.

到 stop 或 restart 该 录制, 选择 该 当前 会话 用于 你的 应用程序 和 点击 该 开始/stop 追踪 按钮:

> 图片已省略：The Stop / Start Tracing button

### 使用 音频洞察 使用 a 控制台 构建

你 可以 使用 音频洞察 使用 a 控制台 构建 在 另一个 联网 机器.

- Set the following additional command-line arguments for the game executable: `-messaging -tracehost=192.168.1.100 -trace=audio,audiomixer`
- 替换 该 **Tracehost IP address** 使用 该 address 的 该 computer 运行 Unreal Insights 和 该 Unreal 追踪 服务器. 该 图片 下方 使用 一个 Xbox dev 系统 作为 一个 示例:

  > 图片已省略：Set the Tracehost IP address

### Monitor a 独立运行 构建 不 a 追踪 文件

你 可以 monitor a 独立运行 构建 在 该 本地 host 不 录制 a 追踪 文件 使用 Unreal Insights.

1. 在 该 **连接**标签页, 点击 **开始 Unreal Insights**:

   > 图片已省略：Click Start Unreal Insights in the Connection tab.
2. When the timing window appears, open the Audio Insights window from the menu as before, then start your `game.exe` with the `-messaging` option. This displays audio information in Audio Insights without saving a file.
3. 你 可以 verify 此 通过 returning 到 该 追踪 存储 标签页 在 Unreal Insights 和 confirming 存在 为 no 当前 traces indicated 使用 该 red 实时 文本.

> [!NOTE]
> 监控 a 独立运行 游戏 是 不 一个 选项 使用 联网 控制台 构建; 你 必须 记录 a 追踪 用于 联网 控制台 构建.

## 音频 数据 Detail 标签页

你 可以 configure 该 可见 标签页 使用 该 **视图**菜单 在 该 音频洞察 标签页:

> 图片已省略：Audio Insights View tab

你 可以 reposition 详细 标签页 anywhere 内部 该 音频洞察 标签页 或 pull 它们 输出 作为 空闲-floating 窗口. Selecting **Reset Layout** reverts 该 标签页 到 它们的 默认 positions 如果 你的 layout gets 过于 scrambled.

### 顶部 关卡 控制项

该 顶部 toolbar 提供 控制项 用于 如何 音频洞察 gathers 和 maintains 数据 从 该 音频 引擎.

| 控制 | 说明 |
| --- | --- |
| **开始 监控/监控** | This is a direct trace from Unreal Insights and gathers data from the engine without saving anything to a `.utrace` file. This mode is useful to view data for long periods of time without creating large log files. This defaults to on, shown in green, but you can turn it off if you want to stop collecting data. Editor only. |
| **开始 录制/录制** | 此 是 该 实时 录制 选项 从 Unreal Insights, 位置 所有 追踪 数据 是 保存 在 a 文件, 其 appears 在 该 追踪 存储 章节 的 Unreal Insights. 当 录制, 此 按钮 是 red. 到 stop 录制 到 a 文件, 点击 任一 该 录制 或 该 监控 按钮. 编辑器 仅. |
| **保存 a Snapshot** | Saves a snapshot of the most recent trace data to a `.utrace` file. By default, snapshots are limited to 32MB in the editor and 4MB in standalone. You can access them in the Unreal Insights Trace Store. To specify a custom snapshot size (in MB) launch the editor executable with the `-tracetailmb=<size>` option. This works in either Monitor or Recording modes and is available in both editor and standalone versions of Audio Insights.[Save a Snapshot icon](https://dev.epicgames.com/community/api/documentation/image/ae199fd2-e9e0-40c1-ab42-9b7e2a10f406?resizing_type=fit) |
| **Bookmark** | Creates an Audio Insights bookmark in the `.utrace` file generated by Save Snapshot or Trace at the timestamp the button was pressed. You can also place a bookmark using Ctrl+M.[Bookmark icon](https://dev.epicgames.com/community/api/documentation/image/9be2f7ac-c57e-4048-ab93-d9cf0a7eab0b?resizing_type=fit) |
| **仅 追踪 音频 signals 期间 PIE** | 音频洞察 使用 该 Unreal Insights 追踪 capabilities, 其 可以 生成 a lot 的 数据. 如果 你 为 仅 启用 该 追踪 用于 音频洞察, clicking 此 checkbox reduces 该 数据 存储 作为 你 记录 和 调试 你的 会话 使用 音频洞察. 此 helps 使用 total 系统 性能 和 内存 用法. 编辑器 仅.[Only trace audio signals during PIE icon and checkbox](https://dev.epicgames.com/community/api/documentation/image/5565d39f-d754-41b0-a7c2-1464a3d2959a?resizing_type=fit) |
| **世界 筛选** | 此 dropdown 菜单 提供 你 该 选项 到 选择 音频 数据 从 该 当前-运行 worlds, 包括 该 编辑器. |

### 记录 (编辑器 仅)

该 **记录**标签页 是 另一个 方式 到 筛选 和 observe 虚幻编辑器 记录 下一个 到 任何 pertinent 音频 信息 你 可能 是 looking 在. 此 数据 默认为 displaying 所有 音频-特定 日志 类别, 但是 你 可以 更改 该 筛选器 到 包括 或 排除 任何 其他 日志 类别 和 verbosities.

> 图片已省略：Logs categories filters

### 事件 日志

该 **事件 日志** 标签页 显示 a scrollable 时间-stamped 列表 的 音频 事件 作为 它们 happen. 它 还 acts 作为 a timeline controller 用于 音频洞察, 在 该 你 可以 选择 a 特定 事件 从 此 列表 和 然后 所有 其他 标签页 显示 该 instantaneous 数据 用于 该 特定 时间.

> 图片已省略：Audio Insights Event Log tab

当 监控 a 实时 游戏, 该 事件 日志 存储 数据 在 a circular 缓冲区 缓存 该 显示 该 多数 最近 事件. 当 该 用户 selects 一个 事件 用于 inspection 当 监控, 该 数据 缓存 continues 到 fill 直到 该 选中 事件 是 near 该 结束 的 该 缓存. 当 使用 音频洞察 在 a pre-recorded 追踪 文件, 该 事件 日志 显示 所有 该 数据 在 该 会话.

#### 事件 日志 用户 Interface

该 顶部 关卡 UI 元素 的 该 事件 日志 标签页 为 如何 你 可以 控制 和 monitor 该 事件 日志 缓存 和 它的 内容.

| UI Element | 说明 |
| --- | --- |
| **添加 筛选 菜单** | 提供 a 方式 用于 你 到 选择 该 事件 类型 显示. |
| **筛选 文本** | 显示 仅 该 事件 条目 其 匹配 该 字符串 entered. 资产, Actor, 和 Play 顺序 列 为 compared 用于 此 筛选. |
| **缓存 restart** | 当 你 设置 该 缓存 到 pause 在 该 结束, 然后 选择 一个 事件 near 该 结束 的 该 缓存, 该 pause 按钮 appears. Clicking 它 deselects 该 当前 事件, 移动 该 playhead 到 该 当前 数据, 和 restarts 监控. |
| **缓存 大小** | 显示 读取-仅 信息 关于 如何 much 的 该 缓存 是 当前 filled, 在 terms 的 内存 使用 compared 到 total capacity, 和 时间 持续时间 捕获. 该 时间 持续时间 值 varies 取决于 在 该 complexity 的 该 音频 场景 捕获. |
| **Clear 日志** | 点击 到 空 该 日志, so 你 可以 获取 a clean 开始 当 capturing a 场景. |
| 设置 菜单 |  |
| **可见 列** | 提供 你 a 方式 到 选择 该 数据 列 显示. |
| **自动 Stop Caching** | 提供 你 a 方式 到 选择 该 行为 的 该 缓存 当 inspecting 一个 事件 当 监控. 选项 为:**当 marked 用于 删除:** Stops 该 缓存 当 该 选中 事件 是 near 该 结束 的 该 缓存, 就绪 到 是 删除. 该 缓存 restarts 当 该 用户 deselects 该 事件 或 clicks 缓存 restart.**在 inspect:** Stops 该 缓存 当 你 选择 任何 事件. 该 缓存 restarts 当 你 deselect 该 事件 或 点击 缓存 Restart.**Never**: 执行 不 stop 该 缓存. 当 a 选中 事件 是 删除 从 该 缓存, 该 事件 日志 返回 到 该 当前 值 在 该 head 的 该 缓存. |

#### 事件 日志 数据

你 可以 选择 其 列 到 显示 通过 右侧-clicking 在 该 toolbar, 该 标签页 设置, 或 该 编辑器 preferences.

| 列 名称 | 说明 |
| --- | --- |
| **缓存 状态** | 显示 a 警告 icon 如果 此 特定 事件 是 close 到 获取 dumped 从 该 缓存. |
| **ID** | 显示 a 唯一 标识符 用于 每个 特定 事件. |
| **时间戳** | 该 数量 的 秒 since 该 会话 开始. |
| **Play 顺序** | 该 唯一 ID 给定 到 该 音频 源 在 该 引擎. 当 你 选择 a 特定 事件, 事件 在 该 相同 Play 顺序 (例如 作为 stop, virtualize, 和 类似) 为 lightly highlighted 到 indicate 该 relationship. |
| **事件** | 显示 该 事件 类型 作为 listed 在 该 事件 类型 章节. |
| **Actor** | 该 名称 的 该 世界 Actor 该 owns 该 声音 或 triggered 该 事件. |
| **类别** | 该 类型 的 声音 源 用于 此 特定 事件. |

#### 事件 类型

你 可以 使用 该 **添加 筛选** 菜单 到 筛选 该 事件 通过 类型.

| 事件 类型 | 列表 或 说明 |
| --- | --- |
| **声音 Activity** | Playing, 停止, Paused, Resume |
| **Virtualization** | Virtualized, Realized |
| **Play 请求** | 声音 处理, 音频 组件, 一个 Shot, 声音 在 位置, Play 声音 2D, Slate 声音 |
| **Stop 请求** | Stop 所有, 声音 处理, 音频 组件, 激活 声音, 声音 使用 资源, Concurrency (停止 用于 voice 优先级) |
| **Play Errors** | 不 Playable, 输出 的 Range, 调试 筛选, Concurrency (失败 到 开始) |
| **消息** | Flush 音频 设备 |
| **自定义** | [自定义 事件 (参见 下方)](index.md#custom-events) |

##### 自定义 事件

你 可以 创建 自定义 事件 在 该 **编辑器 Preferences**. 下方 **插件 - 音频洞察**, expand **自定义 事件 日志 类别**, 然后 添加 你的 自定义 事件. 你 可以 调用 那些 事件 使用 标准 追踪 调用 在 C++ 或 蓝图 到 具有 它们 populate 在 该 事件 日志.

到 创建 a 自定义 事件 日志 类别:

- 添加 a 文本 字符串 用于 a 类别.
- 列表 该 文本 字符串 用于 任何 事件 该 belong 到 该 类别.

  - 这些 事件 将 是 classified 和 筛选 根据 到 该 designated 类别.
  - 任何 undefined 用户 事件 将 显示 上 在 a generic **自定义** 类别.

  > 图片已省略：Audio Insights Editor Preferences

#### 事件 控制项

当 使用 音频洞察 使用 一个 编辑器 会话, double clicking 一个 事件 在 该 事件 标签页 opens 该 资产 编辑器 用于 该 事件 资产. 你 可以 还 使用 该 右侧-点击 上下文 菜单 用于 两者 opening 该 编辑器 和 browsing 到 该 资产.

> [!WARNING]
> 该 保存 a Snapshot 按钮 在 该 顶部 菜单 makes a 追踪 文件 输出 的 该 Unreal Insights 数据 在 该 moment. 此 将 不 是 该 相同 数据 作为 什么 你 具有 在 该 音频洞察 数据 缓存, 它 将 contain 其他 追踪 数据 和 将 capture less Gameplay 时间. 此 是 a 已知 问题 到 是 addressed.

该 事件 标签页 显示 所有 该 事件 用于 a 给定 音频 设备 在 该 时间. 当 你 stop Play 在 编辑器 (PIE), 该 音频 设备 可能 更改, 其 deletes 该 cached 值 用于 该 PIE 音频 设备.

到 避免 此, 在 该 **关卡 编辑器 - Miscellaneous > 声音 设置**, 禁用 **创建 新增 音频 设备 用于 Play 在 编辑器**. 此 makes 该 编辑器 使用 该 相同 音频 设备 作为 该 PIE 会话, 其 maintains 该 事件 在 该 事件 日志 之后 stopping PIE.

> 图片已省略：Disable Create New Audio Device for Play in Editor

### 声音

该 **声音**标签页 显示 所有 该 当前-playing 声音 资产, listed 通过 类别, 使用 文本 显示 的 运行时 数据 用于 每个. 它 提供 你 a 方式 到 interact 使用 该 playing 声音 到 mute 和 solo (isolate) 元素 的 该 mix. 该 声音 为 identified 使用 它们的 .uasset 名称 和 不 该 运行时 实例 名称.

> 图片已省略：Audio Insights Sounds tab

#### 声音 用户 Interface

该 顶部 关卡 UI 元素 的 该 声音 标签页 为 如何 你 可以 manipulate 该 声音 playing.

> 图片已省略：Sounds tab UI elements

| UI Element | 说明 |
| --- | --- |
| **Mute 筛选** | Mutes 所有 当前-筛选 声音 作为 显示 通过 该 筛选 文本 box. 其 声音 为 muted 更新 作为 你 更改 该 文本 字符串. Mute 筛选 模式 是 indicated 通过 该 Mute 按钮 turning green. |
| **Mute 选中** | 当 你 选择 声音, 该 Mute 按钮 更改 到 indicate 它 可以 Mute 选中. 当 你 点击 它, 它 切换 该 mute 在 任何 声音 选中. 此 是 a 切换 控制 作为 opposed 到 该 modal 控制 用于 筛选 声音. |
| **Solo 筛选** | Solos 所有 声音 该 为 当前 筛选 到 显示 通过 该 筛选 文本 box. 该 声音 soloed 更新 作为 你 更改 该 文本 字符串. 如果 你 筛选 everything, nothing 播放. Solo 筛选 模式 是 indicated 通过 该 Solo 按钮 turning green. Solo takes precedence 超过 mute - 如果 你 两者 mute 和 solo a 声音, 它 是 played. |
| **Solo 选中** | 如果 你 选中 任何 声音, 该 Solo 按钮 更改 到 indicate 它 可以 Solo 选中. 当 你 点击 它, 它 切换 soloing 在 任何 选中 声音. 此 是 a 切换 控制 作为 opposed 到 a modal 控制 用于 筛选 声音. |
| **Clear 所有 Mutes / Solos** | Resets 该 muted 和 soloed 声音 so 该 该 mix 是 unaffected. |
| **绘图 选中** | 发送 数据 从 该 选中 声音 到 该 Plots 标签页. |
| **Clear 所有 Plots** | Stops 发送 任何 声音 数据 到 该 Plots 标签页. |
| **筛选 类别** | 显示 类别 buttons 在 该 标签页 header, providing a 方法 用于 quick filtering 的 该 声音 listed. 该 声音 筛选 类别 选项 为:**MetaSound**: MetaSound 源 资产.**声音 Cue**: 声音 Cues 和 任何 child 声音 Waves.**Procedural 源**: 任何 混音器 输入 对象 该 inherits 从 USoundWaveProcedural 在 代码.**声音 Wave**: Simple wave 资产.**声音 Cue 模板**: 声音 Cues 构建 在 运行时 从 a 模板.**其他**: 音频 源 总线.**Pinned**: 特定 选中 声音 你 pinned 在 该 顶部 的 该 列表. |
| **筛选 文本** | 筛选器 该 显示 声音 使用 该 文本 字符串 你 enter 在 该 Search 窗口. 任何 声音 或 Actor 名称 该 匹配 该 文本 是 显示. |

#### 声音 数据

你 可以 控制 该 visibility 的 该 声音 数据 列 通过 使用 该 右侧-点击 上下文 菜单 在 该 声音 toolbar 或 通过 使用 该 设置 Widget 在 该 右侧. 在 addition 到 该 单独 列, 你 可以 使用 该 **选择 所有** 控制 到 选择 或 deselect 所有 该 列 在 一次.

> 图片已省略：Select the visible Sound data columns.

| 列 名称 | 说明 |
| --- | --- |
| **Muted** | Selects 和 显示 如果 此 实例 的 该 声音 是 muted (编辑器 仅). |
| **Soloed** | Selects 和 显示 如果 此 实例 的 该 声音 是 soloed (编辑器 仅). |
| **Plotted** | Selects 和 显示 如果 此 实例 的 该 声音 是 plotted 在 该 Plots 标签页. |
| **名称** | 显示 该 UAsset 名称 的 该 声音, 不 该 运行时 实例 名称. |
| **Play****顺序** | 显示 该 唯一 ID 给定 到 该 音频 源 在 该 引擎. 此 是 该 相同 值 使用 在 该 事件 标签页. 在 aggregated 声音 例如 作为 a 声音 Cue, 该 underlying wave players 具有 a 唯一 Play 顺序; 此 列 显示 该 父级 和 wave 玩家 Play 顺序 值 分隔 通过 a 逗号. |
| **优先级** | 设置 用于 concurrency, a 正 浮点 值 使用 higher numbers 表示 greater 优先级 |
| **距离** | 显示 该 正 距离 从 该 声音 renderer 在 映射 units. |
| **距离/Occlusion Attenuation** | 显示 该 值 的 该 volume 和 filtering multiplier 应用 基于 在 距离 和 occlusion 的 a 声音, a 浮点 值 从 0.0 到 1.0, 使用 1.0 正在 unattenuated. |
| **Amp (Peak)** | 显示 该 值 的 一个 envelope follower 跟踪 该 声音 幅度, a 浮点 值 从 0.0 到 1.0, 使用 1.0 正在 该 最大 输出 幅度. |
| **Volume** | 显示 该 product 的 所有 volume 值 和 modulators 用于 此 实例 的 该 声音, excluding 距离 attenuation, a 正 浮点 值 其 是 a linear 幅度 multiplier. |
| **LPF** | 显示 该 lowest 频率 的 所有 低-传递 筛选 控制项 和 modulators 用于 此 混音器 源, 表示 该 cutoff 频率 在 Hertz. |
| **HPF** | 显示 该 highest 频率 的 所有 高-传递 筛选 控制项 和 modulators 用于 此 混音器 源, 表示 该 cutoff 频率 在 Hertz. |
| **Pitch** | 显示 该 sum 的 所有 pitch 值 和 modulators 用于 此 实例 的 该 声音, a 正 浮点 值 作为 a linear 播放 速率 multiplier. |
| **相对 渲染 Cost** | 显示 a numerical 值 表示 如何 许多 wave-playing 资源 该 特定 声音 使用. 此 是 useful 到 参见 如何 expensive a 声音 Cue 或 MetaSound 是 使用 embedded wave players. |
| **Actor Label** | 显示 任一 该 名称 的 该 世界 Actor 该 holds 该 音频 组件 或 该 Actor 该 triggered 该 声音. |
| **类别** | 显示 a 文本 indication 的 该 声音 类别 listed 上方. 该 类别 icon 到 该 左侧 的 该 名称 列 是 视为 部分 的 该 名称, 和 是 不 控制 通过 此 列 设置. |

##### Aggregation

用于 a hierarchical 对象 例如 作为 a 声音 Cue 该 包含 多个 child 声音 Waves, 该 声音 Cue Volume 和 Pitch 将 显示 该 顶部 关卡 值. However, 该 声音 Wave 将 显示 该 aggregated 值 的 该 声音 Cue 顶部 关卡 和 任何 其他 modulations 该 happen 到 该 声音 Wave 内部 该 声音 Cue.

#### 声音 设置

该 以下 设置 为 可用 当 你 点击 该 **设置**icon 在 该 声音 标签页.

> 图片已省略：Sound settings

| 声音 设置 | 说明 |
| --- | --- |
| **Amp (Peak) 显示 模式** | 切换 之间 decibel (dB) 和 linear 幅度 显示. |
| **视图** | 控制项 该 显示 声音 层级. 选项 为:**Tree 视图**: Listing 通过 类别.**激活 声音**: Grouped 通过 激活 声音.**Flat 列表**: 显示 单独 wave players 在 a flat 列表. |
| **自动-Expand** | 声音 为 hierarchically grouped 通过 类别 第一个, 然后 通过 声音 源. 此 控制项 如何 该 nested 声音 资产 为 自动 显示. 选项 为:**类别****Everything****Nothing** |
| **可见 列** | 选择 该 数据 列 described 上方 下方 声音 数据 列. |
| **显示 停止 声音** | 当 启用, 声音 该 recently 停止 stay 可见 在 该 列表 grayed 输出 用于 a 短 时间, making 它 easier 到 observe 短 声音. |
| **Recently 停止 Timeout** | 决定 如何 许多 秒 停止 声音 remain 可见 在 该 列表 之后 它们 stop. |

#### 声音 资产 控制项

右侧-clicking 在 a 选中 声音 opens 该 声音 上下文 菜单, 其 提供 该 以下 选项:

- Pin a 声音 到 该 顶部 的 该 显示.
- Browse 到 该 资产 在 该 内容 browser.
- 打开 上 该 资产 编辑器 从 此 窗口.

> 图片已省略：Sound asset controls

### Plots

该 **Plots**标签页 显示 a 行 图表 的 值 histories 用于 该 声音 选中 到 绘图 在 该 声音 标签页. 该 绘图 行 colors 匹配 该 colors 显示 在 该 绘图 列 的 该 声音 标签页. Plots 显示 该 多数 最近 5 秒 的 值 history.

#### 绘图 控制项

- **参数 选择**: 使用 此 pull 下 菜单 到 选择 该 特定 声音 参数 从 该 声音 标签页 到 显示. 所有 选中 声音 显示 该 相同 参数, differentiated 通过 颜色.

  - Amp (Peak)
  - Volume
  - 距离
  - 距离/Occlusion Attenuation
  - Pitch
  - 优先级
  - LPF Freq (Hz)
  - HPF Freq (Hz)
- **Y Axis Range**: 你 可以 选择 之间 一个 自动 range scaled 到 fit 所有 该 数据 在 该 窗口 或 a 自定义 range 使用 min 和 最大 值 你 选择.
- **选择 时间 Stamp**: 当 你 选择 a 时间 stamp 点 在 该 绘图, 该 声音 标签页 显示 该 数据 在 该 时间 stamp, 和 该 事件 标签页 显示 该 最近 事件 到 该 时间 stamp.

  > 图片已省略：Select Time Stamp
- **Bold 声音 标签页 选择**: 如果 你 选择 a plotting 声音 在 该 声音 标签页, 它的 绘图 是 显示 thicker 比 others 到 帮助 identify 该 选择.

### 虚拟 Loops

该 **虚拟 Loops** 标签页 显示 a 列表 的 所有 激活 声音 当前 跟踪 通过 该 renderer 但是 不 producing 样本 用于 该 混音器 由于 到 concurrency 或 距离 attenuation factors.

> 图片已省略：Virtual Loops tab

#### 虚拟 Loops 数据

该 数据 显示 在 该 虚拟 Loops 标签页. 你 可以 选择 其 数据 是 显示 使用 该 虚拟 Loop 控制项.

| 数据 | 说明 |
| --- | --- |
| **Play 顺序** | 显示 该 唯一 ID 给定 到 该 音频 源 在 该 引擎. 此 是 该 相同 值 使用 在 该 事件 标签页. |
| **名称** | 显示 该 .uasset 名称 用于 该 virtualized 混音器 源. |
| **时间 (Virtualized)** | 显示 该 时间 在 秒 since 此 声音 最后 sourced 样本 用于 该 混音器. |
| **时间 (Total)** | 显示 该 total playing 时间 在 秒 用于 此 声音, 两者 virtually 和 不. |
| **更新 Interval** | 显示 该 时间 在 秒 之间 位置 或 concurrency 更新 该 确定 如果 此 声音 remains 虚拟. 此 值 varies 使用 距离 从 该 renderer. |

#### 虚拟 Loops 控制项

> 图片已省略：Virtual Loops controls

- **Browse**: 点击 到 显示 该 选中 资产 在 该 内容 Browser (编辑器 仅).
- **打开**: 点击 到 打开 该 资产 编辑器 用于 该 选中 资产 (编辑器 仅).
- **数据 筛选**: 右侧-点击 在 该 列表 header bar 到 打开 a 上下文 菜单 你 可以 使用 到 选择 其 音频 数据 值 为 显示 用于 每个 混音器 源.
- **编辑 资产**: Double-点击 在 a 混音器 源 在 该 列表 显示 到 打开 该 资产 编辑器 使用 该 资产 (编辑器 仅).
- **选择**:

  - **单个-点击**: Selects a 虚拟 loop 和 draws a 调试 sphere 在 它的 位置.
  - **Shift-点击**: Multi-selects 虚拟 loops 和 draws a 调试 sphere 用于 每个 一个 选中 在 每个 位置.
  - **控制-点击**: 添加 a 虚拟 loop 到 a multi-选择 和 draws a 调试 sphere 在 它的 位置.
- **De-选择**: 控制-点击 a 选中 虚拟 loop 到 de-选择 它 和 移除 它的 调试 sphere.
- **调试 字符串**: 在 该 编辑器, 选中 资产 在 此 列表 显示 a 调试 字符串 在 该 位置 的 a virtualized 声音.

### 子混音

该 **子混音**标签页 lists 所有 该 声音 Submixes 在 该 当前 项目, 和 表示 其 ones 为 发送 激活 signals 在 该 moment. 你 可以 选择 a 设置 的 submixes 到 显示 信号 关卡 在 该 音频 Meters 标签页.

#### Submixes 数据

| 数据 | 说明 |
| --- | --- |
| **激活** | A dot 在 此 列 表示 一个 激活 信号 在 该 submix. |
| **选择** | 一个 启用 checkbox 在 此 列 表示 该 submix 关卡 显示 visually 在 meters 在 该 音频 Meters 标签页. 你 需要 到 手动 打开 该 音频 Meters 标签页 如果 它 是 不 可见 在 你的 当前 配置. |
| **名称** | 显示 该 声音 Submix 资产 名称. |

#### Submixes 控制项

你 可以 double-点击 a submix 在 该 列表 到 打开 该 资产 编辑器 用于 该 资产 (编辑器 仅).

到 reduce 数据 存储 和 unnecessary computations, 仅 submixes 使用 启用 checkboxes 发送 数据 用于 音频洞察 到 流程. 当 使用 音频洞察 使用 Unreal Insights 到 读取 a 追踪 文件, selecting a 特定 submix 用于 该 meter 标签页 是 禁用, 但是 该 启用 checkboxes do 显示 什么 submixes 曾 recorded 使用 meterable 数据. 如果 你 希望 到 inspect a 特定 submix 在 a 追踪 文件, 使 确保 你 选择 它 到 是 metered 当 你 为 录制 该 追踪.

### 音频总线

该 **音频总线** 标签页 lists 所有 该 音频 总线 在 该 当前 项目, 和 表示 其 ones 为 发送 激活 signals 在 该 moment. 你 可以 选择 a 设置 的 音频 总线 到 显示 信号 关卡 在 该 音频 Meters 标签页.

> 图片已省略：Audio Buses tab

#### 音频 总线 数据

| 数据 | 说明 |
| --- | --- |
| **激活** | A dot 在 此 列 表示 一个 激活 信号 在 该 音频 bus. |
| **选择** | 一个 启用 checkbox 在 此 列 表示 该 音频 bus 关卡 显示 visually 在 meters 在 该 音频 Meters 标签页. 你 需要 到 手动 打开 该 音频 Meters 标签页 如果 它 是 不 可见 在 你的 当前 配置. |
| **名称** | 显示 该 音频 Bus 资产 名称. |

#### 音频 总线 控制项

该 类型 筛选 提供 你 该 选项 到 显示 音频 Bus 资产, 代码-生成 音频 总线, 或 两者.

> 图片已省略：Audio Bus type filter

你 可以 double-点击 一个 音频 bus 在 该 列表 到 打开 该 资产 编辑器 用于 该 资产 (编辑器 仅).

到 reduce 数据 存储 和 unnecessary computations, 仅 音频 总线 使用 启用 checkboxes 发送 数据 用于 音频洞察 到 流程. 当 使用 音频洞察 使用 Unreal Insights 到 读取 a 追踪 文件, selecting a 特定 音频 bus 用于 该 meter 标签页 是 禁用, 但是 该 启用 checkboxes do 显示 什么 音频 总线 曾 recorded 使用 meterable 数据. 如果 你 希望 到 inspect a 特定 音频 bus 在 a 追踪 文件, 使 确保 你 选择 它 到 是 metered 当 你 为 录制 该 追踪.

### 音频 Meters

该 **音频 Meters** 标签页 显示 metered visualizations 的 两者 该 submixes (green 文本) 和 该 音频 总线 (blue 文本) 选中 在 该 respective 标签页. 该 metered 幅度 使用 a logarithmic dB 缩放. 每个 通道 在 a bus 配置 是 represented 使用 a 单独 meter 在 canonical speaker orders. 该 标签页 窗口 scrolls 到 accommodate 所有 该 选中 submixes 和 总线. 存在 为 no 控制项 用于 此 标签页.

### Analyzers

该 **Analyzers**标签页 是 a series 的 six real-时间 visualizations 的 该 引擎’s 主要 音频 输出, 一些 的 其 为 仅 可用 在 该 编辑器. 选择 该 visualizations 从 该 选项 菜单 在 该 upper 右侧 的 该 标签页. 该 analyzer 选项 为:

- **[Loudness](index.md#loudness-nbsp)**
- **[Meter](index.md#meter)**
- **[Oscilloscope](index.md#oscilloscope-nbsp)**
- **[Vectorscope](index.md#vectorscope-nbsp)**
- **[Spectrogram](index.md#spectrogram-nbsp)**
- [Spectrum Analyzer](index.md#spectrum-analyzer)

> 图片已省略：Audio Insights Analyzers

#### Loudness

该 **Loudness**analyzer 是 仅 可用 在 该 编辑器. 它 显示 该 主要 输出 loudness measurements 在 LUFS 值. 此 是 measured 超过 three 不同 窗口 lengths 的 音频 数据:

- **Momentary**: 400 ms
- **短 Term**: 3 秒
- **长 Term**: 上 到 60 秒

当 启用, 该 **时间**选项 提供 你 a 方式 到 参见 该 运行 窗口 的 时间 使用 用于 长 Term 和 该 reset 按钮 下一个 到 它 提供 a 方式 用于 你 到 restart 该 时间.

该 loudness measurements 使用 ITU-R BS.1770 标准 用于 perceptual weighting.

> 图片已省略：Loudness analyzer options

该 设置 菜单 提供 该 opportunity 到 视图 每个 的 该 不同 Loudness measurements 在 任一 或 两者 meter 或 numerical 值.

#### Meter

该 **Meter**显示 该 主要 输出 RMS 幅度 在 a logarithmic dB 缩放. 该 数量 的 通道 匹配 该 通道 配置 的 该 音频 设备. 存在 为 no 额外的 控制项 用于 此 analyzer.

> 图片已省略：Meter analyzer

#### Oscilloscope

该 **Oscilloscope**是 仅 可用 在 该 编辑器. 它 显示 a 时间 domain 采样 幅度 绘图 的 该 多数 最近 0.5 秒 的 音频 coming 从 该 主要 音频 输出. 该 缩放 是 a linear 浮点 从 -1.0 到 a 最大 的 1.0. 存在 为 no 额外的 控制项 用于 此 analyzer.

> 图片已省略：Oscilloscope analyzer

#### Vectorscope

该 **Vectorscope**是 仅 可用 在 该 编辑器. 它 显示 a linear 时间 domain 幅度 的 该 左侧 通道 在 该 horizontal axis 针对 该 右侧 通道 在 该 vertical axis. 此 是 good 用于 observing phase relationships 和 通道 coherence. 存在 为 no 额外的 控制项 用于 此 analyzer.

> 图片已省略：Vectorscope analyzer

#### Spectrogram

该 **Spectrogram**是 仅 可用 在 该 编辑器. 它 显示 a 频率 domain 绘图 的 该 多数 最近 音频 输出 mixed 到 a mono 通道. 时间 是 在 该 horizontal axis 和 音频 频率 是 在 该 vertical. 每个 vertical 行 在 该 绘图 represents a 单个 timed 窗口 的 音频 和 该 颜色 的 该 pixel represents 该 power 的 该 音频 信号 在 该 频率. 存在 为 多个 控制项 用于 该 绘图, 选中 通过 右侧 clicking anywhere 在 该 analyzer:

> 图片已省略：Spectrogram analyzer and controls

| Spectrogram 控制 | 说明 |
| --- | --- |
| Analyzer 设置 |  |
| **Analyzer 类型** | 你 可以 选择 之间 两个 选项 用于 如何 到 表示 该 音频 信号 在 该 频率 domain. 选项 为:**快速 Fourier 变换 (FFT)****Constant Q 变换 (CQT)** |
| **FFT 大小** | 控制项 该 数量 的 音频 样本 使用 在 每个 windowed transformation. A larger 大小 提供 greater 频率 resolution, 在 该 trade 关闭 的 lower 时间 resolution. |
| 显示 选项 |  |
| **Pixel 绘图 模式** | 你 可以 选择 如何 该 样本 为 weighted 到 显示 信号 strength. 你 可以 使用 此 到 emphasize transient frequencies 或 不. 选项 为:**采样****Peak****Average** |
| **频率 缩放** | 你 可以 选择 该 缩放 到 参见 不同 细节 在 该 spectrum. 选项 为:**Linear****Logarithmic** |
| **颜色 映射** | 你 可以 选择 什么 颜色 represents a greater 信号 strength. 选项 为:**White****Black** |
| **Orientation** | 选择 之间 a horizontal orientation (pictured 上方) 或 a vertical orientation, 其 swaps 该 axes so 时间 是 vertical 和 频率 是 horizontal. |

#### Spectrum Analyzer

该 **Spectrum Analyzer** 是 仅 可用 在 该 编辑器. 它 显示 一个 instantaneous 频率 domain 绘图 的 该 主要 输出 mixed 到 a mono 通道 使用 音频 频率 在 该 horizontal axis 和 信号 strength 在 该 vertical axis. 移动 该 mouse 到 a 特定 频率 将 显示 该 信号 strength 在 该 band 的 该 spectrum. 存在 为 多个 显示 选项 用于 此 analyzer.

> 图片已省略：Spectrum Analyzer and display options

| Spectrum Analyzer 控制 | 说明 |
| --- | --- |
| Analyzer 设置 |  |
| **Ballistics** | 你 可以 选择 之间 Analog 或 Digital, 其 simulates 该 信号 persistence 之间 音频 窗口 到 具有 该 appearance 的 analog 或 digital professional 音频 meters. 此 决定 如何 平滑 (analog) 或 precise (digital) 该 过渡 之间 frames 可以 是. |
| **Analyzer 类型** | 你 可以 选择 之间 两个 选项 用于 如何 到 表示 该 音频 信号 在 该 频率 domain. 选项 为: **快速 Fourier 变换 (FFT)** **Constant Q 变换 (CQT)** |
| **FFT 大小** | 控制项 该 数量 的 音频 样本 使用 在 每个 windowed transformation. A larger 大小 提供 greater 频率 resolution, 在 该 trade 关闭 的 lower 时间 resolution. |
| 显示 选项 |  |
| **Tilt Spectrum** | 你 可以 attenuate 每个 频率 到 flatten 输出 该 图表 的 a spectrum weighted 在 该 lower frequencies. |
| **Pixel 绘图 模式** | 你 可以 选择 如何 该 样本 为 weighted 到 显示 信号 strength. 你 可以 使用 此 到 emphasize transient frequencies 或 不. 选项 为:**采样****Peak****Average** |
| **频率 缩放** | 你 可以 选择 该 缩放 到 参见 不同 细节 在 该 spectrum. 选项 为:LinearLogarithmic |
| **显示 频率 Axis 标签** | 当 启用, 标签 该 horizontal 图表 grid lines 使用 numerical 值 在 Hertz. |
| **显示 声音 关卡 Axis 标签** | 当 启用, 标签 该 vertical 图表 grid lines 使用 numerical 值 在 decibels. |

### 控制 总线 (编辑器 仅)

该 **音频 Modulation** 插件 提供 你 该 表示 到 创建 控制 总线 该 可以 修改 pitch, volume, 筛选, 和 其他 值 用于 音频 源 和 submixes. 用于 音频 Modulation 数据 到 显示 上 在 音频洞察, 你 必须 还 启用 该 音频 Modulation Insights 插件.

该 **控制 Bus** 标签页 显示 该 当前 numerical 值 用于 每个 激活 控制 bus, formatted 作为 a 浮点 值 之间 0.0 和 1.0. 该 pitch, volume, 和 筛选 值 seen 在 该 源 和 声音 标签页 reflect 该 influence 的 该 控制 总线 显示 此处.

> 图片已省略：Control Bus tab

存在 为 no 额外的 显示 或 控制 选项 在 此 标签页.

### Modulation Matrix (编辑器 仅)

控制 总线 在 该 音频 Modulation 插件 可以 是 已添加 一起 到 创建 cumulative effects. 该 **Modulation Matrix** 标签页 提供 insight 到 该 不同 总线 当前 激活 和 如何 它们 为 collaborating 到 affect 音频 源.

> 图片已省略：Modulation Matrix tab

存在 为 no 额外的 显示 或 控制 选项 在 此 标签页.

