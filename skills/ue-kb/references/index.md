# UE KB Reference 入口

此目录只放使用说明、主题索引和文档入口。大规模官方正文放在 `UE5_7Doc/`，独立补充内容放在 `Supplemental/`，派生索引放在 skill 根目录的 `content/`、`chunks/`、`indexes/` 和 `state/`。

## 使用入口

- [查询指南](guides/querying.md)：Hybrid-first 检索、keyword 降级、fetch 证据要求。
- [Standalone 指南](guides/standalone.md)：kbCli、Qdrant、vector service 或索引不可用时的只读查阅方式。
- [维护指南](guides/maintenance.md)：重建来源、重新入库、验证和 package 校验。

## 定位入口

- [主题地图](maps/topic-map.md)：常见 UE 主题、推荐关键词和对应真实文档路径。
- [来源结构](maps/source-layout.md)：顶层目录、页面数量和 landing/content 目录对应关系。
- [Markdown 文档集入口](UE5_7Doc/index.md)：UE 5.7 正文文档总览。
- [Niagara 补充知识卡](Supplemental/Niagara/niagara.md)：Niagara 制作、模块、参数和验证规则补充内容。
- [Niagara 社区实践专题](Supplemental/Niagara/community-practice/README.md)：Niagara Fluids、性能、Data Channels、HLSL/C++、Blueprint 集成、Cache/Sequencer、迁移和具体效果案例。
- [Animation 补充知识卡](Supplemental/Animation/animation-ik.md)：Animation / IK / Control Rig 接入策略补充内容。
- [PCG 补充专题](Supplemental/PCG/README.md)：PCG Blueprint Element、Compute Graph、Actor Tag、BiomeGenerator、样条房间、PVE 与技术美术实践补充内容。
- [Level Design 补充文档](Supplemental/LevelDesign/README.md)：白盒、Blockout、关卡结构、自动化搭建和质量审查规则。
- [Rendering 补充专题](Supplemental/Rendering/README.md)：Movie Render Graph、Movie Render Queue、Render Pass、Lighting、Lumen、Material、Post Process 与渲染问题处理社区教程整理。
- [Character/Animation 补充专题](Supplemental/characteAndAnimation/README.md)：Control Rig、Motion Matching、Chaos Cloth、MetaHuman、Mutable、Live Link、Mocap、Mass/Crowds、Skeletal Mesh 与角色动画社区教程整理。
- [World Creation 补充专题](Supplemental/worldCreation/README.md)：World Partition、HLOD、Level Streaming、Landscape、Water、Dataprep、Datasmith、RealityCapture、建筑建模、样条与世界构建社区教程整理。
- [Programming/Scripting 补充专题](Supplemental/programmingAndScripting/README.md)：Blueprint/C++、K2Node、Editor Utility、Enhanced Input、Gameplay Tags、插件、Pak、保存/归档与调试工作流社区教程整理。
- [Platforms/Builds 补充专题](Supplemental/PlatformsAndBuilds/README.md)：Packaging、Cooking、DLC、UBA、Horde、Linux/Windows/移动端与跨平台部署社区教程整理。
- [Pipeline/Plugins 补充专题](Supplemental/pipelineAndPlugins/README.md)：插件打包、跨版本编译、UnrealBuildTool packaging crash、Interchange/gLTF 管线、NNE、Editor Utility Widget、编辑器工具扩展和自定义窗口社区教程整理。
- [Asset Creation 补充专题](Supplemental/assetCreation/README.md)：导入、资产工具、插件/内容排除、运行时资产处理与内容制作管线社区教程整理。
- [Audio 补充专题](Supplemental/audio/README.md)：MetaSound、Sound Cue、Audio Listener、音乐节点、生成器节点与 C++ MetaSound 节点工作流社区教程整理。
- [Cinematics/Media 补充专题](Supplemental/cinematicsAndMedia/README.md)：Sequencer、Level Sequence、Movie Render Queue、nDisplay、ICVFX、Virtual Camera、Media Capture、SMPTE 2110、Switchboard 与 Twinmotion 虚拟摄影机流程社区教程整理。
- [转换报告](UE5_7Doc/conversion-report.json)：转换统计、图片筛选和链接修复结果。

## 机器入口

- [KB manifest](../kb-manifest.json)：kbCli 的主入口。
- `content/markdown/`：派生 Markdown mirror。
- `chunks/chunks.jsonl`：chunk 级证据。
- `indexes/fts.sqlite`：当前 portable FTS 索引。
