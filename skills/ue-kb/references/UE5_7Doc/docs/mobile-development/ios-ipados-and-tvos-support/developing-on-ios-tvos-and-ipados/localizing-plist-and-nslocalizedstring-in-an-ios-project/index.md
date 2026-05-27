---
title: "本地化iOS项目中的plist和NSLocalizedString"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/localizing-plist-and-nslocalizedstring-in-an-ios-project-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "iOS、iPadOS和tvOS", "iOS和tvOS开发指南", "本地化iOS项目中的plist和NSLocalizedString"]
---

# 本地化iOS项目中的plist和NSLocalizedString

> 路径：虚幻引擎5.7文档 / 移动端开发 / iOS、iPadOS和tvOS / iOS和tvOS开发指南 / 本地化iOS项目中的plist和NSLocalizedString

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/localizing-plist-and-nslocalizedstring-in-an-ios-project-in-unreal-engine

你可以在虚幻引擎中添加本地化文件，以便识别和翻译iOS项目中的代码中的字符串。

本文档介绍了如何通过创建本地化文件和文件夹来实现字符串翻译。

> [!NOTE]
> 开发者在提交iOS项目之前，需要添加至少一种语言的本地化文件。

## 步骤

1. 在虚幻引擎项目目录下新建一个本地化文件夹（如果还没有的话），路径：`{UEProjectDir}/Build/IOS/Resources/Localizations/`。
2. 找到 `Localizations` 文件夹，然后为每种语言创建一个文件夹。这些文件夹必须按照以下格式命名：`{LanguageCode}.lproj`。例如，英语本地化文件夹应命名为 `EN.lproj`，其中`EN`是英语的语言代码。

   > [!NOTE]
   > 本地化目录命名时必须使用该语言的双字符码，参见[ISO 639-2标准](http://www.loc.gov/standards/iso639-2/php/code_list.php)。
3. 在每个语言文件夹中，创建一个名为"InfoPlist.strings"的文本文件。这个文件将用于翻译iOS项目"info.plist"文件中的所有字符串。
4. 在每个语言文件夹中，创建一个名为"Localizable.strings"的文本文件。这个文件将翻译iOS项目的所有代码文件中的所有字符串。

例如，对于名为 "Lovely Game" 的应用程序，你的Objective-C代码可以包含以下行：

```
	NSString* allRightText = NSLocalizedString(@"All right", @"All right");	NSString* cancelText = NSLocalizedString(@"Cancel", @"Cancel"); 
```

下表显示了一些如何针对各种语言修改"InfoPlist.strings"文件和"Localizable.strings"文件的示例。

| 语言 | InfoPlist.strings文件代码 | Localizable.strings文件代码 |
| --- | --- | --- |
| 英语 | `"CFBundleDisplayName" = "Lovely Game";` `"NSCameraUsageDescription" = "The camera is needed to take a picture";` | `/* All right */` `"All right" = "All right";` `/* Cancel */` `"Cancel" = "Cancel";` |
| 中文 | `"CFBundleDisplayName" = "可爱的游戏";` `"NSCameraUsageDescription" = "需要摄像头用于拍照";` | `/* OK */` `"OK" = "确定";` `/* Cancel */` `"Cancel" = "取消";` |
| 法语 | `"CFBundleDisplayName" = "Beau Jeu";` `"NSCameraUsageDescription" = "L'appareil photo est nécessaire pour prendre une photo";` | `/* All right */` `"All right" = "D'accord";` `/* Cancel */` `"Cancel" = "Annuler";` |

## 最终结果

虚幻引擎每次打包你的iOS项目时，这个新建的目录都会被打包。

打包后，你的iOS项目应该就已经翻译了所有的字符串，可以随时提交给Apple了。
