---
title: "流送设置"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/streaming-settings-of-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "引擎", "流送设置"]
---

# 流送设置

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 引擎 / 流送设置

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/streaming-settings-of-the-unreal-engine-project-settings

## 流送

### 包流送

| **分段** | **说明** |
| --- | --- |
| **异步加载线程启用（Async Loading Thread Enabled）** | 为包流送启用单独线程。 更改此设置需要重新启动虚幻引擎。 |
| **超过时间限制时发出警告（Warn If Time Limit Has Been Exceeded）** | 启用在超过用于时间切片包流送的时间限制时的日志警告。 |
| **超过时间限制警告乘数（Time Limit Exceeded Warning Multiplier）** | 记录警告消息之前的时间限制乘数。 |
| **超过时间限制的最短时间限制警告（Minimum Time Limit For Time Limit Exceeded Warning）** | 加载包时记录警告消息之前的最短时间。 |
| **异步加载的最小批量数据大小（废弃）（Minimum Bulk Data Size For Async Loading (deprecated)）** | 触发时间限制超过警告时的最短时间。此设置已被弃用，不应再使用。 |

### 关卡流送

| **分段** | **说明** |
| --- | --- |
| **使用背景关卡流送（Use Background Level Streaming）** | 定义是否允许背景关卡流送。 |
| **异步加载使用完全时间限制（Async Loading Use Full Time Limit）** | 定义是否即使在I/O上被阻止时仍使用整个时间限制。 |
| **异步加载时间限制（Async Loading Time Limit）** | 执行异步加载所用的最长时间，以毫秒/帧为单位。 |
| **优先级异步加载额外时间（Priority Async Loading Extra Time）** | 高优先级加载期间执行异步加载所用的额外时间。 |
| **Actor初始化更新时间限制（Actor Initialization Update Time Limit）** | 关卡流送期间用于Actor注册步骤的最长允许时间，以毫秒/帧为单位。 流送一个关卡可能需要相当长的时间。使用该值，你可以控制虚幻引擎执行Actor初始化所用的每帧时间。 |
| **优先级Actor初始化更新额外时间（Priority Actor Initialization Update Extra Time）** | 高优先级加载期间或无缝漫游时要用于Actor注册步骤的额外时间，以毫秒/帧为单位。 高优先级加载由 **世界设置（World Settings）** 面板的复制标记 `bHighPriorityLoading` 驱动。 |
| **组件注册粒度（Components Registration Granularity）** | 关卡流送期间用于注册Actor组件的批量粒度。 该数字将控制在更新或注册多少个组件之后，引擎再次检查向世界添加关卡所允许的时间限制（每帧）。 |
| **增加了图元粒度（Added Primitive Granularity）** | 在关卡流送期间注册Actor组件时，用于向场景并行添加图元的批量粒度。 如果将此选项设置为0时，没有并行注册。 |
| **组件注销更新时间限制（Component Unregister Update Time Limit）** | 关卡流送期间注销组件所用的最长允许时间，以毫秒/帧为单位。 类似于将关卡流送进入世界，流送出关卡也可能需要不少时间。 这可用于控制引擎从世界删除关卡所用的每帧时间。 |
| **组件注销粒度（Components Unregistration Granularity）** | 关卡流送期间用于注销Actor组件的批量粒度。 该数字控制在注销多少个组件之后，引擎再次检查从世界删除关卡所允许的时间限制（每帧）。 |

### 通用

| **分段** | **说明** |
| --- | --- |
| **退出应用程序时清空流送（Flush Streaming when Exiting the Application）** | 如果启用，将在退出应用程序时清空流送，否则会将取消流送。 |

### 废弃设置

| **分段** | **说明** |
| --- | --- |
| **使用事件驱动的加载程序（不推荐禁用）（Use Event-Driven Loader (Disabling Not Recommended)）** | 在烘焙的构建中启用事件驱动的加载程序（EDL）。此设置默认启用。 禁用此选项将使用废弃加载路径。因此不推荐禁用EDL。 |
