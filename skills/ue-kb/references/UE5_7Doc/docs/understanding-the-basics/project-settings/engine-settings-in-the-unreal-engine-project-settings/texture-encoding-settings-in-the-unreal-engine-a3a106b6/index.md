---
title: "纹理编码"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/texture-encoding-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "引擎", "纹理编码"]
---

# 纹理编码

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 引擎 / 纹理编码

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/texture-encoding-settings-in-the-unreal-engine-project-settings

## 纹理编码

### 编码速度设置

| **分段** | **说明** |
| --- | --- |
| **最终使用RDO（Final Uses RDO）** | 如果为true，以压缩格式保存到磁盘时，纹理编码的速度将使支持的编码器上的率失真优化（RDO）能够降低压缩包文件中的纹理的磁盘大小。 此率失真代价由称为[lambda](../../../../testing-and-optimizing-content/using-oodle/index.md#%E7%90%86%E8%A7%A3lambda)的参数控制。 纹理上的 `LossyCompressionAmount` 参数用于控制它。 特定 `LossyCompressionAmount` 值对应于RDO lambda： 无 - 禁用此纹理的RDO。 最低 - 1（最小失真） 低 - 10 中 - 20 高 - 30 最高 - 40 如果设置为默认值，则改用纹理的LODGroup（纹理组）中的 `LossyCompressionAmount` 。如果 `LossyCompressionAmount` 也是默认值，则使用本文中所提到的 **最终RDO Lambda（Final RDO Lambda）**。 请注意，引入的失真叠加在格式本身引入的失真之上，并且前者很可能小于后者。 |
| **最终RDO Lambda（Final RDO Lambda）** | **最终使用RDO（Final Uses RDO）** 为false时忽略。 如果给定纹理使用的 `LossyCompressionAmount` 被设置为默认值，将使用该值。 否则，`LossyCompressionAmount` 的值将转换为固定lambda（请参阅本文中的 **最终使用RDO（Final Uses RDO）** 一节）。 低值(1)表示最高质量结果（最小失真）。 |
| **最终工作级别（Final Effort Level）** | 指定尝试多少时间来获得更好的编码结果。 你可以选择以下选项： **默认值（Default）：** 让编码器决定最佳选项。 **低（Low）：** 更快编码，更低质量。该质量级别不推荐用于最终打包的项目。 **普通（Normal）：** 提供编码时间与质量平衡的输出。 **高（High）：** 花费时间最长，质量最好。推荐在夜间编译和自动烘焙时使用。 |
| **最终通用平铺（Final Universal Tiling）** | 为磁盘上的平铺纹理布局优化了纹理编码。 这仅应用于启用了RDO（**快速使用RDO** 或 **最终使用RDO**）的Oodle。 对于大多数用例，推荐使用256KB。 对带有公开纹理平铺的平台（即主机），启用此选项可减少纹理的磁盘大小，但对带有不透明平铺的平台（台式机平台）会稍微增加纹理大小。 你可以选择以下选项： **禁用（Disabled）** **启用256 KB（Enabled 256 KB）** **启用64 KB（Enabled 64 KB）** |
| **快速使用RDO（Fast Uses RDO）** | 如果启用，最终编码速度会使支持的编码器上的率失真优化能够降低压缩包文件中的纹理的磁盘大小。 此率失真代价由称为[lambda](../../../../testing-and-optimizing-content/using-oodle/index.md#%E7%90%86%E8%A7%A3lambda)的参数控制。 纹理上的 `LossyCompressionAmount` 参数用于控制它。 特定 `LossyCompressionAmount` 值对应于RDO lambda： 无 - 禁用此纹理的RDO。 最低 - 1（最小失真） 低 - 10 中 - 20 高 - 30 最高 - 40 如果将其设置为默认值，则使用纹理的LODGroup中的 `LossyCompressionAmount` 。如果这也被设为默认值，则使用本文中提到的 **RDOLambda**设置。 请注意，引入的失真叠加在格式本身引入的失真之上，并且前者很可能小于后者。 |
| **快速RDO Lambda（Fast RDO Lambda）** | **UsesRDO** 为false时忽略。 如果给定纹理的 `LossyCompressionAmount` 被设为默认值，将使用该值。 否则，`LossyCompressionAmount` 的值将转换为固定lambda（请参阅文本中的 **Uses RDO** 设置）。 较低的值表示更高质量结果。1表示最小失真。 |
| **快速工作级别（Fast Effort Level）** | 指定尝试多少时间来获得更好的编码结果。 你可以选择以下选项： **默认值（Default）：** 让编码器决定最佳选项。 **低（Low）：** 更快编码，更低质量。该质量级别不推荐用于最终打包的项目。 **普通（Normal）：** 提供编码时间与质量平衡的输出。 **高（High）：** 花费时间最长，质量最好。推荐在夜间编译和自动烘焙时使用。 |
| **快速通用平铺（Fast Universal Tiling）** | 优化磁盘上的平铺纹理布局优化了纹理编码。 这仅应用于启用了RDO的Oodle。 对于大多数用例，推荐使用256KB。 对于带有公开纹理平铺的平台（主机），启用此项将减少纹理的磁盘大小，但对带有不透明平铺的平台（台式机），会稍微增加纹理大小。 |

### 编码速度

| **分段** | **说明** |
| --- | --- |
| **烘焙使用速度（Cook Uses Speed）** | 定义非交互式编辑器会话（命令）将使用的编码速度。 你可以选择以下选项： **最终（Final）：** 使用 `UTextureEncodingProjectSettings` 中的最终（Final）编码速度设置。 **可用时的最终（Final if Available）：** 尝试获取最终编码速度设置。如果不存在，则使用快速编码速度。 **快速（Fast）：** 使用 `UTextureEncodingProjectSettings` 中的"快速（Fast）"编码速度设置。 |
| **编辑器使用速度（Editor Uses Speed）** | 定义其他所有内容使用的编码速度。 你可以选择以下选项： **最终（Final）：** 使用 `UTextureEncodingProjectSettings` 中的"最终（Final）"编码速度设置。 **可用时的最终（Final if Available）：** 尝试获取最终编码速度设置。如果不存在，则使用快速编码速度。 **快速（Fast）：** 使用 `UTextureEncodingProjectSettings` 中的"快速（Fast）"编码速度设置。 |
