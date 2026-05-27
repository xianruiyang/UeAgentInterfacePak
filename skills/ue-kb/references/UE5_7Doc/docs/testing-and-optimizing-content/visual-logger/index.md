---
title: "可视记录器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/visual-logger-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "可视记录器"]
---

# 可视记录器

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / 可视记录器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/visual-logger-in-unreal-engine

**可视记录器** 是一款强大的调试工具，用于创建和录制游戏进程状态的可视显示，可在编辑器中查看此数据。开发者能够在游戏会话期间实时查看调试输出，或会话结束后在编辑器中进行查看，在面对仅靠用户报告或游戏画面难以追踪的游戏漏洞时，可轻松对其进行修复。处理罕见的或者很难重现的漏洞时，记录信息以供后续检查的功能非常重要。例如，单个帧上的游戏状态变量发生改变可能会引起一次意外的AI行为，但通过记录数据和拖至漏洞发生的帧数便就可在之后研究该意外。

要启动可视记录器，使用 **Windows > 开发者工具（Developer Tools） > 可视记录器** 中的菜单即可。在虚幻引擎4.7之前的版本中，输入控制台命令"VisLog"。如正在使用编辑器，可视记录器视口便会打开。

在Epic Games样本StrategyGame的会话期间使用可视记录器。紫线表明AI路径，红色定位标记显示在时间轴上选中的点。

## 可视记录器视口

在编辑器中，利用可视记录器视口能够在预先录制的会话中检查可视记录器输出，以便开发者在后续检查漏洞。

编辑器中的可视记录器视口。

视口包含记录可视化数据的所有Actor的列表、在Actor列表中所选Actor的状态详细快照、显示调试信息输出的文本窗口和用于拖动录制数据的时间条。

### Actor列表

下列图像中高亮的区域显示录制会话时已在可视记录器中记录信息的Actor列表。同时用户还可使用搜索栏，快速找到指定Actor的日志信息。

Actor列表及其搜索栏。

### Actor快照视图

Actor用"UE_VLOG"宏收集的信息都将显示在下列图像的高亮区域。可视记录器将显示时间轴拖动条表明的时间处，Actor 列表中选中的Actor数据。可视记录器采集的数据作为快照的一部分，可在游戏代码中分类和自定义，还可展开或折叠此类条目。

> [!NOTE]
> 在同一帧和同一Actor处，多次调用可视化记录会覆盖之前采集的数据。

已展开自定义条目的Actor快照区域。

### 文本窗口

可视记录器的文本窗口将分条目显示来自当前帧的日志消息。在相同条目和相同帧处记录的多条日志消息将以列表显示。

显示调试信息的文本窗口区域，。

### 时间轴

时间轴视图包含滚动条，可将记录器前进（或倒回）至任意时间点。在下方图片中，拖动条位于23.53秒标记处，并选中了Actor列表的"StrategyAIController_1"。拖动时间条，便可在录制的的日志数据中查看不同时间点上的所选Actor的状态和文本窗口。

时间轴区域。

### 添加可视记录器支持

可添加到可视记录器中的数据共有三种类型：

| 数据类型 | 输出描述 |
| --- | --- |
| Actor快照 | 此类型将显示在Actor快照区域，存在Actor时会逐帧更新。 |
| 日志消息 | 可视记录器记录的文本都将显示在文本窗口中。文本以单针形式显示。 |
| 调试形状 | 可在游戏场景中绘制各种形状。此类形状可持续多帧，且拥有如尺寸和颜色等诸多可调节参数。 |

### 截取Actor快照

要向Actor快照视图添加数据，你必须按如下方法实现`IVisualLoggerDebugSnapshotInterface`接口：

```
	class MYPROJECT_API AMyActor : public AActor, public IVisualLoggerDebugSnapshotInterface 
```

该接口只包含一个`GrabDebugSnapshot`函数，它默认没有任何作用。你可以重载这个函数，以便将信息传入可视记录器。由于`GrabDebugSnapshot`应该只在启用了可视记录功能的编译版本中执行，所以最好检查相关代码的周围是否添加了`ENABLE_VISUAL_LOG`宏。例如，Actor类中的函数声明应该这样写：

```
	#if ENABLE_VISUAL_LOG		//~ 开始IVisualLoggerDebugSnapshotInterface接口		// 将此Actor的信息添加到可视记录器中。		virtual void GrabDebugSnapshot(FVisualLogEntry* Snapshot) const override;		//~ 结束IVisualLoggerDebugSnapshotInterface接口	#endif 
```

下列样本代码属于GDC演示的一部分，其将可视日志添加到名为 `AGDCCharacter` 的第一人称射击游戏模板的自定义版角色类。此代码在"GDC示例"条目下添加单个条目。该条目被标记为"发射物类"，并包括了发射时角色生成的发射物类型。

