# 将Lyra初学者游戏包升级到最新引擎版本

---
title: "将Lyra初学者游戏包升级到最新引擎版本"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/upgrading-the-lyra-starter-game-to-the-latest-engine-release-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "示例与教学", "游戏示例项目", "Lyra示例游戏", "将Lyra初学者游戏包升级到最新引擎版本"]
---

# 将Lyra初学者游戏包升级到最新引擎版本

> 路径：虚幻引擎5.7文档 / 示例与教学 / 游戏示例项目 / Lyra示例游戏 / 将Lyra初学者游戏包升级到最新引擎版本

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/upgrading-the-lyra-starter-game-to-the-latest-engine-release-in-unreal-engine

我们会随 **虚幻引擎（UE）** 的每个主要版本更新 **Lyra初学者游戏** 。这些更新利用了引擎的最新功能，并修复了Lyra特有的问题。本页面记录了每个引擎版本对Lyra做出的重大改动，包含可以帮助你将现有游戏升级到最新版本虚幻引擎的信息。

## 升级到最新引擎版本

包含C++代码的游戏（包括Lyra）需要手动更新才能正常兼容虚幻引擎新发布的主要版本。例如，从5.0.x到5.1.x的重大引擎升级可能会废弃较旧的功能或设置，并且可能会改动你的项目使用的现有函数和变量。因此，一些游戏特有代码和数据需要更新，以使在升级后能够正常工作。 以Lyra为例，请按照以下步骤更新游戏：

