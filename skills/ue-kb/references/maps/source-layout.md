# 来源结构

[Reference 入口](../index.md) / [主题地图](topic-map.md) / [Markdown 文档集入口](../UE5_7Doc/index.md)

## 官方文档

`UE5_7Doc/docs/` 按 Epic 官方文档面包屑结构重建，目录名使用英文或 ASCII-safe slug。`docs/<topic>/index.md` 是主题入口，子目录保留官方主题层级；不会再使用 `section-*` 这类哈希目录。

| Directory | Topic | Pages |
| --- | --- | ---: |
| [docs](../UE5_7Doc/docs/index.md) | 虚幻引擎5.7文档根页 | 1 |
| [get-started](../UE5_7Doc/docs/get-started/index.md) | 入门指南 | 100 |
| [gameplay-tutorials](../UE5_7Doc/docs/gameplay-tutorials/index.md) | Gameplay教程 | 12 |
| [gameplay-systems](../UE5_7Doc/docs/gameplay-systems/index.md) | Gameplay系统 | 343 |
| [blueprints-visual-scripting](../UE5_7Doc/docs/blueprints-visual-scripting/index.md) | 蓝图可视化脚本 | 86 |
| [cpp-programming](../UE5_7Doc/docs/cpp-programming/index.md) | 用C++编程 | 63 |
| [animating-characters-and-objects](../UE5_7Doc/docs/animating-characters-and-objects/index.md) | 为角色和对象制作动画 | 279 |
| [visual-effects](../UE5_7Doc/docs/visual-effects/index.md) | 创建视觉效果 | 64 |
| [user-interfaces](../UE5_7Doc/docs/user-interfaces/index.md) | 创建用户界面 | 72 |
| [designing-visuals-rendering-and-graphics](../UE5_7Doc/docs/designing-visuals-rendering-and-graphics/index.md) | 设计视觉、渲染和图形效果 | 183 |
| [building-virtual-worlds](../UE5_7Doc/docs/building-virtual-worlds/index.md) | 构建虚拟世界 | 190 |
| [working-with-audio](../UE5_7Doc/docs/working-with-audio/index.md) | 处理音频 | 69 |
| [working-with-media](../UE5_7Doc/docs/working-with-media/index.md) | 使用媒体 | 147 |
| [working-with-content](../UE5_7Doc/docs/working-with-content/index.md) | 管理内容 | 220 |
| [understanding-the-basics](../UE5_7Doc/docs/understanding-the-basics/index.md) | 理解基础知识 | 155 |
| [sharing-and-releasing-projects](../UE5_7Doc/docs/sharing-and-releasing-projects/index.md) | 分享和发布项目 | 142 |
| [mobile-development](../UE5_7Doc/docs/mobile-development/index.md) | 移动端开发 | 82 |
| [testing-and-optimizing-content](../UE5_7Doc/docs/testing-and-optimizing-content/index.md) | 测试并优化你的内容 | 61 |
| [production-pipeline](../UE5_7Doc/docs/production-pipeline/index.md) | 建立你的开发流程 | 155 |
| [samples-and-tutorials](../UE5_7Doc/docs/samples-and-tutorials/index.md) | 示例与教学 | 39 |
| [motion-design](../UE5_7Doc/docs/motion-design/index.md) | 动态设计 | 8 |
| [whats-new](../UE5_7Doc/docs/whats-new/index.md) | 新内容 | 5 |
| [unreal-engine-blueprint-api-reference](../UE5_7Doc/docs/unreal-engine-blueprint-api-reference/index.md) | Blueprint API Reference | 1 |
| [unreal-engine-c-api-reference](../UE5_7Doc/docs/unreal-engine-c-api-reference/index.md) | C++ API Reference | 1 |
| [unreal-engine-node-references](../UE5_7Doc/docs/unreal-engine-node-references/index.md) | Node References | 1 |
| [unreal-engine-python-api-documentation](../UE5_7Doc/docs/unreal-engine-python-api-documentation/index.md) | Python API Documentation | 1 |
| [unreal-engine-web-api-documentation](../UE5_7Doc/docs/unreal-engine-web-api-documentation/index.md) | Web API Documentation | 2 |

## 资源目录

- `../UE5_7Doc/assets/images/`：被 Markdown 保留引用的静态图片。
- `../UE5_7Doc/conversion-report.json`：转换统计、路径质量和资源筛选结果。
- GIF 和动画 WebP 默认不进入资源目录，正文以 `动图已省略` 或 `图片已省略` 保留语义提示。

