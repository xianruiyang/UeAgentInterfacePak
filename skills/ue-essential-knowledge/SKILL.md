---
name: ue-essential-knowledge
description: Unreal Engine 关键基础知识与设计原理。用于需要理解 UE 概念、关卡与场景设计、白盒与资产替换、游戏框架、Blueprint、UI、材质、Niagara、动画、渲染或调试机制时；按问题选读，不承载工具命令或项目操作流程。
---

# UE Essential Knowledge

这里维护跨项目可复用的 UE 关键基础知识，以及在 UE 中制作内容所需的设计原理。正文解释概念、因果、取舍和适用条件；不规定代理的工作轮次、文件格式、工具调用或固定执行步骤。

## 按需选读

已有知识足以支持当前判断时直接使用；缺少某个概念或关系时，只读对应条目。跨系统任务按实际依赖选读，没有统一的阅读顺序。工具使用交给对应操作 skill，知识正文不维护第二套操作规范。

## 阅读入口

| 知识范围 | 入口 |
| --- | --- |
| 知识、设计经验与项目事实的区别 | [阅读总则](references/00-reading-guide/index.md) |
| UObject、World、Actor、Component、反射与生命周期 | [核心概念](references/01-core-concepts/index.md) |
| 资产、包、引用、导入导出、保存与重定向器 | [编辑器与资产](references/02-editor-assets-content/index.md) |
| Blueprint、Graph、节点、Pin、编译与类 | [Blueprint 与节点图](references/03-blueprint-nodegraph/index.md) |
| 材质、着色、参数、UV 与编译 | [材质与着色](references/04-materials-shaders/index.md) |
| System、Emitter、Module、Renderer 与属性 | [Niagara](references/05-niagara-vfx/index.md) |
| Skeleton、动画、Control Rig、IK 与重定向 | [动画与 Control Rig](references/06-animation-controlrig/index.md) |
| 场景设计链、SVG多层图与原画、三阶段组织和部件边界、UE组装、尺度材质、叙事引导、碰撞通行、光照与视口 | [世界、关卡与渲染](references/07-world-level-rendering/index.md) |
| 日志、崩溃、CPU/GPU 性能与调试 | [性能与调试](references/08-performance-debugging/index.md) |
| C++、反射宏、模块、插件与 API | [C++ 与插件](references/09-cpp-plugins-api/index.md) |
| Pawn、控制、GameMode、机关状态、存档与重生 | [游戏框架与状态](references/10-gameplay-framework/index.md) |
| UMG 布局、容器与组件关系 | [UI 与 UMG](references/11-ui-umg-authoring/index.md) |

## 知识边界

- 引擎机制、设计启发式和项目约定分开表达。设计经验帮助作选择，不能自动变成强制门禁、统一尺寸或固定制作顺序。
- 涉及当前项目的角色能力、资产配置或实际结果时，以该项目事实为准；涉及版本差异和具体 API 时，按需使用 `ue-kb`、对应版本官方文档或引擎源码。
- 坐标转换、方向、净空或投影关系本身需要推理时，结合 `understand-space`；这里负责 UE 语义。
- 部分分类目前只有导航。条目未覆盖的问题继续查所属来源，不把目录列出的主题当成已经完整收录的知识。
