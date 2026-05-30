# 虚幻引擎 4 中的六边形网格寻路 (Part 1/3)

# 虚幻引擎 4 中的六边形网格寻路 (Part 1/3)

Source file: `hexagonal-grid-pathfinding-in-unreal-engine-4.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/Bb3J/hexagonal-grid-pathfinding-in-unreal-engine-4
## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 22149 字符。
## 摘要

关于如何将虚幻引擎 4 通用图形 A* 实现与六边形网格结合使用的示例项目，该项目的目的是指导您了解设置六边形网格导航所需的基础知识。
## 中文整理
### 先决条件

- [C++ 好知识](https://www.learncpp.com/) - Red Blob Games 有关六边形网格的文章。 - [六角网格参考。](https://www.redblobgames.com/grids/hexagons/) - [六角网格实现指南。](https://www.redblobgames.com/grids/hexagons/implementation.html)
### 阅读将使您更好地理解我的示例项目

- [关于替换探路者的史诗 wiki 文章。](https://unrealcommunity.wiki/replacing-the-pathfinder-h6eyeor0) - [Chris Russel 在 UE4 中用 A* 完美替换 NavMesh。](https://crussel.net/2016/06/05/neatly-replacing-navmesh-with-a-in-ue4/) - [关于自定义路径跟随的史诗 wiki 文章组件。](https://unrealcommunity.wiki/ai-navigation-in-cpp-customize-path-following-every-tick-2n7ju142)
### GraphAStarExample 项目

![GraphAStarExample 项目](assets/hexagonal-grid-pathfinding-in-unreal-engine-4/image-01.jpg)

欢迎来到我的示例项目，了解如何使用虚幻引擎 4 通用图形 A* 实现与六角形网格，该项目的目的是指导您了解在六角形网格上设置导航所需的基础知识，这不是完整的教程，而是更像一个指南，并且不涵盖诸如回避、网格传输等主题。在该项目中，您将找到两个示例，A 和 B，两个示例都使用相同的 Pathfinder，示例 B 只是一个额外的功能，它将向您展示您的内容可以使用自定义 PathFollowingComponent 来完成。
### 您需要了解的类和结构

- ANavigationData - ARecastNavMesh - FGraphAStar - AAIController（可选） - UPathFollowingComponent（可选）
### 导航数据

表示抽象导航数据（子类为 NavMesh、NavGraph 等）。用作由 NavigationSystem 处理的所有导航类型的通用接口。在这里你会发现很多有趣的东西，但对我们来说最重要的是FindPathImplementation类成员，这是一个函数指针。

**ANavigationData::FindPathImplementation**

```cpp
typedef FPathFindingResult (*FFindPathPtr)(const FNavAgentProperties& AgentProperties, const FPathFindingQuery& Query);
FFindPathPtr FindPathImplementation;
```

另外 ANavigationData::FindPath 函数对我们来说非常重要，该函数返回 FindPathImplementation 指向的函数的结果。

**ANavigationData::FindPath**

```cpp
/** 
 * Synchronously looks for a path from @StartLocation to @EndLocation for agent with properties @AgentProperties. 
 * NavMesh actor appropriate for specified FNavAgentProperties will be found automatically
 * @param ResultPath results are put here
 * @return true if path has been found, false otherwise
 *
 * @note don't make this function virtual! Look at implementation details and its comments for more info.
 */
