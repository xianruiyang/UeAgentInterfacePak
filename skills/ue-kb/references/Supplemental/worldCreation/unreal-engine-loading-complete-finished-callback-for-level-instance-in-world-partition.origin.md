# 为世界分区中的关卡实例加载完整/完成的回调

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/z0dZ/unreal-engine-loading-complete-finished-callback-for-level-instance-in-world-partition

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2856 字符。

## 摘要

通过挂钩回调函数来跟踪关卡实例何时加载到世界分区中。

## 中文整理

### 概览

您是否尝试过使用世界分区并需要加载关卡实例，但一直在绞尽脑汁试图跟踪它何时完全加载并显示？ **问题** 这看起来应该很简单，尽管 DataLayerManager 只提供名为“*OnDataLayerInstanceRuntimeStateChanged*”的委托，它只告诉您数据层何时更改状态，而不是当所有参与者完成加载和激活时。这给我们带来了一个问题，因为我需要知道包含关卡实例的数据层何时完成加载，然后才能打开门户以渲染到另一侧。 **解决方案** 我无法找到一种方法来跟踪数据层何时完全加载，但是，我能够找到一种方法来跟踪关卡实例何时加载，这对我们来说非常好，因为我们主要在关卡实例中创建不同的门户目的地以进行模块化世界创建。首先，我们需要在头文件中添加一个与我们要获取回调的委托相匹配的函数： void MyClass::OnLevelStreamingStateChanged(UWorld* InWorld, const ULevelStreaming* InStreamingLevel, ULevel* LevelIfLoaded, ELevelStreamingState PreviousState, ELevelStreamingState NewState) 然后，在 CPP 文件中的某个位置，我们需要挂钩我们想要的委托，如下所示： FLevelStreamingDelegates::OnLevelStreamingStateChanged.AddUObject(this, &MyClass::OnLevelStreamingStateChanged);请务必在 EndPlay 中取消该委托的挂钩，以避免任何错误。现在，我们可以定义 OnLevelStreamingStateChanged 函数来过滤我们要查找的内容。基本上，我们需要存储对正在等待加载的关卡实例的引用，然后检查传入的加载流关卡，首先查看它是否是关卡实例，其次查看它是否与我们跟踪的关卡实例名称匹配。

```cpp
void MyClass::OnLevelStreamingStateChanged(UWorld* InWorld, const ULevelStreaming* InStreamingLevel, ULevel* LevelIfLoaded, ELevelStreamingState PreviousState, ELevelStreamingState NewState)
{	
	if(NewState != PreviousState && NewState != ELevelStreamingState::LoadedVisible) return;

	//make sure we are dealing with a Level Instance
	const ULevelStreamingLevelInstance* LevelInstance = (ULevelStreamingLevelInstance*)Cast<ULevelStreamingLevelInstance>(InStreamingLevel);
	if(LevelInstance == nullptr) return;

	if(LevelInstance->GetWorldAssetPackageName().Contains(MyLevelInstanceName))
	{
```

显然，您需要根据自己的需要修改它，但它概述了基础知识:)我希望这会有所帮助！

