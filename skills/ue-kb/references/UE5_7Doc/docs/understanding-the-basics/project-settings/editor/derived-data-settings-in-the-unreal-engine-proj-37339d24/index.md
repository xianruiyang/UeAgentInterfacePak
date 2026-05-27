---
title: "派生数据设置"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/derived-data-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "Editor", "派生数据设置"]
---

# 派生数据设置

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / Editor / 派生数据设置

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/derived-data-settings-in-the-unreal-engine-project-settings

## 派生数据

### 警告

| **部分** | **描述** |
| --- | --- |
| **启用警告（Enable Warnings）** | 当某些配置没有设置或者使用时出现警告。 下面的 "建议（Recommend）" 设置可以检查[DDC](../../../../production-pipeline/using-derived-data-cache/index.md)如何配置，如果一些配置没有设置或使用，可以在编辑器启动的时候显示弹窗提示信息。 |
| **建议所有人设置A全局本地DDCPath（Recommend Everyone Setup AGlobal Local DDCPath）** | 如果本地缓存没有通过 `UE-LocalDataCachePath` 环境变量或者编辑器设置 `Global Local DDC Path` 进行设置，弹出警告。 |
| **建议所有人设置A全局共享DDCPath（Recommend Everyone Setup AGlobal Shared DDCPath）** | 如果共享缓存没有通过 `UE-SharedDataCachePath` 环境变量或者编辑器设置 `Global Shared DDC Path` 进行设置，弹出警告。 |
| **建议所有人设置A全局S3DDCPath（Recommend Everyone Setup AGlobal S3DDCPath）** | 如果编辑器设置 `Enable AWS S3 Cache` 被停用，弹出警告。 |
| **建议所有人启用S3DDC（Recommend Everyone Enable S3DDC）** | 如果编辑器设置 `Global Local S3DDC Path` 没有设置，弹出警告。 |
| **建议所有人使用Unreal Cloud DDC（Recommend Everyone Use Unreal Cloud DDC）** | 如果没有使用Unreal Cloud DDC存储，弹出警告。 |
