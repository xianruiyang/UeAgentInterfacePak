# PSA：虚幻引擎 5.7.0 - 灰显的 Cook Content 和 Package Project 按钮需要选定的平台

# PSA：虚幻引擎 5.7.0 - 灰显的 Cook Content 和 Package Project 按钮需要选定的平台

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/jZ85/psa-unreal-engine-5-7-0-greyed-out-cook-content-and-package-project-buttons-require-a-selected-platform

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 773 字符。

## 摘要

请注意，在 UE 5.7.0 中，您必须为虚幻编辑器中的 Cook Content 或 Package Project 操作选择一个平台。

## 中文整理

### 概览

虚幻引擎 5.7.0 对虚幻编辑器菜单进行了更改，用于烹饪内容和打包项目。新的 **平台 > 烹饪内容** 和 **平台 > 打包项目** 菜单要求您先选择一个平台，然后才能执行这些操作。默认情况下，未选择任何平台且按钮呈灰色。单击平台旁边的单选按钮以选择一个。这将启用 **Cook Content ** 和 **Package Project** 操作。要为所有团队成员默认选择一个平台，您可以直接在 DefaultGame.ini 中设置。这是一个已知的可用性问题，将在未来的引擎版本中得到改进。

**默认游戏.ini**

```cpp
[/Script/DeveloperToolSettings.PlatformsMenuSettings]
CookPlatform=Windows
PackagePlatform=Windows
```

![教程图片](assets/psa-unreal-engine-5-7-0-greyed-out-cook-content-and-package-project-buttons-require-a-selected-platform/image-01.jpg)

