# 面板布料编辑器更新 (5.5)（续 2）

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/xjpO/unreal-engine-panel-cloth-editor-updates-5-5
- 原始文件：unreal-engine-panel-cloth-editor-updates-5-5.origin.md
- 分段：第 2/2 段

## 中文整理

### ClothAsset 更新

- 布料编辑器和数据流编辑器：允许在 PIE 运行时启动工具 布料编辑器和数据流编辑器：允许在 PIE 运行时启动工具 - 布料编辑器：从选择工具中删除辅助选择。

允许从输入集合导入辅助选择，以允许安全的数据迁移。

布料编辑器：从选择工具中删除辅助选择。

允许从输入集合导入辅助选择，以允许安全的数据迁移。

- 布料编辑器：单击WeightMap 节点启动Paint 工具时，根据节点的MeshTarget 值将构造视口视图模式更改为适当的Sim/Render 模式。

当工具处于活动状态时，不允许在“渲染”和“模拟”模式之间进行更改（但如果处于“模拟”模式，则允许更改 2D/3D）（见上文） 布料编辑器：单击 WeightMap 节点以启动“绘制”工具时，根据节点的 MeshTarget 值将构造视口视图模式更改为适当的“模拟/渲染”模式。

当工具处于活动状态时，不允许在渲染和模拟模式之间进行更改（但如果处于模拟模式，则允许更改 2D/3D）（见上文） - 布料编辑器：回滚之前的更改，在两个视口中禁用飞行模式相机。

添加单击拖动行为，该行为将阻止鼠标左键拖动时相机移动，但允许其他所有操作布料编辑器：回滚之前的更改，在两个视口中禁用飞行模式相机。

添加单击拖动行为，该行为将在鼠标左键拖动时阻止相机移动，但允许其他一切 - 布料编辑器预览：重新加载或更改 SkeletalMeshAsset 时，保存并恢复动画状态，以便它不会总是从零时间开始播放 布料编辑器预览：当重新加载或更改 SkeletalMeshAsset 时，保存并恢复动画状态，以便它不会总是从零时间开始播放 - 布料编辑器：添加在构造视口中可视化表面法线的功能布料编辑器：添加在构造视口中可视化表面法线的功能 - 布料编辑器：添加一个新的“WeightMap Node”，它将取代 AddWeightMapNode。

弃用旧的 AddWeightMapNode。

新节点只有一组顶点权重，而不是两组。

已弃用的 AddWeightMapNode 仍然可以在图表中使用，但其属性无法编辑，并且不再链接到权重图绘制工具。

用户应将其权重图数据从 AddWeightMap 节点迁移到 WeightMap 节点。

（见上文）布料编辑器：添加一个新的“WeightMap Node”，它将取代 AddWeightMapNode。

弃用旧的 AddWeightMapNode。

新节点只有一组顶点权重，而不是两组。

已弃用的 AddWeightMapNode 仍然可以在图表中使用，但其属性无法编辑，并且不再链接到权重图绘制工具。

用户应将其权重图数据从 AddWeightMap 节点迁移到 WeightMap 节点。

（见上文） - 在选择工具中添加了增长、收缩和泛洪按钮 在选择工具中添加了增长、收缩和泛洪按钮

### 布料重量图

- 布料权重绘制工具：将 0.0 权重值绘制为蓝色，将 1.0 权重值绘制为黄色。通过 UI 中的复选框可切换此行为。布料权重绘制工具：将 0.0 权重值绘制为蓝色，将 1.0 权重值绘制为黄色。通过 UI 中的复选框可切换此行为。 - 布料权重贴图绘制工具：对权重贴图节点的更改可撤销布料权重贴图绘制工具：对权重贴图节点的更改可撤销

### 重新划分网格

- Remesher：添加可用于自适应密度重新网格化的可选边缘长度缩放函数 Remesher：添加可用于自适应密度重新网格化的可选边缘长度缩放函数 - 布料编辑器重新网格节点：添加用于渲染网格抽取的简化选项。启用后，这将使用 FSimplifyMeshOp 而不是 FRemeshMeshOp。简化器使用 QEM 优先删除平坦区域中的顶点以保留曲率。与 FRemeshOp 相比，结果通常是多边形数量较少，但网格不太均匀。因此，它仅对渲染网格启用。布料编辑器重新网格节点：为渲染网格抽取添加简化选项。启用后，此...

