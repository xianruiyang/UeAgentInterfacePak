---
title: "创建物理动画配置文件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/creating-a-physical-animation-profile-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "物理", "物理资产编辑器", "物理资产编辑器教程", "创建物理动画配置文件"]
---

# 创建物理动画配置文件

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 物理 / 物理资产编辑器 / 物理资产编辑器教程 / 创建物理动画配置文件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/creating-a-physical-animation-profile-in-unreal-engine

本教程中，我们会讲解创建 **物理动画配置文件（Physical Animation Profile）** 以及向其添加 **物理形体（Physics Bodies）** 的基础知识。

## 步骤

1. 使用 **内容侧滑菜单（Content Drawer）** 为你的 **骨骼网格体** 找到或[创建](../creating-a-new-physics-asset/index.md) **物理资产**。

   ![内容侧滑菜单中的物理资产](../../../../../../assets/images/01/0196c8c445d422dd975b51636fd92f0536faf44f0475a853a4e42fbd42051c62.jpg)

   > [!NOTE]
   > 如果选择新建 **物理资产**，则建立之后方可继续。
2. 双击该物理资产，以打开 **物理资产编辑器（Physics Asset Editor）**。

   ![物理资产编辑器主用户界面](../../../../../../assets/images/e3/e36e2c5c2fbb272d6d6261b4685404eaf1c091d2676bc5f691b2bbf801b5792b.jpg)
3. 在 **Windows** 菜单下，选择 **配置文件（Profiles）**；**配置文件（Profiles）** 窗口应显示为停靠的选项卡。

   ![高亮显示配置文件的Windows菜单](../../../../../../assets/images/28/280172a4e40cd3966e855d481eaa84a758a3bf6f2b96c182d7a9d4c96eac85df.jpg)
4. 使用 **物理动画配置文件（Physical Animation Profiles）** 条目上的 **新增（New）** 按钮添加 **配置文件（Profile）**，并设置名称（下图中命名为 `DocsProfile`）。

   ![添加并命名新的物理动画配置文件](../../../../../../assets/images/df/dff4ebd833bcb2601435c9a7e8b2cfdd66f5bf6a43ddb60e47b73547c19b35de.jpg)
5. 在 **骨架树（Skeleton Tree）** 面板、**物理图表（Physics Graph）** 或 **视口（Viewport）** 中，选择要纳入新 **物理动画配置文件（Physical Animation Profile）** 的 **物理形体（Physics Body）**。

   > [!NOTE]
   > 要在骨架树（Skeleton Tree）面板中查看约束，在 **选项（Options）** 下拉菜单中选择 **显示约束（Show Constraints）**。
6. 按下 **配置文件（Profiles）** 面板中的 **分配（Assign）** 按钮。

   ![将约束分配到配置文件](../../../../../../assets/images/a1/a14f9016a0ea24c5d4484e7e72362eb28d66775abdc8a16e9bc8e38d36badc76.jpg)

   1 - 分配（Assign）按钮 2 - 在骨架树（Skeleton Tree）面板中选定的物理形体 3 - 在物理图表（Physics Graph）面板中选定的物理形体 4 - 在视口（Viewport）中选定的物理形体
7. 调整选定 **物理形体（Physics Bodies）** 的属性。

   ![细节面板中的物理动画属性](../../../../../../assets/images/51/51efe42037f977650067672a24c13fefaebb00ce147d4457dc38542731999123.jpg)

   > [!TIP]
   > 1000、100、1000、100、0、0是比较好的一组起始值
   >
   > ![物理动画推荐默认值](../../../../../../assets/images/20/2027c6d7ce1623e0393ca40dfa3f21bab22eb3d6f8efa9c7d394ae2b7963a478.jpg)
8. 对要添加到 **物理动画配置文件（Physics Animation Profile）** 的所有 **物理形体（Physics Bodies）** 重复步骤5-7。

   > [!TIP]
   > 可以同时选择、分配和编辑多个物理形体的属性。想要让属性不同，单独编辑即可。
9. 使用 **物理资产编辑器（Physics Asset Editor）** 中的 **保存（Save）** 按钮保存 **物理资产（Physics Asset）**。

   ![使用物理资产编辑器中的保存按钮保存物理资产](../../../../../../assets/images/81/816a0c36837c1b5ccd7e0c285f1998c0fcd29691911dc9b272df3ddb9e638197.png)

> [!NOTE]
> 要编辑现有的物理动画配置文件，在下拉菜单中选中，然后使用 **分配（Assign）** 添加新的物理形体，或使用 **取消分配（Unassign）** 移除现有物理形体。

## 结果

现在 **物理资产（Physics Asset）** 有了配置文件，可以从蓝图或C++调用，以更改 **物理形体（Physics Bodies）** 的 **物理动画（Physical Animation）** 属性。

## 其他资源
