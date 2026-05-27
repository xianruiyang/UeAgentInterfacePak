---
title: "协作查看器（Collab Viewer）联网要求"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/networking-requirements-for-the-collab-viewer-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "XR开发入门", "协作查看器（Collab Viewer）模板", "协作查看器（Collab Viewer）联网要求"]
---

# 协作查看器（Collab Viewer）联网要求

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / XR开发入门 / 协作查看器（Collab Viewer）模板 / 协作查看器（Collab Viewer）联网要求

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/networking-requirements-for-the-collab-viewer-in-unreal-engine

本页介绍使用协作查看器（Collab Viewer）模板将多台计算机接入同一运行时设计查阅会话时所涉及的一些网络要求和注意事项。

## 通过局域网连接

[快速入门](../collab-viewer-template-quick-start/index.md)页面的操作指示讲述了如何在简单局域网中连接运行的多台计算机。这种情况下，只要满足以下条件即可：

1. 所有计算机均已连接到同一网络。
2. 所有计算机均配备虚幻引擎标准网络端口

   7777

   ，用于此网络内通信。
3. 没有设置任何中间网络组件（如路由器或网络地址遍历(NAT)服务）来屏蔽连接。

若出现连接问题，请联系网络管理员。

## 在网络间连接

若要让计算机跨多个子网或通过开放式互联网加入会话，则需要执行一些额外的网络配置。具体执行步骤取决于网络配置。通常如下：

- 服务器主机需要经由特定IP地址，对所有客户端可见。这可能需要在路由器上设置NAT遍历规则，并开启防火墙让端口7777上进行对外通信。
- 不要期待自动服务器检测功能在同一网络之外仍适用。客户端需要手动指定要与之连接的服务器IP地址。

> [!NOTE]
> 为避免延迟和滞后，最好在同一网络内本地使用协作查看器（Collab Viewer）。

## 带宽要求

由于协作查看器（Collab Viewer）模板仅复制网络上的轻量级数据，例如会话中用户的3D变换及激光笔，所以网络带宽的使用应相对较低。若要精确测量，可使用[网络分析器](../../../../../gameplay-systems/networking-and-multiplayer/network-debugging/using-the-network-profiler/index.md)分析此模板在网络上的执行方式。

## 其他资源

有关虚幻引擎中联网操作的详情，请参阅[联网和多人游戏](../../../../../gameplay-systems/networking-and-multiplayer/index.md)部分的文档。
