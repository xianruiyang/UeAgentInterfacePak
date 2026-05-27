---
title: "TCP消息传递"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/tcp-messaging-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "插件设置", "TCP消息传递"]
---

# TCP消息传递

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 插件设置 / TCP消息传递

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/tcp-messaging-settings-in-the-unreal-engine-project-settings

## TCP消息传递

### 传输

| **设置** | **说明** |
| --- | --- |
| **启用传输（Enable Transport）** | 定义是否启用TCP传输通道。 |
| **监听端点（Listen Endpoint）** | 要在其中监听传入的连接的IP端点。 格式为 `IP_ADDRESS:PORT_NUMBER` 。留空以禁用监听。 |
| **连接到端点（Connect to Endpoints）** | 要尝试对其建立传出连接的IP端点。 使用此设置可连接到远程对等端。 格式为 `IP_ADDRESS:PORT_NUMBER` 。 |
| **连接重试延迟（Connection Retry Delay）** | 在传出连接已断开连接或连接失败时，重新建立连接的相邻两次尝试之间的延迟时间。 使用 `0` 会禁用重新连接。 |
