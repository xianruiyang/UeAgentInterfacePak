---
title: "创建物理约束配置文件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/creating-a-physics-constraint-profile-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "物理", "物理资产编辑器", "物理资产编辑器教程", "创建物理约束配置文件"]
---

# 创建物理约束配置文件

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 物理 / 物理资产编辑器 / 物理资产编辑器教程 / 创建物理约束配置文件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/creating-a-physics-constraint-profile-in-unreal-engine

本教程中，我们会讲解创建 **约束配置文件** 以及向其添加 **物理约束** 的基础知识。

## 步骤

1. 使用 **内容浏览器** 为你的 **骨骼网格体** 找到或[创建](../creating-a-new-physics-asset/index.md) **物理资产**。

   ![Physics Asset in the Content Drawer](../../../../../../assets/images/e1/e16340677445701baa8034c29ea23d279a74cff04b7c8782b6b8585b43870462.jpg)

   > [!NOTE]
   > 如果选择新建 **物理资产**，则建立之后方可继续。
2. 双击该物理资产，以打开 **物理资产编辑器（Physics Asset Editor）**。

   ![The Physics Asset Editor main user interface](../../../../../../assets/images/52/522d6c1fd2ed9ef51e233d192d1428d202df0c4410d8c198c2b841b1172b22d2.jpg)
3. 在 **Windows** 菜单下，选择 **配置文件（Profiles）**；**配置文件（Profiles）** 窗口应显示为停靠的选项卡。

   ![Windows menu with Profiles highlighted](../../../../../../assets/images/dd/dd389c582df80738f96fdd8cbbd50d2d91945cb611649ae41e1445ceea64ef0c.jpg)
4. 使用 **约束配置文件（Constraints Profiles）** 部分上的 **新增（New）** 按钮添加 **配置文件（Profile）**，并设置名称（下图中命名为 `DocsConstraintProfile`）。

   ![Adding and naming a new Constraints Profile](../../../../../../assets/images/af/af317cb78e938127216177913ad787c6d81c6d3b8edc502f5f61a72c11187f7c.png)
5. 在 **骨架树（Skeleton Tree）** 面板、**物理图表（Physics Graph）** 或 **视口（Viewport）** 中选择要包括在新的 **约束配置文件（Constraint Profile）** 中的 **物理约束（Physics Constraint）**。

   > [!NOTE]
   > 要在骨架树（Skeleton Tree）面板中查看约束，在 **选项（Options）** 下拉菜单中选择 **显示约束（Show Constraints）**。
6. 按下 **配置文件（Profiles）** 面板中的 **分配（Assign）** 按钮。

   ![Assigning Constraints to a Profile](../../../../../../assets/images/6a/6a43e5272b84a2b3ff6dd5b6e654ec62589995dacf2372562c55f3106f8dfb45.jpg)

   1 - 分配（Assign）按钮 2 - 在骨架树（Skeleton Tree）面板中选定的约束 3 - 在物理图表（Physics Graph）面板中选定的约束 4 - 在视口（Viewport）中选定的约束
7. 调整选定 **物理约束（Physics Constraints）** 的属性。

   ![Adjusting Physical Constraint Properties](../../../../../../assets/images/0b/0bec6c63c1b221c8f6eaca46142ee53c31014d776af5b1b4253343d08f4d2aaf.jpg)
8. 对要添加到 **约束配置文件（Constraint Profile）** 的所有 **物理约束（Physics Constraints）** 重复步骤5-7。

   > [!TIP]
   > 可以同时选择、分配和编辑多个约束的属性。想要让属性不同，单独编辑即可。
9. 使用 **物理资产编辑器（Physics Asset Editor）** 中的 **保存（Save）** 按钮保存 **物理资产（Physics Asset）**。

   ![Save your Physics Asset using the Save button in the Physics Asset Editor](../../../../../../assets/images/81/816a0c36837c1b5ccd7e0c285f1998c0fcd29691911dc9b272df3ddb9e638197.png)

> [!NOTE]
> 要编辑现有的约束配置文件，在下拉菜单中选中，然后使用 **分配（Assign）** 添加新的约束，或使用 **取消分配（Unassign）** 移除现有约束。

## 结果

现在 **物理资产（Physics Asset）** 有了配置文件，可以从蓝图或C++调用，以更改 **物理约束（Physical Constraint）** 属性。

## 其他资源
