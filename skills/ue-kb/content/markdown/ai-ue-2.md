# 使用大规模 AI 设计可扩展人群：综合 UE 指南（续 2）

# 使用大规模 AI 设计可扩展人群：综合 UE 指南（续 2）

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide
- 原始文件：unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide.origin.md
- 分段：第 2/3 段

## 中文整理

### 所需的基础片段

第一步是添加分类片段并包含几个基本片段： - 大量 Actor 片段 如果没有此片段，实体将不会维护对 Actor 的有效内存引用。结果，引擎会遇到 nullptr（空指针）错误并崩溃。大量 Actor 片段 如果没有此片段，实体将不会维护对 Actor 的有效内存引用。结果，引擎会遇到 nullptr（空指针）错误并崩溃。 - 变换片段为实体提供移动、与处理器同步以及与其他片段和特征交互所需的变换数据。变换片段 为实体提供移动、与处理器同步以及与其他片段和特征交互所需的变换数据。 - Agent Radius Fragment 为实体分配物理半径，在导航计算期间使用。需要注意的是，Fragment 与 Traits 一样，包含可配置参数，这些参数隐藏在编辑器中的可扩展子部分中。 Agent Radius Fragment 为实体分配物理半径，在导航计算期间使用。需要注意的是，Fragment 与 Traits 一样，包含可配置参数，这些参数隐藏在编辑器中的可扩展子部分中。

![教程图片](assets/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide/image-09.jpg)

### 所需片段

如果没有这些片段，编辑器将产生多个错误（仅在......期间可见）

### 添加特征

下一步是添加 Trait...

![教程图片](assets/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide/image-10.jpg)

### 区域图

### 大量产卵者

### 状态树

### 移动/回避

### StateTree / Spawner 改进 #2

### 区域图干扰

### 智能对象

### 使用智能对象

### 质量 + 导航网格 + EQS

### 与 ZoneGraph 的主要区别

### 动画转纹理

### 选项 1（可选）

### 测试

### 质量和影片渲染队列

### 结论