### 5.5 中的错误修复亮点

## 相关链接

- [Updates for 5.5](https://dev.epicgames.com/community/learning/tutorials/xjpO/unreal-engine-panel-cloth-editor-updates-5-5#updatesfor55)
- [Updated ClothAsset Template Dataflow Graph](https://dev.epicgames.com/community/learning/tutorials/xjpO/unreal-engine-panel-cloth-editor-updates-5-5#updatedclothassettemplatedataflowgraph)
- [Weight Map Replaces AddWeightMap Node](https://dev.epicgames.com/community/learning/tutorials/xjpO/unreal-engine-panel-cloth-editor-updates-5-5#weightmapreplacesaddweightmapnode)
- [Proxy Deformer Updates](https://dev.epicgames.com/community/learning/tutorials/xjpO/unreal-engine-panel-cloth-editor-updates-5-5#proxydeformerupdates)
- [Wind Velocity/Scale Space](https://dev.epicgames.com/community/learning/tutorials/xjpO/unreal-engine-panel-cloth-editor-updates-5-5#windvelocity/scalespace)
- [Velocity and Acceleration Clamps](https://dev.epicgames.com/community/learning/tutorials/xjpO/unreal-engine-panel-cloth-editor-updates-5-5#velocityandaccelerationclamps)
- [Blueprint Runtime Interactors](https://dev.epicgames.com/community/learning/tutorials/xjpO/unreal-engine-panel-cloth-editor-updates-5-5#blueprintruntimeinteractors)
- [Dataflow Editor Updates](https://dev.epicgames.com/community/learning/tutorials/xjpO/unreal-engine-panel-cloth-editor-updates-5-5#datafloweditorupdates)
- [Auto-Switch View Modes](https://dev.epicgames.com/community/learning/tutorials/xjpO/unreal-engine-panel-cloth-editor-updates-5-5#auto-switchviewmodes)
- [Show/Hide Inputs](https://dev.epicgames.com/community/learning/tutorials/xjpO/unreal-engine-panel-cloth-editor-updates-5-5#show/hideinputs)
- [Other 5.5 Updates](https://dev.epicgames.com/community/learning/tutorials/xjpO/unreal-engine-panel-cloth-editor-updates-5-5#other55updates)
- [ClothAsset and Legacy Cloth Updates](https://dev.epicgames.com/community/learning/tutorials/xjpO/unreal-engine-panel-cloth-editor-updates-5-5#clothassetandlegacyclothupdates)
- [ClothAsset Updates](https://dev.epicgames.com/community/learning/tutorials/xjpO/unreal-engine-panel-cloth-editor-updates-5-5#clothassetupdates)
- [ClothAsset - Sequencer/Blueprints/CVAR](https://dev.epicgames.com/community/learning/tutorials/xjpO/unreal-engine-panel-cloth-editor-updates-5-5#clothasset-sequencer/blueprints/cvar)
- [ClothAsset Updates](https://dev.epicgames.com/community/learning/tutorials/xjpO/unreal-engine-panel-cloth-editor-updates-5-5#clothassetupdates-2)
- [Cloth Weight Map](https://dev.epicgames.com/community/learning/tutorials/xjpO/unreal-engine-panel-cloth-editor-updates-5-5#clothweightmap)
- [Remeshing](https://dev.epicgames.com/community/learning/tutorials/xjpO/unreal-engine-panel-cloth-editor-updates-5-5#remeshing)
- [Bug Fix Highlights in 5.5](https://dev.epicgames.com/community/learning/tutorials/xjpO/unreal-engine-panel-cloth-editor-updates-5-5#bugfixhighlightsin55)
- [文档与教程](https://dev.epicgames.com/community/learning/tutorials/xjpO/unreal-engine-panel-cloth-editor-updates-5-5#%E6%96%87%E6%A1%A3%E4%B8%8E%E6%95%99%E7%A8%8B)
