# AndroidFileServer

---
title: "AndroidFileServer"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/androidfileserver-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "插件设置", "AndroidFileServer"]
---

# AndroidFileServer

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 插件设置 / AndroidFileServer

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/androidfileserver-settings-in-the-unreal-engine-project-settings

## AndroidFileServer

### 打包

| **设置** | **说明** |
| --- | --- |
| **使用AndroidFileServer（Use AndroidFileServer）** | 启用AndroidFileServer插件。 |
| **允许网络连接（Allow Network Connection）** | 允许使用网络的FileServer连接。 |
| **安排令牌（Security Token）** | 启动FileServer所需的可选安排令牌（留空以禁用）。 |
| **包含在发售中（Include in Shipping）** | 在发售版本中嵌入FileServer。 |
| **在发售中允许外部启动（Allow External Start in Shipping）** | 允许FileServer使用UnrealAndroidFileTool在发售版本中启动。 |
| **编译AFSProject（Compile AFSProject）** | 编译独立AFS项目（Compile standalone AFS project）。 |

### 部署

| **设置** | **说明** |
| --- | --- |
| **使用压缩（Use Compression）** | 在数据传输期间启用压缩。 |
| **日志文件（Log Files）** | 记录传输的文件。 |
| **报告统计数据（Report Stats）** | 报告传输速率统计数据。 |

### 连接

| **设置** | **说明** |
| --- | --- |
| **连接类型（Connection Type）** | 定义如何连接到文件服务器。你可以从以下选项中选择： **仅USB（USB Only）** **仅网络（Network Only）** **USB和网络合并（USB and Network Combined）** |
| **使用手动IP地址？（Use Manual IP Address?）** | 定义是否使用手动IP地址而不是来自设备的自动查询。仅用于单设备部署。 |
| **手动IP地址（Manual IP Address）** | 要使用的设备的IP地址。 |

