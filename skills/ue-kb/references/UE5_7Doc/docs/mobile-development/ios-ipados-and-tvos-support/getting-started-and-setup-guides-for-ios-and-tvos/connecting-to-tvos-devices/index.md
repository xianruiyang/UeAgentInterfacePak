---
title: "连接到tvOS设备"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/connecting-to-tvos-devices-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "iOS、iPadOS和tvOS", "虚幻引擎中iOS和tvOS相关的入门指南", "连接到tvOS设备"]
---

# 连接到tvOS设备

> 路径：虚幻引擎5.7文档 / 移动端开发 / iOS、iPadOS和tvOS / 虚幻引擎中iOS和tvOS相关的入门指南 / 连接到tvOS设备

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/connecting-to-tvos-devices-in-unreal-engine

**AppleTV** 设备使用类似于iOS设备的方法在Xcode中启动和调试项目。但是，由于最新的tvOS设备没有USB端口，你需要改为使用局域网访问这些设备。本页面将展示如何设置tvOS设备，以便你可以使用虚幻编辑器的 **设备管理器（Device Manager）** 或Xcode连接到该设备。

## 连接tvOS设备

理想情况下，虚幻编辑器的设备管理器和Xcode都应该通过局域网自动识别你的tvOS设备。按照以下核对清单操作，确保该设备对你的计算机可见：

1. 确保你的tvOS设备通过以太网电缆连接到本地网络。虽然也可以通过WiFi连接到Apple TV，但以太网连接更稳定可靠。
2. 在虚幻编辑器的主菜单中，选择 **窗口（Window）** > **开发人员工具（Developer Tools）** > **设备管理器（Device Manager）**。
3. 在"设备管理器（Device Manager）"窗口中，验证你的tvOS设备是否可见。
4. 如果你的tvOS设备不可见，请点击 **连接到IP（Connect to IP）**，然后键入Apple TV的IP地址。

你的Apple TV在设备管理器中可见之后，就可以按照与iOS设备相同的工作流程来[启动和调试项目](../../../debugging-and-optimization-for-mobile/ios-and-tvos-debugging-and-optimization/debugging-ios-projects-with-xcode/index.md)。
