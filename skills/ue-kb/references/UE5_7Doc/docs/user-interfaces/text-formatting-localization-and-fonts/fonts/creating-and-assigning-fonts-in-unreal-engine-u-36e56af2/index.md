---
title: "创建并指定字体"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/creating-and-assigning-fonts-in-unreal-engine-user-interface"
breadcrumbs: ["虚幻引擎5.7文档", "创建用户界面", "文本格式设置、本地化和字体", "Fonts", "创建并指定字体"]
---

# 创建并指定字体

> 路径：虚幻引擎5.7文档 / 创建用户界面 / 文本格式设置、本地化和字体 / Fonts / 创建并指定字体

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/creating-and-assigning-fonts-in-unreal-engine-user-interface

在此指南中，您将了解如何创建空白字体资源（可对其指定字体风格资源，或直接使用字体编辑器导入新 TTF 或 OTF 字体文件）。

![Banner Image](../../../../../assets/images/9c/9c3548153594685ba3e0ba2ca32f98e97bac08873ddfdb1223ed4cbe34fb2462.png)

## 步骤

根据以下步骤自建字体资源，然后学习如何使用字体编辑器指定一个字体风格资源。

> [!NOTE]
> 在此指南中，我们使用的是 **Blank Template**，未加入 **Starter Content**、选择默认 **Target Hardware** 和 **Project Settings**。

### 创建字体资源

1. 点击 **Content Browser** 中的 **Add New** 按钮，然后选择 **User Interface** 下的 **Font** 选项。

   ![Create a Font Asset](../../../../../assets/images/2e/2eb0707ad2f644d6ba2e84de5ecac010ecdc0d849046914f3de37928f163d3d8.png)
2. 将新建一个合成字体资源，并弹出提示为其 **命名**。

   ![Name a Font Asset](../../../../../assets/images/9d/9debc7e7a501a4dccbfa344c699d9f3609608e4461e70ec631c051afe8329548.png)
3. 输入命名后，资源上将出现一个星号，说明资源尚未保存。点击 **Save All** 按钮保存资源，然后在弹出的菜单中确认保存。

   ![Click the Save All button to save your asset](../../../../../assets/images/72/72072ae9ac24eb0348f871a3ceb9f18f8303c9c7deaf2e0360ab18c3762d8ef0.png)

### 指定字体风格资源

1. 创建空白字体资源后，便需要指定使用的字体风格。双击字体在字体编辑器中打开执行此操作。

   ![Open created Font Asset in Font Editor Window](../../../../../assets/images/33/337cc9a6659e4ffee76ad8ab469ea248aab2c658da734449adc92f7c2ce2117b.png)
2. 在字体编辑器中点击 **Add Font** 按钮新增一个字体槽。

   ![In the Font Editor add a new Font slot](../../../../../assets/images/c6/c6a0285c4e39482b3be952655c11ebefe3994d564557edf56c01b3b1a29e9c11.png)
3. 在字体编辑器中，为新添的字体插槽命名。

   ![Name added Font slot](../../../../../assets/images/e0/e0988e5a8d5f9f0670b07bd8088f8eb7b5f88c0de6a31acd2c56d3c8382fcdbc.png)
4. 使用字体命名下方的下拉选择选中已导入项目的字体风格资源。

   ![Use the dropdown selection to select an existing Font Face asset](../../../../../assets/images/7a/7a14318422ce6461105dba8f4253fefd44f282f2d18392e316d801a3b85e9a82.png)

   > [!NOTE]
   > 如尚未拥有字体风格资源，可使用下拉选择框旁的文件夹图标寻找并导入您自己的 TrueType Font（TTF）或 OpenType Font（OTF）字体文件。

## 最终结果

现在，你已经掌握了如何自建字体资源，并在字体编辑器中将导入的字体风格资源指定给字体资产。你的字体资产将可以在 UMG UI 设计器中使用。
