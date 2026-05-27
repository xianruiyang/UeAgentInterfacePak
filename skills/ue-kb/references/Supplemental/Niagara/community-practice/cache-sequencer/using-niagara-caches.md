# 使用 Niagara 缓存

- 来源: https://dev.epicgames.com/community/learning/tutorials/oDjx/unreal-engine-using-niagara-caches
- 原文标题: Using Niagara Caches

## 利用尼亚加拉缓存

## Load Plugins

和 Niagara Simulation Caching 都有各自的插件。您需要先加载这些插件才能开始。

创建一个系统

使用 Niagara Fluids 插件自带的模板之一创建 Niagara 系统。本教程将从 3D 气体爆炸模板开始。

创建模拟缓存资源

在内容浏览器中，右键单击并创建一个 Niagara 模拟缓存资源。这是用于存放模拟缓存数据的容器。

创建缓存级别序列

我们将使用 Sequencer 来缓存模拟数据。NiagaraSimCaching 插件会在 Sequencer 中添加一个新的 Niagara Cache 轨道，该轨道可从您的系统中访问。

在内容浏览器中，创建一个新的关卡序列。

打开它，然后拖入对你的 Niagara 系统的引用。

（可选）右键单击系统 Actor 并将其转换为可生成对象。这样就无需将关卡与关卡序列资源一起保存。如果以后需要重新缓存，只需打开关卡序列，所需的 Actor 就会自动生成到当前关卡中。

从 Actor 添加对 Niagara 组件的引用。

为组件添加生命周期轨道，并将模式设置为“期望年龄”。这样可以更轻松地预览模拟结果。

向组件添加 Niagara Cache 轨道。该轨道负责处理所有缓存操作。

此时缓存尼亚加拉系统完全没问题。缓存的数据将存储在关卡序列 Actor 中。这对于数据量小且不会在其他镜头中使用的粒子系统来说非常合适。

在这种情况下，我们将把缓存数据的保存位置更改为它自己的 Niagara Simulation Cache 资源。

在音序器中右键单击 Niagara Cache 曲目名称，然后导航到“编辑部分”菜单。

将 Sim Cache 引用更改为指向您的新 Niagara Simulation Cache 资源。

按下曲目名称右侧的红色录制按钮，即可开始缓存过程。

系统缓存现在保存在 Niagara Simulation Cache 资源中。您可以通过双击来查看任何 Niagara Simulation Cache 资源！

## 在镜头中使用缓存

要在不同的关卡序列中使用缓存，其设置与最初缓存尼亚加拉系统的设置非常相似。唯一的区别在于，您无需记录缓存，而是让缓存轨道控制尼亚加拉系统并充当玩家角色。

务必记录每个 Niagara 模拟缓存对应的 Niagara 系统。您只能通过最初生成该缓存的 Niagara 系统来回放它。请将缓存资源保存在同一个文件夹中，以便维护系统、缓存和关卡序列的完整设置。

将你的尼亚加拉系统实例放入关卡中。确保它与用于创建缓存的系统是同一个系统。

将您的 Niagara 系统参考文件拖入 Sequencer 中。

将 Niagara 组件轨道添加到 Actor 引用中。

向组件添加 Niagara Cache 轨道。

右键单击尼亚加拉宝藏路线名称，然后导航至“编辑章节”菜单。

将 Sim Cache 引用更改为您预先录制的 Niagara Simulation Cache 资源。

藏宝点轨迹上现在会出现一个蓝色条。该条标记将显示在藏宝点最初生成时的时间点。

将缓存轨道移动到当前关卡序列中的所需时间点。

您可以根据需要更改缓存轨道的长度来加快或减慢播放速度。请务必检查轨道设置中的“首帧起始偏移量”是否保持为零，以避免播放跳帧。

您可以多次使用同一个缓存。只需设置多个独立的 Niagara 系统来读取同一个 Niagara 仿真缓存资源即可。每个实例在时间和空间上都可以有偏移。

## 尼亚加拉流体学习路径

## 尼亚加拉线性内容
