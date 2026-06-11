# Rendering 补充专题

[Reference 入口](../../index.md) / [主题地图](../../maps/topic-map.md) / [来源结构](../../maps/source-layout.md)

此目录收纳与官方 UE 5.7 文档分离的 Unreal Engine 渲染类补充材料。内容来自 Epic Developer Community 社区教程整理，主要服务于具体制作流程、版本过渡、生产排查和案例检索。

## 子集

| Directory | Topic |
| --- | --- |
| [abc-no-overlap](abc-no-overlap/README.md) | Movie Render Graph、Movie Render Queue、Render Pass、Lighting、Lumen、Material、Substrate 水面、fake-normal 折射、Post Process、Custom Depth、GPU/PSO 问题处理和环境/水体等渲染案例 |

## 检索建议

- Movie Render Graph / MRG：同时保留 `Movie Render Graph`、`Movie Render Queue`、`Render Layer`、`Render Pass`、`Collection`、`Modifier` 等英文术语。
- 材质和后处理：同时使用 `Material`、`Substrate`、`Water Material`、`fake normal refraction`、`Post Process`、`Custom Depth`、`Stencil`、`Ambient Occlusion`、`Bokeh`。
- 光照和 Lumen：同时使用 `Lighting`、`Lumen`、`Nanite`、`Path Tracing`、`GPU Crash`、`PSO`。

补充材料用于扩展案例和社区实践；涉及版本敏感或官方 API 语义时，仍应优先 fetch 官方文档来源并与本目录交叉验证。
