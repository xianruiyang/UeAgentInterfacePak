---
title: "在虚幻引擎中编写代码"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/writing-code-in-unreal-engine-for-unity-developers"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "为Unity开发者准备的虚幻引擎指南", "在虚幻引擎中编写代码"]
---

# 在虚幻引擎中编写代码

> 路径：虚幻引擎5.7文档 / 入门指南 / 为Unity开发者准备的虚幻引擎指南 / 在虚幻引擎中编写代码

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/writing-code-in-unreal-engine-for-unity-developers

## 设置

### C++

要在虚幻引擎中编写C++代码，需在Windows上下载[Visual Studio](https://visualstudio.microsoft.com/downloads/)，或在macOS上[安装Xcode](https://itunes.apple.com/us/app/xcode/id497799835?mt=12)。 当你创建新的C++项目（时，UE将自动创建Visual Studio项目文件。

从UE项目访问Visual Studio的方法有以下两种：

- 在**内容浏览器（Content Browser）**中，**双击**一个C++类，在Visual Studio中打开。
- 从主菜单转至**工具（Tools）****>****打开Visual Studio（Open Visual Studio）**。 仅当你的项目包含至少一个C++类时，才会显示此选项。

UE中有一点很不同：有时必须手动刷新Visual Studio项目文件（例如，下载新版UE后，或手动更改磁盘上的源文件位置时）。 要这样做，可以采用以下两种方法：

- 从虚幻引擎的主菜单**转至工具（Tools）>刷新Visual Studio项目（Refresh Visual Studio Project）**。
- **右键单击**项目目录中的**.uproject**文件，选择**生成Visual Studio项目文件（Generate Visual Studio project files）**。

> [!TIP]
> 如需更多信息，请参阅[开发设置](../../../cpp-programming/setting-up-your-development-environment-for-cplusplus/index.md)。

### 蓝图

如果编写蓝图脚本，则只需要UE。 虚幻编辑器已内置了所有功能。

## 编写事件函数

如果你用过MonoBehavior，应该熟悉`Start`、`Update`和`OnDestroy`等方法。 下面比较了Unity的行为与对应的UE：Actor和组件的行为。

在Unity中，某个基本组件的代码可能是这样：

C#

```
public class MyComponent : MonoBehaviour{	void Start() {}	void OnDestroy() {}	void Update() {}}
```

### AActor

在UE中，你可以在Actor本身上编写代码，而不是仅仅对新组件类型编码。

此外，Actor有类似于Unity的`Start`、`OnDestroy`和`Update`方法的方法。

#### C++

C++

```
UCLASS()
class AMyActor : public AActor
{
	GENERATED_BODY()

	// Called at start of game.
	void BeginPlay();

	// Called when destroyed.
	void EndPlay(const EEndPlayReason::Type EndPlayReason);
```

#### 蓝图

### UActorComponent

UE中的组件概念与MonoBehaviors类似，但包含不同的方法。

#### C++

C++

```
UCLASS()
class UMyComponent : public UActorComponent
{
	GENERATED_BODY()

	// Called after the owning Actor was created
	void InitializeComponent();

	// Called when the component or the owning Actor is being destroyed
	void UninitializeComponent();
```

#### 蓝图

## 其他说明

- 在虚幻引擎中，必须在子项的方法中显式调用父项的方法。 例如，在Unity的C#代码中，可能是`base.Update()`，但在虚幻引擎的C++代码中，你需要为Actor使用`Super::Tick()`，或为组件使用`Super::TickComponent()`。
- 在虚幻引擎的C++代码中，类有多种前缀，比如`U`用于`UObject`子类，`A`用于Actor子类。 如需更多信息，请参阅[代码规范](../../../cpp-programming/epic-cplusplus-coding-standard/index.md)。
- Gameplay编码示例参见[在虚幻引擎中创建Gameplay](../creating-gameplay-in-unreal-engine-for-unity-developers/index.md)。
