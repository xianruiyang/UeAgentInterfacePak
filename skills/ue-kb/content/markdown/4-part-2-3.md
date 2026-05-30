# 虚幻引擎 4 中的六边形网格寻路 (Part 2/3)

# 虚幻引擎 4 中的六边形网格寻路 (Part 2/3)

Source file: `hexagonal-grid-pathfinding-in-unreal-engine-4.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### AGraphAStarNavMesh

我们最重要的课程，魔法发生的地方！这是我们“集成”FGraphAStar 实现的地方，这将非常容易！在此之前，我们需要一个指向 AHexGrid 类的指针，这将是我们将在其上执行寻路的六边形网格（请参阅 AHexGrid 部分）。

```cpp
/* Just a pointer to an hexagonal grid actor */
UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category = "GraphAStarExample|NavMesh")
class AHexGrid *HexGrid;
```

我们还需要一个函数来设置这个指针，这个函数是我们示例的关键点之一，它将从我们的 FindPath 实现切换到 ARecastNavMesh::FindPath 实现（默认行为）。这可以实时完成！好吧好吧，如果我们在人工智能沿着一条路径进行时这样做，它会在切换发生之前完成它。 （我认为可以即时进行切换，但我们不会在这个项目中这样做。）

```cpp
/* Set a pointer to an hexagonal grid, it can be nullptr */
UFUNCTION(BlueprintCallable, Category = "GraphAStarExample|NavMesh")
void SetHexGrid(class AHexGrid *HGrid);

