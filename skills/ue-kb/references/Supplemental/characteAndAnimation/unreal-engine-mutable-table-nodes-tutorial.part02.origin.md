# 可变：表节点教程（续 2）

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/nzkW/unreal-engine-mutable-table-nodes-tutorial
- 原始文件：unreal-engine-mutable-table-nodes-tutorial.origin.md
- 分段：第 2/2 段

## 中文整理

### 使用材质实例作为预设

我们可以使用材质实例来清理一下图形并更好地控制变化。为此，我们将创建一个新的结构（将其命名为 F_Table_Materials）和一个新的数据表（将其命名为 DT_Table_Materials）。然后，在结构中我们将创建一个材质实例变量（软对象引用）。将其命名为材料。然而，在选择材质实例之前，我们必须创建它们。我们将从材质 MI_Boot 创建三个材质实例：MI_Boot_Pink、MI_Boot_Red 和 MI_Boot_Yellow。在每个实例中修改参数以匹配上一个示例中的值。现在您有了不同的材质实例，您必须为我们的结构选择一个默认值（使用 MI_Boot_Red）：然后，填写数据表行值。全部设置完毕后，在表属性中选择新的数据表 DT_Table_Materials 并刷新表节点。将出现一个材料图钉。将此材料引脚链接到网格截面节点的表材料引脚并编译。该行的所有实例都应该是同一材质的实例。如果我们需要使用具有不同父级的实例，则必须选中选项禁用表材料父级检查（编译选项部分）。如果选中该选项，则必须确保要修改的材质参数在所有父材质中具有完全相同的名称。表节点的参考材质必须与链接材质节点中设置的材质具有相同的父级。

### 结果

编译，现在您可以根据表中定义的材质实例选择不同的鞋子类型以及鞋子细节的颜色。

### 合并数据表

您的团队中可能需要多个成员同时处理数据表。这可能会导致与被锁定的资产发生冲突，并且除使用该资产的用户外，其他人无法使用该资产。在这种情况下，拥有多个数据表更为合适。这是一个可以在节点属性的表数据收集模式中使用结构+资产注册表来解决的示例。您可以定义一种要使用的结构和尽可能多的数据表...

### 结果

### 动画实例和动画插槽

## 相关链接

- [Basic Concepts](https://github.com/anticto/Mutable-Documentation/wiki/Basic-Concepts)
- [Mutable Sample](https://www.fab.com/listings/209e82f6-ad40-4253-b565-d2f65b12efe7)
- [Overview](https://dev.epicgames.com/community/learning/tutorials/nzkW/unreal-engine-mutable-table-nodes-tutorial#overview)
- [Required Assets](https://dev.epicgames.com/community/learning/tutorials/nzkW/unreal-engine-mutable-table-nodes-tutorial#requiredassets)
- [Mesh Variation Example](https://dev.epicgames.com/community/learning/tutorials/nzkW/unreal-engine-mutable-table-nodes-tutorial#meshvariationexample)
- [Steps](https://dev.epicgames.com/community/learning/tutorials/nzkW/unreal-engine-mutable-table-nodes-tutorial#steps)
- [Creating a Structure](https://dev.epicgames.com/community/learning/tutorials/nzkW/unreal-engine-mutable-table-nodes-tutorial#creatingastructure)
- [Creating a Data Table](https://dev.epicgames.com/community/learning/tutorials/nzkW/unreal-engine-mutable-table-nodes-tutorial#creatingadatatable)
- [Adding a Table Node](https://dev.epicgames.com/community/learning/tutorials/nzkW/unreal-engine-mutable-table-nodes-tutorial#addingatablenode)
- [Results](https://dev.epicgames.com/community/learning/tutorials/nzkW/unreal-engine-mutable-table-nodes-tutorial#results)
- [Colors, Textures and Float Variations](https://dev.epicgames.com/community/learning/tutorials/nzkW/unreal-engine-mutable-table-nodes-tutorial#colors,texturesandfloatvariations)
- [Results](https://dev.epicgames.com/community/learning/tutorials/nzkW/unreal-engine-mutable-table-nodes-tutorial#results-2)
- [Using Material Instances as Presets](https://dev.epicgames.com/community/learning/tutorials/nzkW/unreal-engine-mutable-table-nodes-tutorial#usingmaterialinstancesaspresets)
- [Results](https://dev.epicgames.com/community/learning/tutorials/nzkW/unreal-engine-mutable-table-nodes-tutorial#results-3)
- [Merging Data Tables](https://dev.epicgames.com/community/learning/tutorials/nzkW/unreal-engine-mutable-table-nodes-tutorial#mergingdatatables)
- [Results](https://dev.epicgames.com/community/learning/tutorials/nzkW/unreal-engine-mutable-table-nodes-tutorial#results-4)
- [Anim Instances & Anim Slots](https://dev.epicgames.com/community/learning/tutorials/nzkW/unreal-engine-mutable-table-nodes-tutorial#animinstances&animslots)
