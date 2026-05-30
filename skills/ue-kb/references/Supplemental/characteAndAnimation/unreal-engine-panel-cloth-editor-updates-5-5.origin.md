# 面板布料编辑器更新 (5.5)

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/xjpO/unreal-engine-panel-cloth-editor-updates-5-5
- 原始文件：unreal-engine-panel-cloth-editor-updates-5-5.origin.md
- 分段：第 1/2 段

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 14088 字符。

## 摘要

5.5 中的 Beta 混沌布料面板编辑器具有一些新的更新、生活质量的改进和大量错误修复。本文档将提供一个全面的...

## 中文整理

### 5.5 更新

当我们准备在 5.6 中与通用数据流编辑器完全集成时，混沌布料面板编辑器具有以下需要注意的重要更改。本文档应用作先前 5.3 和 5.4 面板布料教程的附录。请参阅本页底部的链接。混沌面板布料编辑器是测试版。

### 更新了 ClothAsset 模板数据流图

已从 5.4 默认 ClothAsset 模板中删除了已弃用的节点，并且在创建新的 5.5 ClothAsset 时可以使用更新的图形预设。下图显示了新的默认数据流图的更新。

### 权重图替换 AddWeightMap 节点

5.5 弃用了 AddWeightMap 节点并将其替换为 WeightMap 节点。

现有的 AddWeightMap 节点将继续像以前一样在图中进行评估，但无法编辑。

已弃用的 AddWeightMap 节点存储了两个权重贴图：一张用于模拟，一张用于渲染顶点。

新的权重贴图节点仅存储一个权重贴图并将其应用于一种或另一种顶点类型。

要迁移图表，您需要将 AddWeightMap 节点替换为 WeightMap 节点。

如果您不想重新绘制，可以按照以下方法将数据从已弃用的节点复制到新节点中： - 在已弃用的 AddWeightMap 节点的下游连接一个新的 WeightMap 节点 在已弃用的 AddWeightMap 节点的下游连接一个新的 WeightMap 节点 - 将 AddWeightMap 的 Name 输出连接到 WeightMap 的 InputName 输入，然后连接 Collection -> Collection 将 AddWeightMap 的 Name 输出连接到 WeightMap 的 InputName 输入，然后连接集合 -> 集合 - 确保新节点的地图覆盖类型设置为替换已更改 确保新节点的地图覆盖类型设置为替换已更改 - 单击新节点以启动绘制工具 单击新节点以启动绘制工具 - 将地图覆盖类型更改为全部替换并单击接受 将地图覆盖类型更改为全部替换并单击接受 - 删除旧节点并重新连线本地图形 删除旧节点并重新连线本地图形 或者...

- 将 AddWeightMap 集合连接到 WeightMap Transfer Collection 引脚 将 AddWeightMap 集合连接到 WeightMap Transfer Collection 引脚 - 确保新节点的 Map Override Type 设置为 Replace All 确保新节点的 Map Override Type 设置为 Replace All - 使用 Transfer 按钮将旧的​​已弃用权重复制到新的 WeightMap 节点。

使用 Transfer 按钮将旧的​​已弃用权重复制到新的 WeightMap 节点。

### 代理变形器更新

ProxyDeformer 在 5.5 中已更新至 v2，并分为两个节点 - ProxyDeformer 和 SkinningBlend。新行为： - 没有 ProxyDeformer 节点 -> 布料完全变形。没有 ProxyDeformer 节点 -> 布料完全变形。 - 没有选择过滤器的 ProxyDeformer 节点 -> 布料已完全蒙皮。没有选择过滤器的 ProxyDeformer 节点 -> 布料已完全蒙皮。 - 具有选择过滤器的 ProxyDeformer 节点 -> 布料部分变形/蒙皮。具有选择过滤器的 ProxyDeformer 节点 -> 布料部分变形/蒙皮。此外，与 SkinningBlend 过渡贴图相关的所有输入/输出和参数都将被删除并移动到新节点。仍然计算 SkinningBlend 贴图（它是 Deformer 架构的一部分），但没有平滑过渡，并且使用过滤器集来启用/禁用蒙皮，而不是使用 MaxDistance 权重贴图。为了获得平滑过渡，您必须在 MaxDistanceConfig 节点之后添加 SkinningBlend。这两个节点被设计为协同工作。这使得它可以将 ProxyDeformer 保留在评估的早期，以避免每次更改时重新触发。结合更新的 ProxyDeformer，我们在创建 Sim to Render 代理关系时删除了辅助选择工作流程。用户现在可以创建两个单独的选择节点（渲染选择和模拟选择）并连接到 ProxyDeformer，而不是使用一个选择节点并使用主要/次要选择按钮来生成相应的顶点/面。这使您可以在处理更复杂的布料设置时对代理关系有更好的逻辑概述。

### 风速/尺度空间

对于 5.5，我们在SimulationAerodynamicsConfig 节点中添加了风速空间控件，以在不同空间中指定 WindVelocity（和 VelocityScale），而不是默认的世界（对于风速）和参考骨骼（对于 VelocityScale）。

### 速度和加速度钳位

同样对于 5.5，SimulationVelocityScale 配置包括 MaxLinear 和 MaxAngular 速度和加速度可选控制钳位。与 RBAN 类似，在缩放之后应用钳位。

### 蓝图运行时交互器

