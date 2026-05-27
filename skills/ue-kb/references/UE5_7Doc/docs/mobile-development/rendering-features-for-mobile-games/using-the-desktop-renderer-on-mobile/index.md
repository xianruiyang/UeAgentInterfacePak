---
title: "移动端桌面渲染器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-the-desktop-renderer-on-mobile-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "移动端渲染功能", "移动端桌面渲染器"]
---

# 移动端桌面渲染器

> 路径：虚幻引擎5.7文档 / 移动端开发 / 移动端渲染功能 / 移动端桌面渲染器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-the-desktop-renderer-on-mobile-in-unreal-engine

虚幻引擎（UE）为iOS设备和使用Vulkan的Android设备提供前向和延迟桌面渲染器支持。这将使用与PC和主机平台相同的渲染路径。

> [!NOTE]
> 在功能就绪方面，桌面渲染器的iOS实现方案被视为测试版。Android Vulkan实现方案被视为试验版。

## 如何在移动端启用桌面渲染器

以下小节介绍了如何在iOS和Android上启用桌面渲染器。

### iOS/tvOS/iPadOS

要为iOS启用桌面渲染器，请按照以下步骤操作：

1. 打开你的 **项目设置（Project Settings）** 。
2. 找到 **平台（Platforms）**> **iOS**> **渲染（Rendering）** 。
3. 启用 **Metal桌面渲染器（Metal Desktop Renderer）** 。

### Android Vulkan

要为Android Vulkan启用桌面渲染器，请按照以下步骤操作：

1. 打开你的 **项目设置（Project Settings）** 。
2. 找到 **平台（Platforms）** > **Android** > **构建（Build）** 。
3. 启用 **支持Vulkan桌面（Support Vulkan Desktop）[试验性]** 。
4. 将 `r.Android.DisableVulkanSupport` 设置为0，以确保启用Android Vulkan。
5. 将 `r.Android.DisableVulkanSM5Support` 设置为 `0`，以允许使用着色器模型5 (SM5)。

### 完成设置并配置桌面渲染器

必须重启虚幻编辑器，以使更改生效。随后即可采用与在桌面应用程序中相同的方式来配置前向和延迟渲染功能。

## 设备兼容性

桌面渲染器仅适用于可使用着色器模型5（SM5）的移动设备。

## 优势

此桌面渲染器提供与台式机和游戏主机一致的高保真渲染。

## 缺点

与移动前向和移动延迟着色路径相比，桌面渲染器的资源开销较高，并且大多数移动硬件的设置方式无法支持高效运行桌面渲染器。

## 何时使用桌面渲染器

对于iOS设备，该桌面渲染器被视为测试版，对于Android Vulkan，被视为试验版。我们不建议将其用于已发布项目，但如果你决定试用该功能，欢迎你提供反馈。
