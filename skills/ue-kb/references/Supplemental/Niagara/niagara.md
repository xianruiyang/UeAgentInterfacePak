# Niagara 知识卡

## 适用范围

Niagara System、Emitter、Module、Renderer、Event、Collision、Parameter、Scalability、调试和性能验证。

## 补充专题

- [社区实践教程](community-practice/README.md)：Niagara Fluids、性能优化、Data Channels、HLSL/C++、Blueprint 集成、Cache/Sequencer、Unity 迁移和具体效果案例。
- [内置模块整理](niagara-detail/README.md)：UE 5.6 本地扫描得到的模块索引、默认参数、常用模块和模块分组说明。

## 官方资料入口

- 先读取 `official-sources.md` 中对应领域的 Epic 官方页面。
- 若主题和 UE 小版本相关，先确认项目使用的 UE 版本。

## 设计规则

- System 组合多个 Emitter，Emitter 管粒子生命周期和渲染链路。
- 模块顺序重要，初始化、力、求解、碰撞、事件不要乱放。
- 碰撞事件粒子要在事件 payload 位置生成。
- Stack issue、compile log、runtime probe 要一起看。
- Niagara Stack 不是参数表。命令成功、模块存在、参数字段存在，都不等于视觉语义已经生效。
- `InitializeParticle` 是初始化边界；它会设置或重置 Lifetime、Color、Size、Rotation、Mass、Position 以及 Sprite/Mesh/Ribbon 相关属性。要覆盖这些属性，模块顺序和覆盖时机必须明确。
- 很多模块由 mode / enum / static switch 决定活跃输入分支。写 `Module.Sprite Size`、Min/Max、Color、Position、Mesh Scale 等值前，先确认对应 `Sprite Size Mode`、Randomness Mode、Color Mode、Position Mode、Mesh Scale Mode 等控制项。
- 许多 Niagara 输入是“模式字段 + 模式专属属性组”，不是一个字段永远生效。例如 `Sprite Size Mode=Uniform` 时应检查 `Uniform Sprite Size`，`Sprite Size Mode=Non-Uniform` 时才检查 `Sprite Size`。写入非当前模式的属性组通常不会报错，但 UI 和运行时不会使用它。
- Renderer 是视觉语义的一部分。Sprite、Mesh、Ribbon 的选择要匹配效果目标；细长 Sprite 需要非均匀尺寸、`Particles.SpriteSize` binding 和速度对齐或等价朝向。

## 推荐执行步骤

1. 明确目标、所有权、生命周期和运行时边界。
2. 建最小闭环，不先堆复杂表现。
3. 接入资产、图或 C++ 结构。
4. 做编辑器检查、运行时验证和失败日志。
5. 记录性能、维护和回退风险。

## 验证清单

- 在编辑器中确认资产、组件、图节点或配置确实按预期生成。
- 对 Blueprint、Material、Niagara、AnimBlueprint、Sequence 等资产执行对应编译或诊断命令。
- 至少做一次运行时、预览或 headless 验证，避免只验证静态配置。
- 对 Niagara 额外检查关键 mode / enum / static switch 是否读回正确，目标参数是否位于活跃分支。
- 按当前 mode 校验对应的有效属性组；字段存在但不属于当前模式时，不得视为通过。
- 对事件链检查 payload 来源：位置、速度、法线等必须来自事件或明确的数据接口，不用固定点假冒。
- 记录失败步骤、日志路径、关键 warning 和剩余风险。

## 常见失败模式

- 把表现层当成权威逻辑层，导致多人、存档或回放状态不同步。
- 只完成编辑器配置，没有做运行时验证。
- 资产引用、插件依赖或加载顺序缺失。
- 过度依赖 Tick、轮询或一次性脚本，后续维护困难。
- 写入了非活跃分支的参数。例如 `Sprite Size Mode=Uniform` 时写入 `Module.Sprite Size=(X=...,Y=...)`，视觉仍会按 uniform 圆点显示。
- 在 Event Handler 中重复 `InitializeParticle`，覆盖 `ReceiveCollisionEvent` 写入的碰撞位置或速度。
- 只看最终帧粒子数，忽略短寿命事件粒子的采样峰值和预览世界碰撞上下文。