```
	#if ENABLE_VISUAL_LOG	void AGDCCharacter::GrabDebugSnapshot(FVisualLogEntry* Snapshot) const	{		Super::GrabDebugSnapshot(Snapshot);		const int32 CatIndex = Snapshot->Status.AddZeroed();		FVisualLogStatusCategory& PlaceableCategory = Snapshot->Status[CatIndex];		PlaceableCategory.Category = TEXT("GDC Sample");		PlaceableCategory.Add(TEXT("Projectile Class"), ProjectileClass != nullptr ?ProjectileClass->GetName() :TEXT("None"));	}	#endif 
```

> [!NOTE]
> 该函数将在首次调用可视记录器时自动运行。将要在Actor快照视图中显示的信息添加到该函数。

带有 AGDCCharacter Actor快照的可视记录器。

### 日志记录文本

可使用 `UE_VLOG` 宏在文本窗口中记录。文本窗口将显示逐帧信息，因此在录制数据中拖动时，只会显示当前帧记录的文本。文本可在任何地方进行记录，而在不支持可视记录系统的版本中编译时，会自动清除 `UE_VLOG` 宏。因此无需勾选 `ENABLE_VISUAL_LOG` 宏，便可安全使用。宏会获取表明文本、日志条目和冗余度相关Actor的参数（用于过滤显示）以及文本自身。

在下列样本代码中，发射发射物后自定义角色使用 `UE_VLOG` 记录信息：

void AGDCCharacter::OnFire() { // 试图发射发射物 if (ProjectileClass != NULL) { // 收集目标旋转。 const FRotator SpawnRotation = GetControlRotation(); // MuzzleOffset位于相机空间中，因此在从角色位置偏移前需将其变换到场景空间，以便找到最终枪口位置。 const FVector SpawnLocation = GetActorLocation() + SpawnRotation.RotateVector(GunOffset); UWorld*const World = GetWorld(); if (World != NULL) { // 从枪口位置将发射物发射到场景。 World->SpawnActor(ProjectileClass, SpawnLocation, SpawnRotation); // 用可视记录器记录该事件。 UE_VLOG(this, LogFPChar, Verbose, TEXT("Fired projectile (%s) from location (%s) with rotation (%s)"),*ProjectileClass->GetName(), *SpawnLocation.ToString(),*SpawnRotation.ToString()); } } // ... }

可视记录器显示来自 AGDCCharacter 的调试文本。

> [!NOTE]
> 若要向标准日志发送重复信息，可使用 `UE_VLOG_UELOG` 宏，而非使用相同数据先后调用 `UE_VLOG_UELOG` 和 `UE_LOG`。

### 绘制调试形状

在游戏场景记录形状信息是一项强大功能，其能可视化正在发生事件。下列图像显示了可视记录器支持的部分不同形状类型。

路径信息、圆柱体、椎体、胶囊体和盒体。

以下宏支持记录形状。每个宏需要拥有形状的Actor、日志类别和冗余度、几个定义形状的额外参数（根据形状而定）以及形状的附加文本。以下表格显示可用形状和每个形状所需额外参数的信息。

| 形状 | 描述 | 附加参数 |
| --- | --- | --- |
| `UE_VLOG_SEGMENT` | 一像素厚的线条段。 | `FVector` 开始点 `FVector` 结束点 `FColor` 颜色 |
| `UE_VLOG_SEGMENT_THICK` | 厚度可变的线条段。 | `FVector` 开始点 `FVector` 结束点 `FColor` 颜色 `float` 厚度 |
| `UE_VLOG_LOCATION` | 球体。 | `FVector` 位置 `float` 半径 `FColor` 颜色 |
| `UE_VLOG_BOX` | 轴对齐的盒体。 | `FVector` 中心位置 `FColor` 颜色 |
| `UE_VLOG_OBOX` | 旋转的盒体。 | `FVector` 中心位置 `Fmatrix` 盒体旋转 `FColor` 颜色 |
| `UE_VLOG_CONE` | 椎体。 | `Fvector` 开始点 `FVector` 椎体方向 `float` 椎体长度 `Float` 椎体角度（以度计） `FColor` 颜色 |
| `UE_VLOG_CYLINDER` | 圆柱体。 | `FVector` 开始点 `FVector` 结束点 `Float` 圆柱体半径 `FColor` 颜色 |
| `UE_VLOG_CAPSULE` | 胶囊体。 | `FVector` 中心点 `Float` 半高 `float` 半径 `Fmatrix` 胶囊体旋转 `FColor` 颜色 |
| `UE_VLOG_MESH` | 3D网格体。 | `TArray<FVector>` 网格体顶点 `TArray<int32>` 三角形指数（必须三个一组） `FColor` 颜色 |
| `UE_VLOG_CONVEXPOLY` | 2D凸包多边形。 | `TArray<FVector>` 凸包点 `FColor` 颜色 |
| `UE_VLOG_ARROW` | 带箭头的线条段。 | `Fvector` 尾部位置 `Fvector` 头部位置 `FColor` 颜色 |
