---
title: "内容烘焙"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/cooking-content-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "游戏的打包（Packaging）和烘焙（Cooking）", "内容烘焙"]
---

# 内容烘焙

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / 游戏的打包（Packaging）和烘焙（Cooking） / 内容烘焙

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/cooking-content-in-unreal-engine

虚幻引擎以内部使用的特定格式存储内容资源，如PNG用于存储纹理数据，WAV用于音频数据。但是，该内容需要针对各平台转换为不同的格式，因为平台使用专有格式，或者平台不支持虚幻用来存储资源的格式，又或者存在更节省内存或性能更好的格式。将内容从内部格式转换为特定于平台的格式的过程称为 **烘焙**。

## 从命令行烘焙内容

要为游戏烘焙数据，需要使用Cook commandlet。

基本烘焙通过以下命令执行：

```
	UnrealEditor.exe <GameName or uproject> -run=cook -targetplatform=<Plat1>+<Plat2> [-cookonthefly] [-map=<Map1>+<Map2>]
```

Or

```
	UnrealEditor-Cmd.exe <GameName> -run=cook -targetplatform=<Plat1>+<Plat2> [-cookonthefly] [-map=<Map1>+<Map2>] 
```

该commandlet必须通过`-run=cook`指定，还必须指定要烘焙的平台。该命令会为指定的平台生成数据，并将数据保存在以下位置：

```
	<Game>/Saved/Sandboxes/Cooked-<Platform>
```

## 选项

| 选项 | 说明 |
| --- | --- |
| `-targetplatform=<Plat1>+<Plat2>` | 指定要烘焙的平台。可用平台列表包含WindowsNoEditor、WindowsServer、LinuxServer、IOS和Android。 |
| `-iterate` | 指定烘焙器仅烘焙过时项目。如果不指定该选项，则沙箱目录将被删除，所有内容将重新烘焙。 |
| `-Map=<Map1>+<Map2>+...` | 指定要构建的地图。 |
| `-cookonthefly` | 指定以服务器模式启动烘焙器。这样将启动服务器，服务器将等待游戏连接，然后根据需要提供烘焙的数据。使用该选项时，游戏需要在其命令行上指定`-filehostip=<Server IP>`以便能够连接服务器。 |
| `-MapIniSection=<ini file section>` | 指定ini文件中包含地图名称的分段。烘焙器将烘焙指定分段中指定的所有地图。 |
| `-UnVersioned` | 保存所有烘焙的数据包，不含版本。然后这些数据包在加载时会被假定为最新版本。 |
| `-cookall` | 烘焙所有内容。 |
| `-Compressed` | 告知烘焙器压缩烘焙过的数据包。 |
| `-MAPSONLY` | 只烘焙地图。 |
| `-NODEV` | 排除开发内容。 |
| `-NoGameAlwaysCook` | 不在烘焙中包含特定于游戏的数据包。除非你对此作非常确定，否则这样的烘焙可能会缺失内容。 |
| `-NoDefaultMaps` | 不在烘焙中包含默认地图。除非你对此作非常确定，否则这样的烘焙可能会缺失内容。 |
| `-CookSkipRequests` | 不在烘焙中包含引擎启动时加载的数据包。除非你对此作非常确定，否则这样的烘焙可能会缺失内容。 |
| `-SkipSoftReferences` | 不在烘焙时遵循软引用。这对正式的烘焙通常不可行，而且结果可能无法正确加载。但这对调试可能很有用。 |
| `-SkipHardReferences` | 不在烘焙时遵循硬引用。这对正式的烘焙通常不可行，但对调试可能很有用。 |
| `-CookAgainstFixedBase` | 在烘焙DLC时，假定基础内容无法修改。 |
| `-DlcLoadMainAssetRegistry` | 在烘焙DLC时，填充主游戏资产注册表。 |
| `-DlcReevaluateUncookedAssets` | 在烘焙DLC时，忽略基础资产注册表中未烘焙的资产，使此烘焙有机会烘焙该资产。 |
| `-RunAssetValidation` | 在烘焙过程中加载的资产上运行资产验证（`EditorValidatorSubsystem`）。 |
| `-RunMapValidation` | 在烘焙过程中加载的地图上运行地图验证（`MapCheck`）。 |
| `-ValidationErrorsAreFatal` | 将验证错误（来自 `EditorValidatorSubsystem` 或 `MapCheck`）视为致命错误，从而阻止该数据包被烘焙。 |
| `-EDITOROPTIONAL` | 在烘焙时生成编辑器可选的数据包。 |
| `-MANIFESTS` | 为编译流送安装数据包生成清单文件。 |
| `-SKIPEDITORCONTENT` | 不在Engine/Content/Editor下保存任何数据包。 |
| `-ERRORONENGINECONTENTUSE` | 在烘焙访问引擎内容时生成错误信息（这对DLC很有用）。 |
| `-cooksinglepackagenorefs` | 只烘焙命令行选项指定的数据包（用于调试）。 |
| `-cooksinglepackage` | 对 `bCookSinglePackage` 进行的一项修改——除命令行中的数据包之外，还要烘焙具有传递性的硬引用。 |
| `-verbosecookerwarnings` | 输出更详细的烘焙警告。 |
| `-Partialgc` | 只清理烘焙器在GC期间不使用的对象（如为false，则启用全完整GC）。 |
| `-IgnoreIniSettingsOutOfDate` | 忽略过期的Ini设置。 |