void AGraphAStarNavMesh::SetHexGrid(AHexGrid *HGrid)
{
	if (HGrid)
	{
		// If the pointer is valid we will use our implementation of the FindPath function
		HexGrid = HGrid;
```

好的，继续，让我在标头中定义 FGridPathFilter 结构

```cpp
/**
 * TQueryFilter (FindPath's parameter) filter class is what decides which graph edges can be used and at what cost.
 */
struct FGridPathFilter
{
	FGridPathFilter(const AGraphAStarNavMesh &InNavMeshRef) : NavMeshRef(InNavMeshRef) {}

	/**
	 * Used as GetHeuristicCost's multiplier
	 */
```

正如你所看到的，这个结构体还引用了我们的 AGraphAStarNavMesh，我们将在实现中使用它

```cpp
float FGridPathFilter::GetHeuristicScale() const
{
	// For the sake of simplicity we just return 1.f
	return 1.0f;
}

float FGridPathFilter::GetHeuristicCost(const int32 StartNodeRef, const int32 EndNodeRef) const
{
	return GetTraversalCost(StartNodeRef, EndNodeRef);
}
```

现在我们要做的就是声明 FNodeRef typedef 和 FGraphAStar 请求的函数

```cpp
/* Type used as identification of nodes in the graph */
typedef int32 FNodeRef;

/* Returns number of neighbors that the graph node identified with NodeRef has */
int32 GetNeighbourCount(FNodeRef NodeRef) const;

/* Returns whether given node identification is correct */
bool IsValidRef(FNodeRef NodeRef) const;

/* Returns neighbor ref */
```

```cpp
int32 AGraphAStarNavMesh::GetNeighbourCount(FNodeRef NodeRef) const
{
	return 6;
}

bool AGraphAStarNavMesh::IsValidRef(FNodeRef NodeRef) const
{
	return HexGrid->CubeCoordinates.IsValidIndex(NodeRef);
}
```

你会注意到我们没有对 HexGrid 指针的有效性进行任何检查，因为（在我看来）没有理由这样做，如果 HexGrid 指针为空，我们不运行此代码，我们运行 FindPath 的默认实现（ARecastNavMesh 版本）。最后是整个项目真正的女王，FindPath 函数

```cpp
static FPathFindingResult FindPath(const FNavAgentProperties &AgentProperties, const FPathFindingQuery &Query);
```

该函数采用两个参数： - FNavAgentProperties &AgentProperties - FPathFindingQuery &Query 我们将使用 FPathFindingQuery 来获取路径的起点和终点（让我说，在较高级别上，此数据是由 MoveTo 调用填充的，不是 100% 正确，只是告诉您它们来自哪里）。并返回一个结构： - FPathFindingResult 该结构很重要，因为包含 AI 将遵循的路径。

```cpp
struct FPathFindingResult
{
	FNavPathSharedPtr Path;
	ENavigationQueryResult::Type Result;

	FPathFindingResult(ENavigationQueryResult::Type InResult = ENavigationQueryResult::Invalid) : Result(InResult)
	{ }

	FORCEINLINE bool IsSuccessful() const
	{
```

我将在这里跳过第一段代码，因为它与您可以在 ARecastNavMesh::FindPath 中找到的代码相同，让我说它“检查事物”:P 其中一个是获取“this”指针，因为我们处于静态函数中，我们没有“this”指针，并且我们无法访问像 HexGrid 这样的非静态成员变量，幸运的是 FPathFindingQuery 包含指向 ANavigationData 对象的指针。

```cpp
const ANavigationData *Self = Query.NavData.Get();
```

我们可以将其转换为我们的类，这将允许我们访问成员变量（和函数），记住，我们的 AGraphAStarNavMesh 继承自 ARecastNavMesh，而 ARecastNavMesh 继承自 ANavigationData。

```cpp
const AGraphAStarNavMesh *GraphAStarNavMesh{ Cast<const AGraphAStarNavMesh>(Self) };
```

跳转到 FindPath 的核心，我们最终使用 FGraphAStar 来计算 A*。

```cpp
// The pathfinder need a starting and ending point, so we create two temporary
// cube coordinates from the Query start and ending location
FHCubeCoord StartCCoord{ GraphAStarNavMesh->HexGrid->WorldToHex(Query.StartLocation) };
FHCubeCoord EndCCoord{ GraphAStarNavMesh->HexGrid->WorldToHex(Query.EndLocation) };
			
// and than we search in the HexGrid CubeCoordinates array for the index of items 
// equals to our temp coordinates.
const int32 StartIdx{ GraphAStarNavMesh->HexGrid->CubeCoordinates.IndexOfByKey(StartCCoord) };
const int32 EndIdx{ GraphAStarNavMesh->HexGrid->CubeCoordinates.IndexOfByKey(EndCCoord)};
```

正如你所看到的，它非常易于使用，在我们创建了一个存储路径索引和起点/终点的数组之后，我们使用 AGraphAStarNavMesh 作为模板创建了一个 FGraphAstar 实例，我们取消引用 GraphAStarNavMesh 指针并将其作为参数传递。

```cpp
FGraphAStar<AGraphAStarNavMesh> Pathfinder(*GraphAStarNavMesh);
```

FGraphAStar::FindPath 函数需要： - 起点和终点（以索引的形式，因此不是实际坐标，而是存储它们的数组的索引） - FGridPathFilter 的实例，我们在其中传递取消引用的 GraphAStarNavMesh 指针 - 对存储路径点索引的数组的引用。它还返回一个 EGraphAStarResult 枚举，该枚举将告诉我们搜索是否失败或成功。

```cpp
EGraphAStarResult AStarResult{ Pathfinder.FindPath(StartIdx, EndIdx, FGridPathFilter(*GraphAStarNavMesh), PathIndices) };
```

如果搜索成功，我们将使用 PathIndices 数组中存储的所有索引来构建真实的路径，我们已经提到 FPathFindingResult 结构包含 AI 将遵循的路径。

```cpp
case SearchSuccess:

	// Search succeeded
	Result.Result = ENavigationQueryResult::Success;

	// PathIndices array computed by FGraphAStar will not contain the starting point, so
	// we need to add it manually the the Path::PathPoints array
	Result.Path->GetPathPoints().Add(FNavPathPoint(Query.StartLocation));

	// Let's traverse the PathIndices array and build the FNavPathPoints we
```

就是这样，关键概念是 FGraphAStar::FindPath 使用索引，您不需要传递立方体坐标，而是传递它们的索引，我们之前实现的所有“服务”函数和 FGridPathFilter 结构将小心地将这些索引与立方体坐标数组一起使用。遵循代码流程比解释它更容易。现在我们只需要将 AGraphAStarNavMesh 添加到受支持代理的导航系统列表中，为此，您只需打开项目设置，在引擎类别下搜索导航系统，在代理下您将找到一个名为“支持的代理”的空数组，只需单击小 + 符号并在导航数据类和首选导航数据中选择 GraphAStarNavMesh，使用主工具栏中的“构建”按钮重建路径，然后就可以开始了。

![教程图片](assets/hexagonal-grid-pathfinding-in-unreal-engine-4/image-02.jpg)

现在您只需使用 MoveTo 调用（或任何 MoveTo 版本），AI 将遵循您放置在关卡中并通过 SetHexGrid 传递的六边形网格上计算的 A* 路径，如果您使用 SetHexGrid 传递空 actor，系统将回退到默认路径查找。查看 BP_PlayerController 以了解我如何将现有的 HexGrid 传递到 NavMesh 以及如何将目的地设置为 AI 黑板，如果您打开示例行为树 (BT_Example_A/B)，您会注意到它们仅包含一个到 AI 移动目标位置的 MoveTo 任务！
### 六角网格

HexGrid类是六边形网格actor的粗略实现，最重要的函数是AHexGrid::CreateGrid，是基于[Red Blob Games实现](https://www.redblobgames.com/grids/hexagons/implementation.html#map-shapes)所以我强烈建议阅读链接的文章，这里我们只想指出两件事。 - 我在“创建”的每个步骤中使用委托，因此我们可以将图块的创建委托给另一个函数或蓝图事件，该委托是可选的，因此您不必使用它，要做到这一点（使其可选），您需要使用 AutoCreateRefTerm UFUNCTION 元数据标记函数参数

```cpp
UFUNCTION(BlueprintCallable, Category = "GraphAStarExample|HexGrid", meta = (AutoCreateRefTerm = "CreationStepDelegate"))
void CreateGrid(const FHTileLayout &TLayout, const int32 GridRadius, const FCreationStepDelegate &CreationStepDelegate);
```

如果这个委托有界就会被执行，如果没有……就不会。

```cpp
CreationStepDelegate.ExecuteIfBound(TileLayout, CCoord);
```

- 我们使用一个简单的公式来计算我们想要在数组中保留多少空间，这样做是因为“Add”调用在使用大量时间时可能会很昂贵，并且如果我们创建半径> 10个图块的网格，它将在for循环中被调用数百次。

```cpp
int32 Size{ 1 };
for (int32 i{ 1 }; i <= Radius; ++i)
{
	Size += 6 * i;
}
CubeCoordinates.Reserve(Size);

// Check if we provided a delegate, if yes we also reserve space in the GridTiles array.
if (CreationStepDelegate.IsBound())
{
```

您可以在[此处](https://www.unrealengine.com/en-US/blog/optimizing-tarray-usage-for-performance)找到有关优化 TArray 使用以提高性能的更多信息。我还定义了 Tiles 的粗略表示，FHexTile 结构包含带有图块的简单网格所需的基本数据。此类的所有其他功能都非常简单，每个功能都作为相关 Red Blob Game 文章部分的链接。
### HG类型

该标头仅包含用于创建六角形网格的数据结构和枚举，Red Blob Games 文章比我更好地解释了它们的工作原理和原因。代码中的 Heach 结构和枚举具有指向相关 Red Blob Games 文章的链接。

