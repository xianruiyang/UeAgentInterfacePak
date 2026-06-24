---
name: ue-essential-knowledge
description: Unreal Engine 重要知识阅读导航。用于在分析、设计、排查或实现 UE 任务前，按分类读取已组织的核心知识，包括核心概念、编辑器资产、Blueprint 与节点图、UI/UMG、材质与着色、Niagara、动画与 Control Rig、世界与渲染、性能调试、C++ 插件 API 和 UAI authoring 工作流。
---

# UE Essential Knowledge

这个 skill 是 UE 重要知识的阅读入口。内容按 `references/` 下的主题目录组织，每个目录负责一类可复用知识。它不直接替代项目读回、UAI 指令、UE 源码或正式命令文档；它负责帮助 Codex 先选择需要阅读的知识分类，再把通用知识与当前任务结合。

## 使用原则

1. 先判断任务属于哪类 UE 知识，再只读取相关分类文件。
2. 如果任务跨多个系统，按“核心概念 -> 具体系统 -> 调试/验证 -> UAI authoring”的顺序读取。
3. 如果涉及当前项目真实状态，必须回到 UeAgentInterface、本地资产读回、源码或正式文档确认；不要把本 skill 的通用知识当成项目当前事实。
4. 如果涉及空间、方向、坐标、transform、屏幕/世界/局部坐标，必须同时遵守 `understand-space` skill 的空间合同原则。
5. 如果涉及 UAI 结构化 JSON 的实现细节，优先读取本地项目代码、正式 UAI 文档和实测记录；本 skill 只提供背景与阅读路由。

## 目录结构

- `references/00-reading-guide/`：阅读总则，用于不确定应读取哪类知识时先定位。
- `references/01-core-concepts/`：UE 对象、世界、组件、反射、生命周期等核心概念。
- `references/02-editor-assets-content/`：Content Browser、资产、包、引用、导入导出、保存与重定向器。
- `references/03-blueprint-nodegraph/`：Blueprint、K2 节点、Pin、Graph、UMG/AnimBlueprint 节点查询。
- `references/04-materials-shaders/`：Material、Material Function、Shader、参数、UV、编译和着色问题。
- `references/05-niagara-vfx/`：Niagara System、Emitter、Module、Renderer、Event、Ribbon 和属性输入。
- `references/06-animation-controlrig/`：Skeleton、Animation Sequence、Control Rig、IK、Retarget、Sequencer 动画。
- `references/07-world-level-rendering/`：Level、Actor、Lighting、Camera、Post Process、Lumen、Nanite 和渲染视图。
- `references/08-performance-debugging/`：编译、日志、崩溃、性能、GPU/CPU profiling 和验证方法。
- `references/09-cpp-plugins-api/`：UE C++、Editor module、Plugin、反射宏、源码定位和 API 使用边界。
- `references/10-uai-authoring-workflow/`：UAI 命令、结构化 authoring、apply/readback、节点与模块查询流程。
- `references/11-ui-umg-authoring/`：UI/UMG 布局、容器、组件归属、空间验收和反复编辑流程。

## 输出要求

- 回答用户时先给结论，再说明引用了哪些分类知识。
- 如果知识文件还只是框架，明确说明“当前 skill 只有框架，具体条目待补充”，不要假装已经有完整知识库。
- 对不确定、版本相关或项目相关的内容，明确写出需要继续用 UE 源码、UAI 读回、官方文档或项目实测确认。
