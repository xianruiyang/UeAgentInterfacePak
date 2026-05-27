---
title: "添加事件处理器组"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/add-event-handler-group-reference-for-niagara-effects-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建视觉效果", "Niagara参考页面", "Niagara系统和发射器模块参考", "添加事件处理器组"]
---

# 添加事件处理器组

> 路径：虚幻引擎5.7文档 / 创建视觉效果 / Niagara参考页面 / Niagara系统和发射器模块参考 / 添加事件处理器组

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/add-event-handler-group-reference-for-niagara-effects-in-unreal-engine

**事件处理器（Event Handler）** 可确定发射器对传入事件的响应方式。可为每个事件创建 **事件处理器属性（Event Handler Properties）** 项和 **接收事件（Receive Event）** 项。每个发射器可有多个事件。

> [!NOTE]
> 事件目前不适用于GPU模拟。事件仅可结合CPU模拟使用。

要使用事件处理器（Event Handler），首先需要在生成事件发射器的粒子更新（Particle Update）组中放置[**事件模块**](../particle-update-group-reference-for-niagara-effects/index.md#%E4%BA%8B%E4%BB%B6%E6%A8%A1%E5%9D%97)。举例而言，若要使发射器B中的粒子跟随发射器A中的粒子，则可以在发射器A的粒子更新（Particle Update）组中放置 **生成位置事件（Generate Location Event）** 模块。然后需要添加 **事件处理器（Event Handler）** 至发射器B，结合 **接收位置事件（Receive Location Event）** 项目监听该位置事件。

> [!NOTE]
> 要正确使用事件，必须在正在生成事件的发射器的 **发射器属性（Emitter Properties）** 项中启用 **需要持久ID（Requires Persistent IDs）**。

## 事件处理器属性

| 参数 | 说明 |
| --- | --- |
| **源（Source）** | 点击下拉列表可选择源发射器和事件。 |
| **执行模式（Execution Mode）** | 此参数可控制运行事件脚本的粒子。可用选项有： **生成的粒子（Spawned Particles）**：事件脚本仅在响应发射器中当前事件时生成的粒子上运行。 **每个粒子（Every Particle）**：事件脚本在发射器中的每个现有粒子上运行。 请谨慎使用此模式，因为它可能导致大量的运行时工作。 |
| **每帧最大事件数（Max Events Per Frame）** | 此参数设置此事件处理器消耗的事件数。如果生成事件数量大于此值，则忽略额外事件。 |
| **生成数量（Spawn Number）** | 此参数可控制粒子是否因处理此事件而生成。如果选中 **随机生成数（Random Spawn Number）**，则此参数代表生成的最大粒子数。 |
| **最小生成数（Min Spawn Number）** | 如果选中 **随机生成数（Random Spawn Number）**，则此参数表示生成的最小粒子数。 |
| **随机生成数（Random Spawn Number）** | 选中此框可随机生成因处理事件而生成的粒子数。 |

## 接收事件模块

| 模块名称 | 说明 |
| --- | --- |
| **接收碰撞事件（Receive Collision Event）** | 侦听生成的碰撞事件（由粒子更新（Particle Update）组中的 **生成碰撞事件（Generate Collision Event）** 模块创建）时需要该模块。另外，可启用继承碰撞速度范围（Inherited Collision Velocity Scale）来确定粒子继承的父速度大小。 |
| **接收消亡事件（Receive Death Event）** | 侦听生成消亡事件（由粒子更新（Particle Update）组中的 **生成消亡事件（Generate Death Event）** 模块创建）时需要该模块。另外，可启用继承速度范围（Inherited Velocity Scale）来确定粒子继承的父速度大小。 |
| 接收位置事件（Receive Location Event） | 侦听生成的位置事件（由粒子更新（Particle Update）组中的 **生成位置事件（Generate Location Event）** 模块创建）时需要该模块。接收位置事件（Receive Location Event）拥有以下设置： **继承速度（Inherited Velocity）**：此设置可确定粒子继承的父速度大小。 **使用加速度（Use Acceleration）**：根据传入事件的加速度推断，确定新位置。 **继承父规格化年龄（Inherit Parent Normalized Age）**：此设置将发送接收粒子生命周期或父粒子生命周期的最大值。 **生成数量（Spawn Count）**：此设置指出因事件而生成的粒子数量。 |
