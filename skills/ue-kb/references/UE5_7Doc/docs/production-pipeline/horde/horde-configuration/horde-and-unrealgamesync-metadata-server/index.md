---
title: "Horde和UnrealGameSync元数据服务器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/horde-and-unrealgamesync-metadata-server-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Horde", "Horde配置", "Horde和UnrealGameSync元数据服务器"]
---

# Horde和UnrealGameSync元数据服务器

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Horde / Horde配置 / Horde和UnrealGameSync元数据服务器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/horde-and-unrealgamesync-metadata-server-for-unreal-engine

UnrealGameSync（ **UGS** ）是一款旨在简化从Perforce进行同步操作的工具，它支持为美术师检索预编译的编辑器二进制文件，也支持对本地构建进行正确的版本管理，以便工程师修改内容。它是一个便捷中心，可用于展示构建健康状况、标记问题，以及在虚幻编辑器之外对常见工作流程任务进行脚本编写。

如需详细了解UGS，请参阅[UnrealGameSync](../../../deploying/unrealgamesync-ugs/index.md)文档。

Horde包含与UGS一起发布的旧版MetadataServer IIS Web应用程序的更新版本，可与Horde的CI功能实现无缝集成。

## 配置

要将UnrealGameSync配置为从Horde获取数据，请在 `UnrealGameSync.ini` 配置文件中添加以下几行：

```
[Default]ApiUrl=https://{{ HORDE_SERVER_URL }}/ugs
```

此配置文件可以位于特定项目的位置（例如 `{{ PROJECT_DIR }}/Build/UnrealGameSync.ini` ），也可以位于应用于流中所有项目的位置（例如 `{{ ENGINE_DIR }}/Programs/UnrealGameSync/UnrealGameSync.ini` ）。