FORCEINLINE FPathFindingResult FindPath(const FNavAgentProperties& AgentProperties, const FPathFindingQuery& Query) const
{
```

看一下注释“不要使这个函数虚拟！”，我们稍后会再讨论它。
### 重播导航网格

这个类继承自 ANavigationData 并扩展了他的功能，每次你在地图中放置一个 NavMeshBoundsVolume 时，都会创建一个这个类的对象（你可以在 World Outliner 中看到它），就是 RecastNavMesh-Default 对象！这是我们必须继承的类！我们来看看这个类是如何实现ANaviigationData::FindPath函数的，我们已经知道这个函数不是虚函数，那么我们如何实现它呢？我们有 FindPathImplementation 函数指针！在标题中，您可以看到 ARecastNavMesh::FindPath 声明。

**FPathFindingResult::FindPath**

```cpp
static FPathFindingResult FindPath(const FNavAgentProperties& AgentProperties, const FPathFindingQuery& Query);
```

该函数是静态的是有原因的，（wiki复制粘贴->）*代码中的注释解释了这是出于性能原因：Epic担心如果很多代理在同一帧中调用探路器，则虚拟调用开销将累积并花费太长时间，因此该函数被声明为静态并存储在FindPathImplementation函数指针中。这意味着您需要在新的导航类构造函数*（或像我在示例中所做的那样的其他函数中）手动设置函数指针。这是我们将在继承类中实现的函数（FindPathImplementation 将指向）！
### F图A星

最后，我们进入示例的（第二个）核心类（好吧好吧，是一个结构体），FGraphAstar 是 A* 算法的虚幻引擎 4 通用实现。如果打开 (\Engine\Source\Runtime\AIModule\Public) GraphAStar.h 文件，您会在注释中找到有关如何使用它的说明，让我们看一下：*通用图 A* 实现。 TGraph 保存图形表示。需要实现的功能：*

```cpp
/* Returns number of neighbors that the graph node identified with NodeRef has */
int32 GetNeighbourCount(FNodeRef NodeRef) const;

/* Returns whether given node identification is correct */
bool IsValidRef(FNodeRef NodeRef) const;

/* Returns neighbor ref */
FNodeRef GetNeighbour(const FNodeRef NodeRef, const int32 NeighbourIndex) const;
```

*还需要指定节点类型*

```
FNodeRef - type used as identification of nodes in the graph
```

*TQueryFilter（FindPath 的参数）过滤器类决定可以使用哪些图边以及以什么成本。它需要实现以下功能：*

```cpp
/**
* Used as GetHeuristicCost's multiplier
 */
float GetHeuristicScale() const;

/**
 * Estimate of cost from StartNodeRef to EndNodeRef
 */
float GetHeuristicCost(const int32 StartNodeRef, const int32 EndNodeRef) const;
```

因此，我们不必从 FGraphAStar 创建一个类（好吧，是一个结构体），但我们必须在调用 FGraphAStar::FindPath 函数的类中实现上述代码，在我们的例子中，这个类将是 AGraphAStarNavMesh（继承自 ARecastNavMesh）。您可以在 (\Engine\Source\Runtime\AIModule\Classes\Navigation) NavLocalGridData.h 中找到有关如何执行此操作的好示例
### AAI控制器（可选）

在项目中，您将找到两个示例 A 和 B： - 示例 A 使用默认 AIController (BP_AIController_Example_A) - 示例 B 使用自定义 AIController (BP_AIController_Example_B) 和自定义 PathFollowingComponent (HGPathFollowingComponent)。要使用自定义 PathFollowingComponent，我们必须继承 AAIController 类并告诉她我们要使用 PathFollowingComponent 的哪个类。我们稍后会在 AHGAIController 部分讨论它。
### UPathFollowingComponent（可选）

该组件将让您的 AI 遵循路径，它充满了有趣的函数和变量，我们将仅覆盖其中两个函数，只是为了向您展示它们在这里以及您可以使用自定义 PathFollowingComponent 做什么。我们稍后将在 UHGPathFollowingComponent 部分讨论它。
### 我们在项目中使用的类和结构

- AGraphAStarNavMesh（继承自 ARecastNavMesh） - AHexGrid（继承自 AActor） - HGTypes（AHexGrid 使用的结构体集合） - AHGAIController（继承自 AAIController） - UHGPathFollowingComponent（继承自 UPathFollowingComponent）