5.5 添加了蓝图交互器功能，其处理方式与旧版布料蓝图交互器不同。这是一个可以获取和设置值的蓝图示例（如下）。您可以从蓝图中获取/设置的任何属性都应该在右键单击菜单中具有一个新选项“复制交互器名称”。这是您在获取/设置节点上的 PropertyName 字段中使用的名称。在此示例中，我们右键单击“Lift”参数，将其复制并添加到“获取/设置加权浮点值”属性名称槽中的动画蓝图中。添加了面板布料的新节点：获取布料服装交互器。该节点连接到 animBP 中的获取/设置加权浮点值节点。由于该参数是在上一步中从“复制交互器名称”中右键单击复制的，因此将该值（在本例中为“Lift”）粘贴到“获取加权浮点值”和“设置加权浮点值”的两个属性名称条目中。对您希望在运行时控制的任何其他面板布料属性名称进行冲洗和重复。

### 数据流编辑器更新

### 自动切换查看模式

在 5.5 中，我们现在在启动 Paint 工具时根据 WeightMap 节点的 Mesh Target 属性自动切换视图模式。这还可以防止在工具处于活动状态时切换到“错误”的视图模式。 （例如，当您的节点设置为“模拟”时，“渲染”模式下不会进行绘画 - 它呈灰色显示，反之亦然，当设置为“渲染”时）

### 显示/隐藏输入

5.5 添加了显示/隐藏引脚输入以保存图形显示的功能。

### 其他 5.5 更新

### ClothAsset 和旧版布料更新

- 布料资产和旧布料：添加了内部和外部升力和阻力的概念。这允许在空气撞击布料的正面和背面时设置不同的升力和阻力系数。 * 仅布料资源：增加了在不同空间（而不仅仅是世界空间）中指定 WindVelocity 的能力。布料资产和旧布料：添加了内部和外部升力和阻力的概念。这允许在空气撞击布料的正面和背面时设置不同的升力和阻力系数。 * 仅布料资源：增加了在不同空间（而不仅仅是世界空间）中指定 WindVelocity 的能力。 - 旧版混沌布料：将 FlatnessRatio 添加到配置中。旧版混沌布料：将 FlatnessRatio 添加到配置中。

### ClothAsset 更新

- 混沌布可视化更新。

* 修复了 PIE 暂停时显示的布料调试绘制。

这只是切换到不在前景中绘制的问题，因为前景 Linebatcher 队列会刷新每一帧，即使在暂停时也是如此。

* 添加一个选项，通过 cvar 在前景或世界中绘制 (p.ChaosClothVisualization.DrawInForeground) * 在 PIE 中/资产编辑器外部启用所有基于文本的调试绘制（暂停时不起作用，但这是一个开始）。

* 更新绘制局部空间以显示参考骨骼的名称。

混沌布可视化更新。

* 修复了 PIE 暂停时显示的布料调试绘制。

这只是切换到不在前景中绘制的问题，因为前景 Linebatcher 队列会刷新每一帧，即使在暂停时也是如此。

* 添加一个选项，通过 cvar 在前景或世界中绘制 (p.ChaosClothVisualization.DrawInForeground) * 在 PIE 中/资产编辑器外部启用所有基于文本的调试绘制（暂停时不起作用，但这是一个开始）。

* 更新绘制局部空间以显示参考骨骼的名称。

- 混沌布：添加了速度和加速度夹。

与 RBAN 类似，在缩放之后应用钳位。

（见上文）混沌布：添加了速度和加速度夹。

与 RBAN 类似，在缩放之后应用钳位。

（见上文） - 启用跟随者皮肤资产组件的骨骼调试显示（例如，典型的混沌布资产使用）。

启用跟随者皮肤资产组件的骨骼调试显示（例如，典型的混沌布资产使用）。

- 将 ChaosClothAsset 添加到布料总周期统计中。

将 ChaosClothAsset 添加到布料总周期统计中。

- 混沌布料资源：添加了在不同模拟空间中指定速度比例和夹具的功能（默认为参考骨骼空间，这是之前的行为）。

Chaos Cloth Asset：添加了在不同模拟空间中指定速度比例和夹具的功能（默认为参考骨骼空间，这是之前的行为）。

- 添加了在数据流中显示/隐藏引脚的功能，并将许多现有的混沌布料资产数据流节点设置为默认隐藏输入。

（见上文）添加了在数据流中显示/隐藏引脚的功能，并将许多现有的混沌布料资产数据流节点设置为默认隐藏输入。

（见上文）- 添加了对混沌布料资产的屈曲比的权重贴图支持。

添加了对混沌布料资产的屈曲比率的权重贴图支持。

- 对混沌布料资源选择节点和工具进行了改进，以将行为与权重贴图节点相匹配。

对混沌布料资源选择节点和工具进行了改进，以将行为与权重贴图节点相匹配。

### ClothAsset - 序列器/蓝图/CVAR

- 将骨架网格体组件的 ClothTeleportMode 属性公开给 Sequencer，并添加了一个新的 HardReset 模式来重建布料。将骨架网格体组件的 ClothTeleportMode 属性公开给 Sequencer，并添加了一个新的 HardReset 模式来重建布料。 - 使骨架网格体组件的 ClothCollisionSource 方法成为 BlueprintCallable。使骨架网格体组件的 ClothCollisionSource 方法成为 BlueprintCallable。 - 现在可以通过 UChaosClothAssetInteractor 从蓝图修改混沌布料组件模拟。现在可以通过 UChaosClothAssetInteractor 从蓝图修改混沌布料组件模拟。