1. 阅读新引擎版本的 **版本说明**，以确保你关注可能影响游戏的任何重大更改和升级说明。
2. 下载并[安装新的引擎版本]](understanding-the-basics/installing-unreal-engine)。你可能需要将此版本安装到与当前引擎版本不同的目录中，以便比较新旧版本的游戏。
3. 下载并安装与引擎的新版本匹配的[Lyra初学者游戏包示例(https://www.fab.com/listings/93faede1-4434-47c0-85f1-bf27c0820ad0)，以便你了解更新过程。如果你将其安装到不同的目录，则可以将其与旧版本进行比较。
4. 请参阅[虚幻引擎5迁移指南](../../../../whats-new/unreal-engine-5-migration-guide/index.md)，检查与引擎最新版本的兼容性。
5. 在C++代码编辑器中加载你的项目并尝试编译它。此操作可能会失败。
6. 利用废弃消息中包含的说明修复废弃警告。
7. 对于有关类或结构体无效或缺失的错误，你需要在文件的顶部新增一个 `#include` 行。如果你使用的是Visual Studio，可以找到 **编辑（Edit）** > **查找和替换（Find and Replace）** > **在文件中查找（Find In Files）** ，然后搜索缺少的类型名称。寻找定义该类型的头文件并新增一个 `#include` 。
8. 对于虚拟函数覆盖错误，你需要更新头文件和 `.cpp` 文件中被覆盖函数的参数。
9. 对于类或结构体上的无效变量错误，你将需要使用不同的方法访问该变量。通常调用 `Get()` 或 `GetVariableName()` 等返回实际值的访问器函数即可解决问题。
10. 如果你不确定该如何修复错误，请搜索 **版本说明]**，或访问[社区论坛](https://forums.unrealengine.com/)以获取更多信息。

通过比较新旧版本的Lyra初学者游戏包，你可以了解如何处理对源代码的复杂更改。如果你的游戏包含来自Lyra的代码或内容，以下版本特有信息将有助于你升级游戏。

## 虚幻引擎5.3

在虚幻引擎5.3中，Lyra示例游戏继续获得支持。它现在可以利用添加到引擎中的最新功能和修复。

### 5.3的升级说明：

- 一些对象指针变量已更改为使用 `TObjectPtr` 。
- 多个C++ lambda已更新，修复了有关不安全使用的警告。
- 一些头文件包含已更新，删除了不必要的路径。

### 5.3中的改进：

- Lyra现在包含试验性的客户端重播支持。 在支持的平台上，"保存重播"可以在设置菜单中启用，然后从主菜单回放。保存的重播目前缺少一些视效和音效。 一些平台可能不支持"客户端重播支持"。
- 共享的Gameplay设置现在从新的引擎 `LocalPlayerSaveGame` 类继承，在平台登录成功完成之前不会加载。
- ShooterExplorer游戏功能插件包括一些测试开放世界和AI系统的进行中的试验性内容。
- 特定于Lyra的输入设置已更新，处理了增强输入的改进。

### 5.3中的漏洞修复：

- 修复了Gameplay技能的问题，并自定义了直接放在地图中的NPC角色的角色部分。
- SyncMarker、FootFX和FootstepEffectTag动画修饰符已更新。
- 修复了基于触摸的摇杆在隐藏时会影响输入的漏洞。
- 修复了重播测试期间发现的多个网络漏洞。
- 现在LyraHealthComponent上的生命值更改回调会包含可用的发起者。

## 虚幻引擎5.2

在虚幻引擎5.2中，Lyra示例游戏继续获得支持。它现在可以利用添加到引擎中的最新功能和修复。

### 5.2版升级说明

- 引擎头文件进行了重新整理，以缩短编译时间。这一改进表明Lyra中存在缺少头文件的情况。例如，需要更改 `CommonUserSubsystem.h` 以将 `OnlineError.h` 包括在内
- Lyra的5.1版本为 **Iris** 联网系统提供了可选支持，该系统现已默认编译到引擎内。在5.2版中编译旧版Lyra会导致联网连接器错误，将 `"SetupIrisSupport(Target);"` 添加到 `LyraGame.build.cs` 可以修复错误

### 5.2版中的改进

- `LyraGame` Gameplay标签已改为使用位于 `LyraGameplayTags` 命名空间内的标签。这样就可以在对象初始化期间使用这些标签。
- 比赛结束时（或使用PlayNextGame主机命令作弊时）的地图转移现在使用无缝漫游。
- Lyra现在为本地多玩家提供试验性支持。如需激活本地多玩家，请按下已连接的第二个同类型控制器上的开始按钮，或点击主菜单上的 **添加玩家（Add Player）** 按钮。
- 改进了对专用服务器的支持。使用 `-server` 命令运行的打包LyraServer或编辑器游戏将开始使用 `ALyraGameMode::TryDedicatedServerLogin` 中的代码托管默认地图。
- 添加了对复制图表、Iris和数据包加密的联网支持。此支持默认禁用。
- 更改了触觉反馈以包括输入设备属性，如某些平台上的扳机阻力和控制器颜色。

  - 你的控制器颜色将与你的团队颜色（红色或蓝色）一致。
  - 武器实例在装备后可以添加设备属性。例如，装备霰弹枪后，使用PlayStation DualSense控制器时会有很大的扳机阻力。
- 现在，打包Lyra会创建多个 `.pak` 文件。使用游戏功能插件中的主要资产标签（Primary Asset Labels）可设置此项。

### 5.2版中的漏洞修复

- 在支持无缝漫游和本地多玩家的同时，修复了许多联网和UI问题。
- 修复了角色移动时的动画卡顿问题。这一问题最初在5.1.1版中修复了。
- 修复了LyraClient构建目标存在的几个问题。它现在可以加入专用服务器
- 将构建脚本的默认游戏目标修复为LyraGame。
- 降低了资产具有未知版本控制状态时 `EditorValidator_SourceControl` 警告出现的频率。

## 虚幻引擎5.1

在虚拟仪器5.1中，Lyra示例游戏进行了更新，修复了示例存在的问题，并利用了引擎中添加的最新功能。

### 5.1版升级说明

- 整理了几个引擎头文件以缩短编译时间。这暴露了Lyra源文件存在的一些问题。这些问题可以修复，方法是将 `#pragma once` 行添加到没有该行的头文件，并为存在缺少类型错误的源文件添加 `#include EditorStyle.h` 之类的行。
- 将Gameplay框架类中的几个原始指针属性更改为使用 `TObjectPtr` 或 `TWeakObjectPtr` 。凡是需要原始指针的代码，都可以通过添加对 `Get()` 函数的调用进行修复。
- 从 `GameplayAbility.h` 中移除了 `ENSURE_ABILITY_IS_INSTANTIATED_OR_RETURN` 宏。可将该宏从 `GameplayAbility.cpp` 复制到其他技能源代码文件中。
- 为添加新的参数而修改了几个与游戏功能插件相关的虚拟函数。需要更新 `ULyraGameFeaturePolicy` 等类中的被覆盖函数。
- 几何网格体蓝图 `Tools/BakedGeneratedMeshSystem/BaseClasses/BakedGeneratedMeshActor` 针对5.1版进行了更新。尽管5.0资产仍可正常运行，但只有使用5.1版本才能正确配置Nanite设置。

### 5.1版中的改进

- 为使用新的 `IGameFrameworkInitStateInterface` 和 `GameFrameworkComponentManager` 上的初始状态（Init State）系统，重写了 `ULyraHeroComponent` 和 `ULyraPawnExtensionComponent` 中的Pawn初始化流程。这可以修复网络复制中的几个竞争条件，并且更便于使用新的功能特有组件进行扩展。
- 为具有不同能力的设备添加了Android设备描述，并调整了其他平台设置。
- 添加了用于将常用地图加载到编辑器工具栏的UI。
- 添加了对使用Epic在线服务的多玩家游戏邀请的基本处理。
- 在新的ShooterExplorer和ShooterTest插件中添加了原型和测试内容。
- 改进了键绑定屏幕，在绑定已指定的时键会显示警告屏幕。

### 5.1版中的漏洞修复

- 将

  LyraGame.Target.cs

  中的

  ShouldEnableAllGameFeaturePlugins

  函数改为了返回

  false

  ，表示游戏功能插件现在可以像普通插件一样启用。这可以修复插件，使其在引擎的自定义编译版本和启动程序安装版本中功能相同。
- 修复了运行Lyra会更改用来在其他项目中退出在编辑器中运行（Play In Editor）的键绑定这一问题。
- 更改了技能以正确使用治疗和伤害属性，而不是对生命值应用负修饰符。
- 更新了代码和蓝图以使用新的PlatformUser和InputDeviceId类型，而不是废弃的控制器ID。

## 虚幻引擎5.0

Lyra示例游戏的5.0版本与5.0.2版本一并进行了更新，以修复原始版本中的几个漏洞。该示例的所有后续版本均包括这些修复。

### 5.0.2版中的漏洞修复

- 修复了自动化脚本以处理不同的安装目录。
- 修复了反转鼠标设置。
- 更新了人体模型重定向和Control Rig资产。
- 更新了移动设备描述中的抗锯齿设置。
- 添加了缺少的编辑器图标。

