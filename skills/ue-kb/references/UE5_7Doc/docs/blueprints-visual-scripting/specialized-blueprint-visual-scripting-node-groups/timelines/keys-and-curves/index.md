---
title: "关键帧和曲线"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/keys-and-curves-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "专用蓝图节点组", "时间轴", "关键帧和曲线"]
---

# 关键帧和曲线

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 专用蓝图节点组 / 时间轴 / 关键帧和曲线

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/keys-and-curves-in-unreal-engine

编程语言

C++

从下拉菜单中选择一个选项以查看与之相关的内容

**曲线（Curve）**（**[UCurveBase](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Curves/UCurveBase?application_version=5.5)**）定义了要在给定范围内求值的内插点的轨道。 曲线可以是**向量**、**浮点**以及**颜色**。 所有轨道都可以有任意数量的**关键点**，用于定义时间或值。 数据可以内插到这些关键帧之间，以计算时间轴中任何点的值。

## 使用关键帧和曲线

在本例中，你将创建一个**[UCurveFloat](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Curves/UCurveFloat?application_version=5.5)**，它会定义要在给定范围内求值的内插浮点的曲线。

要创建`UCurveFloat`并将其实例化为**时间轴组件**，请执行以下步骤：

1. 找到**内容浏览器**，点击**C++ Classes**文件夹，然后点击**添加（+）（Add (+)）**按钮并选择**新建C++类（New C++ Class）**。
2. 选择**Actor**作为**父类**。

   点击查看大图。
3. 将创建的Actor命名为**ExampleTimelineComponent**。

   点击查看大图。
4. 创建新的Actor时，**Visual Studio**会自动打开`ExampleTimelineComponent.h`和`ExampleTimelineComponent.cpp`文件。 找到`ExampleTimelineComponent.h`文件并将以下内容添加到`#include`分段中：

   ExampleTimelineComponent.h

   C++

   ```
   #include "Components/TimelineComponent.h"
   ```
5. 接下来，在`ExampleTimelineComponent`类定义中添加以下代码：

   ExampleTimelineComponent.h

   C++

   ```
   protected:          UPROPERTY(EditAnywhere, BlueprintReadWrite)         UTimelineComponent* ExampleTimelineComp;      public:          UPROPERTY(EditAnywhere)         UCurveFloat* ExampleTimelineCurve;
   ```
6. 编译你的代码。
7. 找到**内容浏览器**，选择**添加（+）（Add (+)）> 杂项（Miscellaneous）> 曲线（Curve）**。
8. 选择**CurveFloat**并将其命名为**ExampleFloatTrack**。
9. 在**内容浏览器**中，找到包含你的**ExampleTimelineComponent**类的文件夹，右键点击并选择**基于ExampleTimelineComponent创建蓝图类（Create Blueprint Class based on ExampleTimelineComponent）**。 将其命名为**BP_ExampleTimelineComponent**。
10. 打开**BP_ExampleTimelineComponent**类的默认值，找到**细节（Detail）**面板并分配带有**ExampleFloatTrack**的**示例时间轴曲线**。
11. 在内容浏览器中，双击你的**浮点轨道示例**，并打开**时间轴编辑器**。

## 添加关键帧

添加关键点的方式是按下**Enter**键，或右键点击灰色条并从上下文菜单选择操作**添加关键点（Add Key）**。

## 编辑关键帧

要设置关键帧的时间和值，可点击该关键帧，在靠近轨道顶部的时间和值字段中输入值。

## 删除关键帧

若要删除所选关键点，按键盘上的**Delete**键，或右键点击你想删除的关键点，并从上下文菜单中选择**删除（Delete）**操作即可。

## 移动关键帧

要将关键帧沿着时间轴移动，选择该关键帧并拖动它。 若要选择多个关键点，请使用**Ctrl**键。 水平方向拖动可以更新该关键点的**时间（Time）**值，垂直拖动则更新**值（Value）**。

## 关键帧插值

右键点击关键帧，将显示上下文菜单，用于选择所选关键帧的插值类型。

关键帧插值仅影响内插的目标关键帧与其下一个关键帧之间的曲线。 例如，将所有其他关键点设为**线性（Linear）**，中央关键点设为**立方体自动（Cubic-Auto）**，则轨道将类似于下图。

可用插值类型有：

- **自动（Auto）**
- **用户（User）**
- **断裂（Break）**
- **线性（Linear）**
- **常量（Constant）**
