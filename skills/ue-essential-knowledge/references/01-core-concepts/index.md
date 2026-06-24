# 核心概念

## 覆盖范围

- UObject、UClass、反射系统与属性系统。
- Actor、Component、World、Level、Subsystem 的基本关系。
- Editor-time 与 runtime 的状态差异。
- Package、Asset、CDO、Blueprint Generated Class 的语义。
- Transform、坐标空间、Tick、生命周期与依赖关系。

## 阅读时机

- 用户要求解释 UE 机制或设计方案。
- 任务中出现对象身份、生命周期、默认值、继承、类生成、运行时与编辑器状态混淆。
- 需要判断某个字段是资产数据、编辑器缓存、运行时状态还是派生结果。

## 后续填充位置

- UObject 与资产身份的最小模型。
- Actor/Component 生命周期常见误区。
- CDO、Blueprint class、实例默认值的区别。
- Editor-only 数据与 cooked/runtime 数据边界。
