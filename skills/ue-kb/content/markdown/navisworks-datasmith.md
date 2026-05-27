# 从Navisworks中导出Datasmith内容

---
title: "从Navisworks中导出Datasmith内容"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/exporting-datasmith-content-from-navisworks-to-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Datasmith", "Datasmith软件交互指南", "Navisworks", "从Navisworks中导出Datasmith内容"]
---

# 从Navisworks中导出Datasmith内容

> 路径：虚幻引擎5.7文档 / 管理内容 / Datasmith / Datasmith软件交互指南 / Navisworks / 从Navisworks中导出Datasmith内容

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/exporting-datasmith-content-from-navisworks-to-unreal-engine

## 从功能区菜单导出

安装 **用于Navisworks的Datasmith导出器插件** 后，界面顶部的功能区菜单中将新增一个 **虚幻Datasmith（Unreal Datasmith）** 选项卡：

![添加到功能区菜单的虚幻Datasmith选项卡](../../../../../../assets/images/3c/3c349002766a88fce6085ef64a20e404ca9aab2ff9b8a0ab516a91fa3fa85649.png)

在隐藏了不希望导出的元素后，请按照以下步骤导出场景到（**.udatasmith*）类型的Datasmith文件：

在功能区菜单上点击Datasmith导出（Datasmith Export）按钮，打开导出面板：

![Navisworks中的Datasmith导出器对话框](../../../../../../assets/images/eb/eb9910bb44a32eda495300bb54e6128038c4aa44dcbc793d0bcb8a1a8ed5f7ef.jpg)

| 名称 | 说明 |
| --- | --- |
| 合并（Merge） | 选择待合并元素的对象树级别，以便合并生成静态网格体。要了解更多信息，请参阅[在Navisworks中使用Datasmith](../index.md)。 |
| 原点（Origin） | 指定场景的原点。虚幻引擎中场景的原点为0,0,0。 |

在导出（Export）面板中设置对象合并的级别和原点，然后点击 **导出（Export）** 按钮。

![保存文件](../../../../../../assets/images/84/84381ca245c534d72bc193220fb149a9a2772018b70671a09483c27bca943412.png)

浏览到你希望保存导出文件的位置，设置文件名，然后点击"保存（Save）"。

## 使用Python脚本导出

可使用Python脚本从Navisworks批量导出Datasmith内容。可尝试该示例

```
            import sys            import clr            # 添加Navisworks程序集DLL的位置           sys.path.append(r'C:\Program Files\Autodesk\Navisworks Manage 2022')            # 添加Navisworks程序集           clr.AddReference('Autodesk.Navisworks.Api')           clr.AddReference('Autodesk.Navisworks.Automation')            from Autodesk.Navisworks.Api import *           from Autodesk.Navisworks.Api.Automation import *            navisworks_app = NavisworksApplication()  # Create an app instance            try:               source_fpath = r'C:\Program Files\Autodesk\Navisworks Manage 2022\Samples\snowmobile.nwd'                navisworks_app.OpenFile(source_fpath, [])                print(f'Exporting {source_fpath}...', end='')               if 0 == navisworks_app.ExecuteAddInPlugin('DatasmithNavisworksExporter.EpicGames', [                   r'C:\temp\test.udatasmith',                   'Merge=8',  # merge hierarchies up to depth 8                   'Origin=10, 20.0, 300.0',  # origin location                   'Hello=world',  # invalid option               ]):                   print("DONE")               else:                   print("FAILED")           finally:               navisworks_app.Dispose()  # Exit app               # 也可保持打开状态（例如，如果需要查看应用程序控制台输出以进行调试）               # navisworks_app.StayOpen()  
```

## 最终结果

现在你应该可以试着将 *.udatasmith* 文件导入虚幻引擎了。参阅[将Datasmith内容导入虚幻引擎](../../../datasmith-tutorials/importing-datasmith-content-into/index.md)。在导入过程中，如果需要对数据进行清理、合并或其他修改操作，请参阅[Visual Dataprep](../../../dataprep-import-customization/index.md)。

