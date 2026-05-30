# 面板布料编辑器（续 2）

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor
- 原始文件：unreal-engine-panel-cloth-editor.origin.md
- 分段：第 2/2 段

## 中文整理

### 布料资产终端

正如消息所述，我们需要有一个有效的 ClothAssetTerminal 节点来创建可用的 Cloth Asset。通过右键单击数据流图表并选择 ClothAssetTerminal 来添加布料资产终端节点。然后将其连接到图表，确保它始终是数据流图表中的最后一个节点。 ClothAssetTerminal 节点获取数据流图的结果并将其放置在 ClothAsset 中。布料资源终端节点（细节面板）显示与数据流资源以及材质、骨架、物理资源（碰撞）、LOD 和布料（代理）变形器的连接。接下来的步骤将设置模拟配置参数并显示添加最大距离绘制贴图的过程。请注意，我们现在使用术语“映射”而不是“蒙版”。

### 模拟配置

如果您使用过 UE 5.x 中的旧版布料编辑器，那么您应该熟悉混沌布料模拟参数的属性面板。使用面板编辑器和数据流时，我们实际上建议您使用单独的配置，而不是一体化的“SimulationDefaultConfig”节点。重要的！使用单独的配置和一体化配置之间的区别与它们如何处理 MaxDistance 和使用权重贴图有关。一体化的SimulationDefaultConfig 节点必须保持与旧版编辑器的向后兼容性，因此这就是它仍然存在的原因。然而，由于我们已经在新的面板布料编辑器中使用 0 到 1 值而不是遮罩来转向权重贴图（对于最大距离，在旧版编辑器中可能需要数百或更多的数字），我们认为在数据流设置期间使用更详细的配置节点更容易理解。这也将有助于重用各种权重图，所有权重图都具有 0-1 权重值。

### 绘制/添加权重图 - 最大距离

与旧版布料编辑器类似 - 我们需要有一个最大距离，以便让混沌解算器知道我们的布料可以移动多远。如前所述，不同之处在于这是一个 0-1 标量绘制值。我们将在稍后演示的单独配置节点上设置距离。要绘画，首先在 3D 渲染视口中选择布料。注意：我们在数据流图中选择了“TransferSkinWeights”节点。这将导致我们的新节点在选定的数据流节点之后创建。在左侧菜单中，您将看到 MapPnt 按钮。按下即可激活。绘制工具变为活动状态，2D/3D 面板编辑器已准备好绘制权重图。首先，将“MaxDistance”（没有引号，名称很重要！）添加到“更新节点”下的“名称”槽中，将属性值保持为 1.0，强度保持为 1.0。现在，我们将保持非常简单，仅使用画笔动作。您可以根据模拟网格的大小/比例随意调整画笔大小。现在，只需将所有面板的值绘制为“1”即可。与在旧版布料编辑器中使用最大距离蒙版类似，这有效地使每个顶点都变得动态。您也可以使用“洪水填充当前”，但这样我们就无法向您展示画笔工具了！再次强调，保持这个非常简单（绘画工具仍在进行中......

### 3D 渲染视口

### 重置布料

### 更多绘画贴图选项

### 模拟最大距离配置

### 附加配置

### 模拟PBDBendingSpringConfig

### 模拟PBDAreaSpringConfig

### 模拟PBDEdgeSpringConfig

### 模拟空气动力学配置

### 模拟阻尼配置

### 仿真解算器配置

### 设置SimulationCollisionConfig

### 最终图表

### 预览面板布

### 预览场景中的骨架网格物体和动画资源

### 在编辑器/蓝图中分配布料资源

## 相关链接

- [⚠️ IMPORTANT](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#%E2%9A%A0%EF%B8%8Fimportant)
- [Overview of Experimental Panel-Based Cloth Editor](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#overviewofexperimentalpanel-basedclotheditor)
- [Legacy vs. New Cloth Panel Editor](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#legacyvsnewclothpaneleditor)
- [Workflow Limitations/What's Missing](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#workflowlimitations/what'smissing)
- [Example Content Files](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#examplecontentfiles)
- [Panel Cloth Editor](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#panelclotheditor)
- [Cloth Editor Navigation](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#clotheditornavigation)
- [Dataflow Graph Overview](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#dataflowgraphoverview)
- [Simulation Visualization](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#simulationvisualization)
- [Outliner](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#outliner)
- [DCC Panel Cloth Asset Generation](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#dccpanelclothassetgeneration)
- [Generate Static Meshes in DCC](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#generatestaticmeshesindcc)
- [Unreal Engine Panel Cloth Setup](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#unrealenginepanelclothsetup)
- [Plugins](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#plugins)
- [Import Static Meshes](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#importstaticmeshes)
- [Create Cloth Asset](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#createclothasset)
- [Static Mesh Import Two Nodes](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#staticmeshimporttwonodes)
- [Merge Cloth Collections](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#mergeclothcollections)
- [Transfer Skin Weights](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#transferskinweights)
- [Cloth Asset Terminal](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#clothassetterminal)
- [Simulation Configs](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#simulationconfigs)
- [Paint/Add Weight Map - Max Distance](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#paint/addweightmap-maxdistance)
- [3D Render Viewport](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#3drenderviewport)
- [Reset Cloth](https://dev.epicgames.com/community/learning/tutorials/pv7x/unreal-engine-panel-cloth-editor#resetcloth)
