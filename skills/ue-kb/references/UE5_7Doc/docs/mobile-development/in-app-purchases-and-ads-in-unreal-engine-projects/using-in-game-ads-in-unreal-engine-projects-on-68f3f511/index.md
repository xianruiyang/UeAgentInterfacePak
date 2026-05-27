---
title: "使用游戏内置广告"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-in-game-ads-in-unreal-engine-projects-on-mobile-platforms"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "应用内购买和广告", "使用游戏内置广告"]
---

# 使用游戏内置广告

> 路径：虚幻引擎5.7文档 / 移动端开发 / 应用内购买和广告 / 使用游戏内置广告

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-in-game-ads-in-unreal-engine-projects-on-mobile-platforms

内置广告可以让你在移动平台上向游戏玩家展示广告。此方式可实现免费游戏的盈利，同时令其保持完全免费。

![Banner Image](../../../../assets/images/35/35a784c31f1cd17f39d48b5f0bb3dc4a7f209160e27357c4a853733bd46f9610.jpg)

## 配置

在下方页面中查看在每个平台上进行游戏内购配置的详细内容：

- 在安卓上使用 Ad Mob 游戏内置广告

## 展示广告横幅

**Show Ad Banner** 函数用于在游戏中显示广告横幅。需要展示广告时（如显示主菜单时）在逻辑中进行调用即可。

**在蓝图中：**

下例取自 Unreal Match 3 示例游戏 - 使用控件蓝图的 **Construct** 事件在胜利/失败画面出现时展示广告横幅。

![Blueprint script for showing ad banner](../../../../assets/images/d4/d471429316135f5755594489528f40f48af5475e881761bc3a8d866970549f66.jpg)

如需了解节点的详细内容，请查阅 [展示广告横幅](https://docs.unrealengine.com/BlueprintAPI/Utilities/Platform/ShowAdBanner) 文档。

## 隐藏广告横幅

**Hide Ad Banner** 函数可隐藏广告横幅。无需显示广告时（如退出主菜单时）进行调用即可。

**在蓝图中：**

下例取自 Unreal Match 3 示例游戏 - 使用控件蓝图的 **Destruct** 事件在胜利/失败画面出现时隐藏广告横幅。

![Blueprint script for hiding ad banner](../../../../assets/images/a4/a47492f7673b702e06b4b8c77e5d17ab6daba261363a3867af592c6c50cc4e42.png)

如需了解节点的详细内容，请查阅 [隐藏广告横幅](https://docs.unrealengine.com/BlueprintAPI/Utilities/Platform/HideAdBanner) 文档。
