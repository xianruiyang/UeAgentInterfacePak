# Flurry分析供应商

---
title: "Flurry分析供应商"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/flurry-analytics-provider-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "游戏运行的性能分析", "Flurry分析供应商"]
---

# Flurry分析供应商

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 游戏运行的性能分析 / Flurry分析供应商

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/flurry-analytics-provider-for-unreal-engine

[Flurry](http://www.flurry.com/) 是广泛使用的免费分析服务。由于使用非常广泛，它可以将你的应用程序数据与相同类别的其他应用程序进行比较。这可让你快速了解游戏的表现以及你可能需要关注的领域。要使用此服务，你必须在服务商的网站注册，获得唯一标识你的应用程序的应用程序密钥，然后下载已编译到Flurry插件的库。请查看该插件相应的 `<PlatformAndName>.Build.cs` 文件，以了解应将库和头文件置于何处。

## 配置

完成先决条件并且成功为目标平台编译插件后，你就可以为游戏配置插件。自4.8版本起，只有一个要设置的配置属性：唯一识别你游戏的密钥。以下代码段展示了一个理论上的Flurry配置。与所有分析服务商一样，配置数据将保存到您的 `DefaultEngine.ini` 文件。

```
	[Analytics]	FlurryApiKey=RANDOM34LETTERS4511
```

