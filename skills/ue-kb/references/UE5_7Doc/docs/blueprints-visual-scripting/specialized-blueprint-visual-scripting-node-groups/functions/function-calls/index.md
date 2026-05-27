---
title: "函数调用"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/function-calls-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "专用蓝图节点组", "函数", "函数调用"]
---

# 函数调用

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 专用蓝图节点组 / 函数 / 函数调用

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/function-calls-in-unreal-engine

**Function Calls（函数调用）**是可以蓝图中形成的操作，该蓝图同属于目标Actor或对象的函数相对应 。对于关卡蓝图来说，相关actor很多时候都是 关卡蓝图本身。函数调用显示为一个盒形，具有显示了函数名称的标题。 不同类型的函数调用具有不同颜色的标题。

## 自身

**Self Function Calls（自身函数调用）** 是属于蓝图本身的函数， 通过在该蓝图继承的类或父类中声明。

## 其他

**Other Function Calls（其他函数调用）** 是属于除了该蓝图之外的其他对象或Actor的函数。例如， 该蓝图可能有一个StaticMeshComponent，该StaticMeshComponent可以通过SetStaticMesh函数调用修改它的网格物体。 由于这个函数属于StaticMeshComponent 而不属于蓝图，所以它是Other Function Call（其他函数调用）。

## 纯函数调用

**Pure Function Calls（纯函数调用）** 是可以执行的特殊动作，它不会直接影响世界或者世界中的对象 。这些函数一般执行类似于这样的事情: 输出一个属性值、数学运算操作(比如两个值间的加减乘除等)， 所产生的结果不会对任何事物造成影响。 只有将该结果进行赋值或使用该结果，才能对世界产生影响。

| Pure Function Call Node | 数学纯函数调用节点 |
| --- | --- |
| 标准 | 压缩 |
