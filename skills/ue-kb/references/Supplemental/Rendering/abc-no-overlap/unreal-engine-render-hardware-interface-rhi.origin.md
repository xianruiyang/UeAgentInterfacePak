# 渲染硬件接口 (RHI)

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/aqV9/unreal-engine-render-hardware-interface-rhi

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 1220 字符。

## 摘要

这个简短的教程展示了如何更改 UE5 编辑器中的默认 RHI。它还修复了“GPU 崩溃或 D3D 设备已删除”错误。

## 中文整理

### 概览

渲染硬件接口 (RHI) 是多个特定于平台的图形 API 之上的抽象层。它从头开始设计，充分利用 DirectX 12、Vulkan 和 Metal 2.0。要更改 UE5 项目中的 RHI 设置，您可以： 编辑“...../path_to_your_UE5_project/config/DefaultEngine.ini”并将 DefaultGraphicsRHI=DefaultGraphicsRHI_DX12 更改为您首选的 RHI（例如 DX11 或 Vulkan） 请参阅下面的示例以使用 DirectX 11 而不是 12：[/Script/WindowsTargetPlatform.WindowsTargetSettings] DefaultGraphicsRHI=DefaultGraphicsRHI_DX11 转到“编辑 → 项目设置 → 平台 → Windows → 默认 RHI”，然后选择 DirectX 11 或 Vulkan。请注意，在 2022 年 4 月 5 日发布的 UE5 当前版本及更早版本中，在 Windows 上使用流明（作为动态全局照明方法）的默认 RHI (DX12) 时，会出现视频内存耗尽消息。使用其他方法会删除该消息，但 UE5 引擎最终会崩溃，并出现“GPU 崩溃或 D3D 设备已删除”错误。为了消除这两个错误，我使用 DirectX 11

作为我的 RHI 设备。我还没有测试 Vulkan。见下图。 Shabayek - 性能和分析



## 相关链接

- [Render Hardware Interface (RHI)](https://www.o3de.org/docs/atom-guide/dev-guide/rhi/rhi/)

