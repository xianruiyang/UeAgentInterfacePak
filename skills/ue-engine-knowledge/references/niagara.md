# Niagara 知识卡

## 适用范围

Niagara System、Emitter、Module、Renderer、Event、Collision、Parameter、Scalability、调试和性能验证。

## 官方资料入口

- 先读取 `official-sources.md` 中对应领域的 Epic 官方页面。
- 若主题和 UE 小版本相关，先确认项目使用的 UE 版本。

## 设计规则

- System 组合多个 Emitter，Emitter 管粒子生命周期和渲染链路。
- 模块顺序重要，初始化、力、求解、碰撞、事件不要乱放。
- 碰撞事件粒子要在事件 payload 位置生成。
- Stack issue、compile log、runtime probe 要一起看。

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
- 记录失败步骤、日志路径、关键 warning 和剩余风险。

## 常见失败模式

- 把表现层当成权威逻辑层，导致多人、存档或回放状态不同步。
- 只完成编辑器配置，没有做运行时验证。
- 资产引用、插件依赖或加载顺序缺失。
- 过度依赖 Tick、轮询或一次性脚本，后续维护困难。
