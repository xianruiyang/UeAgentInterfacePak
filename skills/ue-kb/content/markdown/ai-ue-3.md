# 使用大规模 AI 设计可扩展人群：综合 UE 指南（续 3）

# 使用大规模 AI 设计可扩展人群：综合 UE 指南（续 3）

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide
- 原始文件：unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide.origin.md
- 分段：第 3/3 段

## 中文整理

### 概括

## 相关链接

- [Introduction](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#introduction)
- [Practical Research Objectives](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#practicalresearchobjectives)
- [Mass AI System Overview](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#massaisystemoverview)
- [Simplified Overview](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#simplifiedoverview)
- [ECS and Data-Oriented Design](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#ecsanddata-orienteddesign)
- [Fragments and Entities](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#fragmentsandentities)
- [Archetypes](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#archetypes)
- [Chunks and Memory Layout](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#chunksandmemorylayout)
- [Processors and Entity Queries](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#processorsandentityqueries)
- [Design Implications and Traits](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#designimplicationsandtraits)
- [Traits](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#traits)
- [MassEntity, Mass Gameplay, and Crowd Systems](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#massentity,massgameplay,andcrowdsystems)
- [Navigation and Crowd Movement](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#navigationandcrowdmovement)
- [Geometry Optimization and LOD Strategy](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#geometryoptimizationandlodstrategy)
- [Mass Avoidance](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#massavoidance)
- [Setup Process](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#setupprocess)
- [Getting Started](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#gettingstarted)
- [Plugin Notes](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#pluginnotes)
- [Level Detail for Stress Testing](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#leveldetailforstresstesting)
- [Data Assets](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#dataassets)
- [Mass Entity Config Asset Overview](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#massentityconfigassetoverview)
- [Required Base Fragments](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#requiredbasefragments)
- [Required Fragments](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#requiredfragments)
- [Adding Traits](https://dev.epicgames.com/community/learning/tutorials/zqZZ/unreal-engine-epic-for-indies-designing-scalable-crowds-with-mass-ai-a-comprehensive-ue-guide#addingtraits)

