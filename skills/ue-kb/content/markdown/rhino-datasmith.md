# 从Rhino中导出Datasmith内容

---
title: "从Rhino中导出Datasmith内容"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/exporting-datasmith-content-from-rhino-to-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Datasmith", "Datasmith软件交互指南", "Rhino", "从Rhino中导出Datasmith内容"]
---

# 从Rhino中导出Datasmith内容

> 路径：虚幻引擎5.7文档 / 管理内容 / Datasmith / Datasmith软件交互指南 / Rhino / 从Rhino中导出Datasmith内容

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/exporting-datasmith-content-from-rhino-to-unreal-engine

安装好用于Rhino的Datasmith导出器插件后，在保存或导出场景时，选项中将出现 **虚幻Datasmith**（`.udatasmith`） 文件类型。

![新的Rhino导出选项](../../../../../../assets/images/a8/a80d043561df198f511040e02f04b7448bdc15d12cf3725880502b8c9eb20073.png)

请在Rhino中按照下述步骤使用此新文件类型导出场景。

从Rhino的文件（File）菜单中，选择以下选项中的一项：

![Rhino导出菜单](../../../../../../assets/images/cb/cb8c2c523d330569c1635112e0791f620fa98ce20c7556ab780681fa856b4a7d.png)

- **另存为（Save As）**：生成 **.udatasmith* file 文件，其中包含所有可见元素。
- **导出选中项...**: 生成 **.udatasmith* file 文件，其中包含所有被选中的元素。不包含任何选定元素的层不会被导出。
- **导出并设定原点...**: 生成 **.udatasmith* file 文件，其中包含所有可见元素。导出场景并设定位置偏移。

在 **导出（Export）** 窗口中，从 **保存类型（Save As type）** 下拉列表中选择 **虚幻Datasmith（*.udatasmith）** 选项。

![Rhino导出文件类型](../../../../../../assets/images/60/60876dfc138c6fab30d5bbc8ee44b64732e10eebe514d98a1aaf7cf928a8e205.jpg)

浏览到希望保存导出文件的位置，设置 **文件名**，然后点击 **保存（Save）**。

或者，点击Datasmith工具栏中的 **导出3D视图** 按钮。这会创建一个包含所有可视元素的 `.udatasmith` 文件。

![Datasmith toolbar Export 3D View button](../../../../../../assets/images/dd/dda6833574744e48d046dcfa7e7cbeed02cb12d56e54d543f20c167f0244e2a3.png)

关于Datasmith工具栏的更多详情，请参阅[使用Datasmith工具栏](../index.md#%E5%B7%A5%E5%85%B7%E6%A0%8F)。

## 最终结果

现在你应该可以试着将 `.udatasmith` 文件导入虚幻引擎了。参阅[将Datasmith内容导入到虚幻引擎中](../../../datasmith-tutorials/importing-datasmith-content-into/index.md)。在导入过程中，如果需要对数据进行清理、合并或其他修改操作，请参阅[Dataprep导入自定义](../../../dataprep-import-customization/index.md)。

