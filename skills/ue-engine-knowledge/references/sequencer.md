# Sequencer 知识卡

## 适用范围

Level Sequence、MovieScene、Camera Cut、Subsequence、Actor Binding、Spawnable/Possessable、UMG Animation 和运行时演出控制。

## 官方资料入口

- 先读取 `official-sources.md` 中对应领域的 Epic 官方页面。
- 若主题和 UE 小版本相关，先确认项目使用的 UE 版本。

## 设计规则

- Sequencer 负责演出时序，不独自拥有 Gameplay 结局状态。
- Spawnable 由 Sequence 生成，Possessable 绑定关卡对象。
- Camera Cut、Subsequence 和 Outliner folder 要清晰组织。
- 运行时播放、跳过、回滚和结束状态由 Gameplay 层接管。

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
