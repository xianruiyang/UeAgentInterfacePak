# 使用Dynamo批量导出Revit视图

---
title: "使用Dynamo批量导出Revit视图"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/batch-exporting-revit-views-with-dynamo-to-a-datasmith-scene"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Datasmith", "Datasmith软件交互指南", "Revit", "使用Dynamo批量导出Revit视图"]
---

# 使用Dynamo批量导出Revit视图

> 路径：虚幻引擎5.7文档 / 管理内容 / Datasmith / Datasmith软件交互指南 / Revit / 使用Dynamo批量导出Revit视图

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/batch-exporting-revit-views-with-dynamo-to-a-datasmith-scene

与 **虚幻引擎** 的蓝图脚本系统类似，Dynamo for Revit是一种可视化的编程语言，可以访问Revit API，并用于轻松地自动执行许多重复性任务。除了从加载项工具栏访问外，Datasmith的Autodesk Revit导出器还使用Dynamo来将Revit 3D视图自动导出为 `.udatasmith` 文件，以便在虚幻引擎中使用。

## 安装插件

首先请下载并安装Epic Games提供的[Datasmith的Autodesk Revit导出器](https://www.unrealengine.com/en-US/datasmith/plugins)插件。这会更新已安装的插件版本，并为Dynamo视觉效果脚本语言添加一些其他钩子（hook）。

> [!WARNING]
> 该插件要求你的Dynamo版本为2.0或更高版本。点击Dynamo UI中的 **帮助（Help）** 菜单，并选择 **关于（About）** 选项可查看版本。

安装插件后，启动Dynamo界面：

![undefined](../../../../../../assets/images/f9/f98ac0359becf6d317f77520264915c5230a023b445d4f0e3814cf0d0dfed5c8.jpg)

接下来，你需要导入DatasmithDynamoNode.dll文件。在Dynamo UI中，点击 文件（File） 菜单，然后选择 导入库（Import Library） 选项。你将在以下位置之一找到该库：

| **Revit版本** | **位置** |
| --- | --- |
| **2018.3** | C:\\ProgramData\\Autodesk\\Revit\\Addins\\2018\\DatasmithRevit2018\\DatasmithDynamoNode.dll |
| **2019** | C:\\ProgramData\\Autodesk\\Revit\\Addins\\2019\\DatasmithRevit2019\\DatasmithDynamoNode.dll |
| **2020** | C:\\ProgramData\\Autodesk\\Revit\\Addins\\2020\\DatasmithRevit2020\\DatasmithDynamoNode.dll |

> [!NOTE]
> 要确认该库是否安装成功，你可以在Dynamo库的加载项分段中查看是否有 **DatasmithDynamoNode** 条目。

## 工作原理

导入库将安装Datasmith Dynamo节点，该节点旨在从Revit文档中获取数据，并以特定的曲面细分级别导出请求视图：

![undefined](../../../../../../assets/images/18/183627b2064e22a5074800ebd8f4bd614e2057b8ee53553e3230eb3db57ad788.jpg)

| **数量** | **说明** |
| --- | --- |
| **1** | 当前Revit文档 |
| **2** | 输出路径 |
| **3** | 基于ID的视图列表 |
| **4** | 曲面细分等级（整数值1-15，默认值8） |

将当前的Revit文件用作文档，该节点将在3D视图中输出 `.udatasmith` 文件和对象文件夹，作为准备供Datasmith使用的 `.udsmesh` 文件。

为了演示Datasmith Dynamo节点的用法，该插件包含一个Dynamo示例脚本文件，该文件显示了如何使用该节点创建批处理导出器：

![undefined](../../../../../../assets/images/22/22678175ca1645da102dd22b12ca9d7d517d4ffeb8b0a50b8814e52dd529e937.jpg)

该脚本执行以下步骤：

1. 该脚本使用Get 3D Views节点，查找当前Revit文档中的所有3D视图，并将它们添加到列表中。
2. 然后它会过滤列表，查找添加到视图名称的前缀（使用Prefix_ViewName格式）或提供特定名称的视图。在该示例中，前缀默认设置为Datasmith，而实例参数名称默认设置为DatasmithExport。
3. 接下来，脚本会查看两个布尔值，以便确定你要导出所有视图，还是仅导出在筛选列表中找到的视图。
4. 最后，将选定的视图导出到选定的文件夹，其中包含由网格体曲面细分数量定义的详细信息。

> [!NOTE]
> 为了避免依赖Dynamo API，此版本的批处理导出器需要使用python节点获取有关当前文档的信息：
>
> ![undefined](../../../../../../assets/images/b8/b88d7b16615077a5729ad0f1768cccba0087464acaa78edd9e4c4c0a4e3f16e8.jpg)
>
> 同样，获取3D视图并提取给定视图的ElementID依赖于python节点：
>
> ![undefined](../../../../../../assets/images/ae/ae8eb6c652896b71f6d06bdfa1100aa5b98b5846263add6455475596703566f0.jpg)

## 使用批量导出器

所提供的Dynamo示例可以执行并用作基本的批处理导出器：

![undefined](../../../../../../assets/images/8c/8cfc043b33be63199e795f189a00901ea7084e6f88896e98d49329186c27d7d6.jpg)

| **属性** | **说明** |
| --- | --- |
| **导出至（Export To）：** | 允许你浏览文件夹并指定你想要放置Datasmith文件的位置。 |
| **网格体曲面细分量（Mesh Tessellation Amount）：** | 指定由Revit API定义的导出过程中使用的曲面细分等级。默认为等级8。这将产生与Revit FBX导出器相同的网格体分辨率。 曲面细分等级8 曲面细分等级2 |
| **导出所有3D视图（Export All 3D Views）：** | 如果启用，这将导出当前Revit文档中找到的每个3D视图。如果关闭，这将在当前Revit文档中找到使用自定义名称或前缀的3D视图，并为Datasmith导出这些视图。 |
| **按视图名称前缀/按视图实例参数（By View Name Prefix / By View Instance Parameter）：** | 仅导出与指定给视图实例的前缀名称或项目参数匹配的视图。 如果为TRUE：按参数过滤。 如果为FALSE：按视图名称前缀过滤。 |
| **查看实例参数名称（View Instance Parameter Name）：** | 定义将要导出的视图名称。 |
| **导出3D视图前缀（Export 3D Views Prefixed With）：** | 定义将要导出的视图名称前缀。 |