## 补充知识卡

这些内容来自 `ue-engine-unified-kb/references/knowledge-cards` 中人工整理或工具汇总的非官方补充内容，不与官方文档目录混放。

| Directory | Topic |
| --- | --- |
| [Supplemental/Niagara](../Supplemental/Niagara/niagara.md) | Niagara System、Emitter、Module、Renderer、Event、Collision、Parameter、Scalability、调试、性能验证、内置模块整理和社区实践教程 |
| [Supplemental/Niagara/community-practice](../Supplemental/Niagara/community-practice/README.md) | Niagara Fluids、性能优化、Data Channels、HLSL/C++、Blueprint 集成、Cache/Sequencer、迁移和具体效果案例 |
| [Supplemental/Animation](../Supplemental/Animation/animation-ik.md) | Animation Blueprint、Montage、BlendSpace、IK Rig、Control Rig、Root Motion 和动画通知补充规则 |
| [Supplemental/PCG](../Supplemental/PCG/README.md) | PCG Blueprint Element、Compute Graph、Actor Tag、BiomeGenerator、样条房间、PVE 和技术美术实践补充专题 |
| [Supplemental/IntegratedTutorials](../Supplemental/IntegratedTutorials/README.md) | 综合型 UE 教程：跨 PCG、资产制作、材质、Landscape、Spline/Blueprint 工具、灯光、渲染和完整环境制作的端到端流程 |
| [Supplemental/LevelDesign](../Supplemental/LevelDesign/README.md) | Level Design、Whitebox、Blockout、关卡结构、自动化搭建、跨楼层连接、锁钥设计和常见结构错误补充规则 |
| [Supplemental/Rendering](../Supplemental/Rendering/README.md) | Epic Developer Community 渲染类社区教程整理和本地 TA 经验教程：Movie Render Graph、Movie Render Queue、Render Pass、Lighting、Lumen、Material、Substrate 水面、fake-normal 折射、Post Process、Custom Depth 和 GPU/PSO 问题处理 |
| [Supplemental/characteAndAnimation](../Supplemental/characteAndAnimation/README.md) | Epic Developer Community 角色与动画类社区教程整理：Control Rig、Motion Matching、Chaos Cloth、Panel Cloth、MetaHuman、Mutable、Live Link、Mocap、Mass/Crowds、Skeletal Mesh 和相关技术说明 |
| [Supplemental/worldCreation](../Supplemental/worldCreation/README.md) | Epic Developer Community 世界构建类社区教程整理：World Partition、HLOD、Level Streaming、Landscape、Water、Dataprep、Datasmith、RealityCapture/RealityScan、建筑建模、样条、动态天气和编辑器可视化 |
| [Supplemental/programmingAndScripting](../Supplemental/programmingAndScripting/README.md) | Epic Developer Community 编程与脚本类社区教程整理：Blueprint/C++、K2Node、Editor Utility、Enhanced Input、Gameplay Tags、插件、Pak、保存/归档和调试工作流 |
| [Supplemental/PlatformsAndBuilds](../Supplemental/PlatformsAndBuilds/README.md) | Epic Developer Community 平台、构建、打包和发布类社区教程整理：Packaging、Cooking、DLC、UBA、Horde、Linux/Windows/移动端和跨平台部署 |
| [Supplemental/pipelineAndPlugins](../Supplemental/pipelineAndPlugins/README.md) | Epic Developer Community 管线与插件类社区教程整理：插件打包、跨版本编译、UnrealBuildTool packaging crash、Interchange/gLTF 管线、NNE、Editor Utility Widget、编辑器工具扩展和自定义窗口 |
| [Supplemental/assetCreation](../Supplemental/assetCreation/README.md) | Epic Developer Community 资产创建与内容管线类社区教程整理：导入、资产工具、插件/内容排除、运行时资产处理和制作流程 |
| [Supplemental/audio](../Supplemental/audio/README.md) | Epic Developer Community 音频类社区教程整理：MetaSound、Sound Cue、Audio Listener、音乐节点、生成器节点和 C++ MetaSound 节点工作流 |
| [Supplemental/cinematicsAndMedia](../Supplemental/cinematicsAndMedia/README.md) | Epic Developer Community 影视与媒体类社区教程整理：Sequencer、Level Sequence、Movie Render Queue、nDisplay、ICVFX、Virtual Camera、Media Capture、SMPTE 2110、Switchboard 和 Twinmotion 虚拟摄影机流程 |
