---
title: "移动端调试和优化"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/debugging-and-optimization-for-mobile-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "移动端调试和优化"]
---

# 移动端调试和优化

> 路径：虚幻引擎5.7文档 / 移动端开发 / 移动端调试和优化

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/debugging-and-optimization-for-mobile-in-unreal-engine

与桌面级硬件和主机平台相比，许多移动设备都存在很大的硬件限制，特别是在图形功能的兼容性方面。 为解决此问题，**虚幻引擎**为移动设备提供了备用的渲染路径。 该渲染路径在处理虚幻的许多渲染功能时（例如阴影和纹理），使用了简化的或面向性能的模型，并且删除了许多不支持的后期处理效果。 本节中的指南提供了关于移动渲染器的配置选项和功能的详细信息。

- [移动设备上的网格体自动实例化](using-mesh-auto-instancing-on-mobile-devices/index.md) - 在移动设备上启用网格体自动实例化。
- [移动设备的帧平滑](frame-pacing-for-mobile-devices/index.md) - 为移动设备启用并自定义帧平滑
- [移动端的渲染优化技巧](optimization-and-development-best-practices-for-f2fc3d86/index.md) - 有关如何优化移动设备性能以及从移动端HDR功能获取最高保真度的指南和最佳实践
- [Android调试](debugging-for-android-devices/index.md) - 介绍如何使用Visual Studio、Android Studio和虚幻引擎的调试工具在设备上调试Android应用程序。
- [虚幻引擎Android优化指南](optimization-guides-for-android/index.md) - 关于优化Android项目性能的最佳实践。
- [iOS和tvOS的调试和优化](ios-and-tvos-debugging-and-optimization/index.md) - 介绍如何使用Xcode来启动iOS/tvOS应用并调试它们的方法
