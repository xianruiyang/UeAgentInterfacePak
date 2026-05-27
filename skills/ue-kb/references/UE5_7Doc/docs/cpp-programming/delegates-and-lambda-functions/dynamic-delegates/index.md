---
title: "动态委托"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/dynamic-delegates-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "委托", "动态委托"]
---

# 动态委托

> 路径：虚幻引擎5.7文档 / 用C++编程 / 委托 / 动态委托

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/dynamic-delegates-in-unreal-engine

动态委托可序列化，其函数可按命名查找，但其执行速度比常规委托慢。

## 声明动态委托

动态委托的声明方式与[声明标准委托](../index.md)相同，只是前者使用动态委托专属的宏变体。

| 声明宏 | 描述 |
| --- | --- |
| `DECLARE_DYNAMIC_DELEGATE[_RetVal, ...]\\( DelegateName \\)` | 创建一个动态委托。 |
| `DECLARE_DYNAMIC_MULTICAST_DELEGATE[_RetVal, ...]\\( DelegateName \\)` | 创建一个动态组播委托。 |

## 动态委托绑定

| 辅助宏 | 说明 |
| --- | --- |
| `BindDynamic( UserObject, FuncName )` | 用于在动态委托上调用BindDynamic()的辅助宏。自动生成函数命名字符串。 |
| `AddDynamic( UserObject, FuncName )` | 用于在动态组播委托上调用AddDynamic()的辅助宏。自动生成函数命名字符串。 |
| `RemoveDynamic( UserObject, FuncName )` | 用于在动态组播委托上调用RemoveDynamic()的辅助宏。自动生成函数命名字符串。 |

## 执行动态委托

通过调用委托的 `Execute()` 函数执行绑定到委托的函数。执行前须检查委托是否已绑定。 此操作是为了使代码更安全，因为有时委托可能含有未初始化且被后续访问的返回值和输出参数。 执行未绑定的委托在某些情况下确实可能导致内存混乱。可调用 `IsBound()` 检查是否可安全执行委托。 同时，对于无返回值的委托，可调用 `ExecuteIfBound()`，但需注意输出参数可能未初始化。

| 执行函数 | 描述 |
| --- | --- |
| `Execute` | 不检查其绑定情况即执行一个委托 |
| `ExecuteIfBound` | 检查一个委托是否已绑定，如是，则调用Execute |
| `IsBound` | 检查一个委托是否已绑定，经常出现在包含 `Execute` 调用的代码前 |

参见[多播委托](../multicast-delegates/index.md)，了解执行多投射委托的相关细节。
