# Niagara Community Practice

本目录保存从 Epic Developer Community 离线网页整理出的 Niagara 社区教程、案例和实践笔记，作为 `../niagara.md` 与 UE 5.7 官方文档的补充来源。

使用原则：

- 官方文档仍是权威来源；本目录用于补充具体制作流程、实践经验和案例细节。
- 回答时应标注为 supplemental/community practice source。
- 低作用度或与官方文档重复过多的页面未纳入本目录；筛选依据记录在 `docs/niagara-community-docs-usefulness-analysis.md`。
- 图片统一放在 `assets/images/`，文档内使用相对路径引用。

## Topic Folders

- [Fluids](fluids/)：Niagara Fluids、3D Gas、火焰和烟气等体积类效果实践。
- [Performance](performance/)：Scalability、Effect Type、性能测量、系统复用和大量粒子渲染实践。
- [Data Channels](data-channels/)：Niagara Data Channel 的概念、版本变化和最小示例。
- [Scripting](scripting/)：HLSL、C++、Blueprint 粒子数据导出和运行时接口。
- [Advanced Simulation](advanced-simulation/)：重力、空间殖民、Marching Cubes、Procedural Mesh、海洋等高级模拟案例。
- [Blueprint Integration](blueprint-integration/)：通过 Blueprint 模块控制 Niagara 粒子和效果的实践。
- [Cache And Sequencer](cache-sequencer/)：Niagara Cache、Simulation Cache 与 Sequencer 结合使用。
- [Migration](migration/)：从 Unity Particle System / VFX Graph 迁移到 Unreal Niagara 的对照案例。
- [Effect Recipes](effect-recipes/)：烟雾、闪电、爆炸、碰撞、遮罩、翻页纹理等效果制作案例。
