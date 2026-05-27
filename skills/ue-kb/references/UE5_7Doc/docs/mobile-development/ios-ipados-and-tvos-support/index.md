---
title: "iOS、iPadOS和tvOS"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/ios-ipados-and-tvos-support-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "iOS、iPadOS和tvOS"]
---

# iOS、iPadOS和tvOS

> 路径：虚幻引擎5.7文档 / 移动端开发 / iOS、iPadOS和tvOS

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/ios-ipados-and-tvos-support-for-unreal-engine

**虚幻引擎** 支持发布到 **iOS** 和 **tvOS** 设备。这些平台的开发需要进行专门的设置，需要一台运行 **MacOS** 的机器来为Apple生态系统中的C++项目进行签名构建，并且你需要使用 **Xcode** 调试iOS和tvOS设备上的构建。本小节将介绍如何使用这些工具，在你的团队主要使用Windows时如何简化工作流程，以及如何充分利用iOS和tvOS功能。此外，iOS和tvOS的工作流程大体相同，这些指南介绍了它们之间的一些差异。

## 入门指南

- [连接到tvOS设备](getting-started-and-setup-guides-for-ios-and-tvos/connecting-to-tvos-devices/index.md) - 设置测试和调试管线，用于通过局域网连接tvOS。

## 适用于Windows用户的iOS和tvOS

- [用Windows系统编译iOS项目](working-on-ios-projects-using-a-windows-machine/creating-remote-builds-of-unreal-engine-projects-for-ios/index.md) - 如何从安装Windows系统的计算机上对Mac进行远程编译，从而创建iOS项目。

- [Windows Metal Shader编译器](working-on-ios-projects-using-a-windows-machine/using-the-windows-metal-shader-compiler-for-ios/index.md) - 将Windows Metal Shader编译器用于iOS项目

## 开发指南

- [处理iOS输入](developing-on-ios-tvos-and-ipados/working-with-ios-input/index.md) - 本指南介绍如何在iOS、tvOS和iPadOS 14及更高版本上使用外部输入设备

- [本地化iOS项目中的plist和NSLocalizedString](developing-on-ios-tvos-and-ipados/localizing-plist-and-nslocalizedstring-in-an-ios-project/index.md) - 本页面将显示如何识别项目代码中需要翻译的字符串。

- [iOS故事板启动](developing-on-ios-tvos-and-ipados/setting-up-ios-launch-storyboards-in-unreal-eng-89dfac39/index.md) - 在虚幻引擎项目中为iOS设置启动画面故事板

## 打包和发布

- [打包iOS项目](packaging-and-publishing-android-projects/packaging-ios-projects/index.md) - 了解如何打包虚幻引擎iOS项目

## 调试

- [访问iOS和tvOS上的日志和崩溃报告](../debugging-and-optimization-for-mobile/ios-and-tvos-debugging-and-optimization/accessing-logs-and-crash-reports-on-ios-and-tvos/index.md) - 直接从设备或从TestFlight下载并阅读iOS和tvOS日志和崩溃报告。

- [使用Xcode调试iOS项目](../debugging-and-optimization-for-mobile/ios-and-tvos-debugging-and-optimization/debugging-ios-projects-with-xcode/index.md) - 使用Xcode在设备上启动项目，以及使用断点和LLDB命令调试项目。

- [使用远程会话插件进行iOS开发](../debugging-and-optimization-for-mobile/ios-and-tvos-debugging-and-optimization/using-the-remote-session-plugin-for-ios-development/index.md) - 在PC上复制iOS设备的输入，以便进行测试。

- [使用Xcode iOS模拟器](../debugging-and-optimization-for-mobile/ios-and-tvos-debugging-and-optimization/using-the-xcode-ios-simulator-with-unreal-engin-6ff7b645/index.md) - 无需实体设备，使用Xcode的iOS模拟器在各种iOS设备上测试你的项目。

## 优化

- [iOS游戏包体大小](../debugging-and-optimization-for-mobile/ios-and-tvos-debugging-and-optimization/optimizing-packaged-game-size-for-ios-projects/index.md) - 影响iOS已打包游戏大小的因素。
