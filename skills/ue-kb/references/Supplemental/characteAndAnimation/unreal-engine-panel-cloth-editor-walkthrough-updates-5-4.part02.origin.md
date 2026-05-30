# 面板布 - 编辑器演练和更新 (5.4)（续 2）

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4
- 原始文件：unreal-engine-panel-cloth-editor-walkthrough-updates-5-4.origin.md
- 分段：第 2/2 段

## 中文整理

### 绘制最大距离

图表中的下一步是使用 AddWeight 节点绘制最大距离。正如数据流中的评论所述，MaxDistance 告知模拟布料可以远离其动画蒙皮位置多远。对于实时布料来说，拥有“选择加入”模拟系统以及用户限制哪些顶点处于活动状态的能力非常重要。零绘制表示没有移动（运动学），值为 1 表示完全移动，这些加权值将映射到位于 MaxDistance 权重贴图节点之后的 SimulationMaxDistanceConfig 节点的 Lo/Hi 值。这是另一个需要用户输入的节点。这张绘制的地图将决定模拟的距离有多远...

### 布料绘画工具菜单

### 模拟最大距离配置节点

### 模拟配置节点

### 模拟拉伸配置

### 模拟弯曲配置

### 模拟质量配置

### 模拟空气动力学配置

### 模拟阻尼配置

### 模拟LongRangeAttachmentConfig

### 模拟求解器配置

### 模拟SelfCollisionSpheresConfig

### 设置物理资源

### 模拟碰撞配置

### 飞行员

### 重新网格化节点

### 权重映射到选择

### ProxyDeformer 节点

### ClothAssetTerminal节点

### 预览场景详细信息选项卡

### 备用碰撞工作流程 - 不在默认数据流中

### 分行集合

### 物理资产的可选工作流程 - 运动碰撞器

### 多件衣服的分层

### 模拟自碰撞配置节点

### 连接

### 层和运动碰撞

### 5.4 面板布料编辑器更新

### 绘画工具和选择更新

### 工具画笔模式的热键

### 在渲染网格上绘制权重贴图

### 反转权重（绘制）贴图

### 乘以权重（绘制）贴图

### HideTriangles 画笔可隐藏鼠标下方的三角形

### 选择网格元素

### 可视化和选择的更新

### 将显示颜色图从黑/白切换为白/红

### 用于显示/隐藏图案的图案可见性 UI 面板

### 构造视口调试可视化

### 面板视口的网格统计显示

### 生活质量改善

### Sim 可视化已移至选项卡浏览器

### 布料资产导入节点 - 重新导入资产

### 改良布料资源

### 刷新布料终端节点上的资产

### 布料资产考虑构建平台

### 预览动画

### 预览窗口中添加了相机速度设置

### 链接

## 相关链接

- [Chaos Panel Cloth - Editor Walkthrough and Updates (5.4)](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#chaospanelcloth-editorwalkthroughandupdates(54))
- [Introduction](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#introduction)
- [文档与教程](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#%E6%96%87%E6%A1%A3%E4%B8%8E%E6%95%99%E7%A8%8B)
- [Updated Features for 5.4](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#updatedfeaturesfor54)
- [What's Missing](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#what'smissing)
- [ClothAsset Template Walkthrough](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#clothassettemplatewalkthrough)
- [Create USD - Export from Marvelous Designer](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#createusd-exportfrommarvelousdesigner)
- [Fix Unsupported Panel Items](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#fixunsupportedpanelitems)
- [Marvelous Designer Export Settings](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#marvelousdesignerexportsettings)
- [Cloth Collision Interaction](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#clothcollisioninteraction)
- [Mesh Resolution](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#meshresolution)
- [USD Export](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#usdexport)
- [Unreal Engine - Load Plugins](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#unrealengine-loadplugins)
- [Unreal Engine - Create a Chaos ClothAsset](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#unrealengine-createachaosclothasset)
- [Dataflow Node Graph Preset](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#dataflownodegraphpreset)
- [User Input Needed](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#userinputneeded)
- [Unreal Engine - Set your USD Source File](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#unrealengine-setyourusdsourcefile)
- [文档与教程](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#%E6%96%87%E6%A1%A3%E4%B8%8E%E6%95%99%E7%A8%8B-2)
- [Transform Positions Node](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#transformpositionsnode)
- [Set a Skeletal Mesh](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#setaskeletalmesh)
- [TransferSkinWeights Node](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#transferskinweightsnode)
- [文档与教程](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#%E6%96%87%E6%A1%A3%E4%B8%8E%E6%95%99%E7%A8%8B-3)
- [New - Skin Weight Transfer Updates](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#new-skinweighttransferupdates)
- [Paint the MaxDistance](https://dev.epicgames.com/community/learning/tutorials/Mpze/unreal-engine-panel-cloth-editor-walkthrough-updates-5-4#paintthemaxdistance)
