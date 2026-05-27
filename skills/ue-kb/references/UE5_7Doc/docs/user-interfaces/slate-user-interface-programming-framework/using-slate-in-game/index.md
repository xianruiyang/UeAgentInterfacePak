---
title: "在游戏中使用Slate"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-slate-in-game-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建用户界面", "Slate UI框架", "在游戏中使用Slate"]
---

# 在游戏中使用Slate

> 路径：虚幻引擎5.7文档 / 创建用户界面 / Slate UI框架 / 在游戏中使用Slate

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-slate-in-game-in-unreal-engine

你可以使用 **Slate控件** 来创建抬头显示信息(HUD)或其他用户界面(UI)元素， 比如菜单。这些UI通常包含一个或多个容器控件，每个容器又可以包含其他控件，而这些控件负责渲染用户界面的不同效果。

比如，你可能具有一个针对游戏HUD的总体控件，同时具有针对主菜单、选项菜单、暂停菜单、记分板等的各种控件。每种控件又可能由其他自定义控件、标签、文本框、图片及其他类型的元素构成。

然后，你可以根据游戏情况，动态地将容器控件添加到 **视口** 中或删除它们：

- 当游戏启动时，在视口中添加主菜单控件。
- 当他们选择菜单中的其中一个选项时，主菜单控件会从视口中删除。

  - 如果是打开另一菜单，则菜单会添加到视口中。
- 如果玩家在任何时候暂停了游戏，则会在视口中添加暂停菜单控件。
- 当游戏继续时，视口中将会删除暂停菜单控件。
- 当为玩家初始化了HUD时，视口中将会添加HUD控件。

## 项目设置

为了使用Slate用户界面（UI）框架，你必须正确设置项目，以便它能识别出 框架。你可以添加Slate.h头文件并引用框架中的各种元素 从而使用Slate构建UI。

## 模块依赖项

Slate框架保存在若干个模块中。为了让项目使用它们， 你必须在 *.build.cs 文件中为你的项目设置一些依赖项。

以下是你的项目需要访问的模块：

| 模块 | 依赖项类型 |
| --- | --- |
| InputCore | 公有 |
| Slate | 私有 |
| SlateCore | 私有 |

**设置Slate模块的依赖项：**

1. 打开你的项目的[项目名称].build.cs 文件。它位于[项目目录]/[项目名称]/Source/[项目名称]目录中。
2. 将 `"InputCore"` 添加到 `PublicDependencyModuleNames` 中，以便添加InputCore公有依赖项。

   ```
        PublicDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine", "InputCore" });		
   ```

   > [!NOTE]
   > 代码类项目被创建时，InputCore模块会被默认设置为公有依赖项。
3. 添加Slate和SlateCore私有依赖项。在 *.build.cs 文件中有一行代码，可用于添加私有依赖项：

   ```
        PrivateDependencyModuleNames.AddRange(new string[] {  });		
   ```

   将SlateCore和Slate模块添加到该行中：

   ```
        PrivateDependencyModuleNames.AddRange(new string[] { "Slate", "SlateCore" }); 
   ```

   > [!TIP]
   > 根据你创建项目的时机，以及你所使用的引擎版本，Slate依赖项可能已经 在 *.build.cs 文件中设置好了，只是被注释掉了。你可以取消注释对应的代码， 以便设置依赖项。
   >
   > ```
   >      // 若使用Slate UI则取消注释     // PrivateDependencyModuleNames.AddRange(new string[] { "Slate", "SlateCore" });
   > ```

## 显示控件

为了在你的游戏中显示一个Slate控件，则必须将该控件添加到游戏视口中。重叠的控件按照添加它们时指定的Z-排序进行排序，且较大的Z-排序值出现在较小的Z-排序值的上面。

### 访问游戏视口

游戏视口是 `GameViewportClient` 类的一个实例。到当前游戏视口的引用可以通过UEngine 的 `GameViewport` 成员获得，该成员可以通过使用到游戏当前UEngine实例的`GEngine` 指针访问。

比如：

```
	GEngine->GameViewport 
```

> [!NOTE]
> 因为 `GEngine` 和 `GameViewport` 都可以为 `NULL` ，所以在你尝试访问它们或者 其任何成员时，总是应该判断它们的值。

### 向视口中添加控件

Slate控件通过向 `GameViewportClient::AddViewportWidgetContent()` 传入一个到该控件的引用(确切地说是 `TSharedref<SWidget>` ) 来添加到视口中。该函数取入一个控件和Z-排序，Z-排序 向前面所提到的那样决定了新控件的排列顺序。Z-排序是可选的，但是其默认值为 `0` 。

到你想添加到视口中的控件的引用可以存储为某个类的一个成员，比如你的HUD，或者可以在调用该函数时创建及传入该控件。

传入一个存储在成员变量中的控件引用(作为 `TSharedPtr` )：

```
	GEngine->GameViewport->AddViewportWidgetContent(		SNew(MyWidgetPtr.ToSharedRef())	); 
```

当将控件传入到 `GameViewportClient::AddViewportWidgetContent()` 时使用 `SNew()` 创建该控件：

```
	GEngine->GameViewport->AddViewportWidgetContent(		SNew(SWeakWidget)		.PossiblyNullContent(MyWidgetClass)	); 
```

或者使用 `SAssignNew()` 来创建控件，并将它分配给 `TSharedPtr` 成员，然后传入它：

```
	GEngine->GameViewport->AddViewportWidgetContent(		SAssignNew(MyWidgetPtr, SWeakWidget)		.PossiblyNullContent(MyWidgetClass)	); 
```

### 从视口中删除控件

你可以通过向 `GameViewportClient::RemoveViewportWidgetContent()` 中传入到先前添加的控件的引用， 从视口中单独地删除Slate控件。

比如：

```
	GEngine->GameViewport->RemoveViewportWidgetContent(		SNew(MyWidgetPtr.ToSharedRef())	); 
```

另外，你可以通过调用 `GameViewportClient::RemoveAllViewportWidgets()` 可以立即删除所有控件。

比如：

```
	GEngine->GameViewport->RemoveAllViewportWidgets(); 
```

> [!NOTE]
> 因为 `GEngine` 和 `GameViewport` 都可以为 `NULL` ，所以在你尝试访问它们或者 其任何成员时，总是应该判断它们的值。
