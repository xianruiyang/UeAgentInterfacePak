# GeometryCore 中的 TPointHashGrid3d

# GeometryCore 中的 TPointHashGrid3d

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/38JR/unreal-engine-tpointhashgrid3d-in-geometrycore

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2445 字符。

## 摘要

关于使用 GeometryCore 模块中内置 TPointHashGrid3d 的简要教程。

## 中文整理

### 概览

在实现一些僵尸群时，我需要能够从一堆对象中快速选择最近的对象。有多种方法可以实现这一点，包括使用物理和简单地查询重叠，或者可能构建我自己的空间哈希。但我偶然发现了位于 GemoteryCore 的 Spatial 命名空间中的 TPointHashGrid3d。 [https://docs.unrealengine.com/5.0/en-US/API/Plugins/GeometricObjects/Spatial/TPointHashGrid3/](https://docs.unrealengine.com/5.0/en-US/API/Plugins/GeometricObjects/Spatial/TPointHashGrid3/) GeometryCore 模块（以前的几何对象）具有我仍在发现的各种好东西，但我认为它会很有用记录我对 TPointHashGrid3d 的使用。首先，确保将 GeometryCore 添加到您的构建 cs 中：

```cpp
PrivateDependencyModuleNames.AddRange(
			new string[]
			{
				"GeometryCore"
				// ... add private dependencies that you statically link with here ...	
			}
			);
```

接下来，用 ** UE::Geometry::TPointHashGrid3d *PointHash3;** 声明一个指针成员变量，因为这不是 UObject，所以您负责使用 new 和 delete 进行创建和销毁。 （就我而言，我从子系统中使用它，所以我在 Initialize() 中创建它并在 DeInitialize() 中删除

```cpp
//...Declare member variable in header
UE::Geometry::TPointHashGrid3d *PointHash3;
//...create it in Initialize()
PointHash3 = new UE::Geometry::TPointHashGrid3d<int>(100, -1);
///...later delete in DeInitialize() when not needed
delete PointHash3;
```

要将点添加到 PointHash，请使用 InsertPoint()，传递索引和向量。就我而言，我还将目标添加到目标数组中。

```cpp
int Idx = Targets.Add(TargetActor);
FVector3d Location = TargetActor->GetActorLocation();
PointHash3->InsertPoint(Idx, Location);
```

最后，您可以使用 FindNearestInRadius() 查询哈希值。该函数返回 TPair，并接受 DistSquared lambda 作为参数

```cpp
UFUNCTION(BlueprintCallable, Category = Horde)
	AActor* GetClosestTarget(FVector Location, float Radius)
	{
		
		TPair<int, double> Nearest = PointHash3->FindNearestInRadius(Location, Radius, [this, &Location](const int& VID)->double { return FVector3d::DistSquared(Location, Targets[VID]->GetActorLocation()); });
		return Targets[Nearest.Key];
	}
```

总之，TPointHashGrid3d 是快速且相当容易使用的内置空间哈希。这是一个很棒的小花絮，可以添加到您的游戏开发工具库中。

