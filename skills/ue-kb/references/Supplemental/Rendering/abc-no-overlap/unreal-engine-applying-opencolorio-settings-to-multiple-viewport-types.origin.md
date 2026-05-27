# 将 OpenColorIO 设置应用于多种视口类型

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/Jdpl/unreal-engine-applying-opencolorio-settings-to-multiple-viewport-types
- 原始文件：unreal-engine-applying-opencolorio-settings-to-multiple-viewport-types.origin.md
- 分段：第 1/2 段

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/Jdpl/unreal-engine-applying-opencolorio-settings-to-multiple-viewport-types

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 3588 字符。

## 摘要

有时，您可能希望将 OpenColorIO 配置不仅仅应用于默认的 Unreal 视口。本教程将引导您完成步骤...

## 中文整理

### 概览

To understand this tutorial, you will need to have some background in Color Management with OpenColorIO. You can get existing ACES OpenColorIO configuration files from GitHub: OpenColorIO - Configs The OpenColorIO (OCIO) plugin for Unreal exposes a "OCIO Display Option" inside of the main Unreal viewport. This option will allow you to apply a custom OCIO Config to the Level or Cinematic viewer. But, what if you want to apply OCIO settings to other viewport types other than the Level or Cinematic Viewport such as PIE, SIE and Game mode? Here are the steps: - Create an OpenColorIO Config UAsset

(see the Color Management with OpenColorIO link above for details). Create an OpenColorIO Config UAsset (see the Color Management with OpenColorIO link above for details). - In your Level Blueprint, off of the "Event BeginPlay" event, drag off a connection from the execute pin and create a "Create
OpenColorIO Display Extension" node. In your Level Blueprint, off of the "Event BeginPlay" event, drag off a connection from the execute pin and create a "Create OpenColorIO Display Extension" node. - Drag a connection off of the "Is Active Function" input - search for "Generate Scene View Extension Is Active Functor for Viewport Type" node. Drag a connection off of the "Is Active Function" input - search for "Generate Scene View Extension Is Active Functor for Viewport Type" node. - Enable any of the viewport types you want to apply the OCIO color settings to by enabling the checkbox next to

each one. Enable any of the viewport types you want to apply the OCIO color settings to by enabling the checkbox next to each one. - Drag a connection off of the "In Display Configuration" input - select "Promote to variable". Name the new variable something like "OCIOconfig". Drag a connection off
of the "In Display Configuration" input - select "Promote to variable". Name the new variable something like "OCIOconfig". - Make it Instance Editable. Make it Instance Editable. - Add your OpenColorIO Config UAsset to the Configuration Source, and set your Source and Destination color spaces. Be sure to enable it as well ( You may need to compile to see these parameters ). Add your OpenColorIO Config UAsset to the Configuration Source, and set your Source and Destination color spaces. Be sure to enable it as well ( You may need to compile to see these parameters ). - Drag a connection off of
